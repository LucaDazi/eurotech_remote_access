import 'package:flutter/material.dart';
import 'package:remote_access/main.dart';
import 'package:remote_access/model/credentials.dart';
import 'package:remote_access/model/ec_user.dart';
import 'package:remote_access/services/api_service.dart';
import 'package:remote_access/services/crypto_service.dart';
import 'package:remote_access/widgets/center_card.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _filterController = TextEditingController();

  bool _isUpdating = false;
  final Set<int> _hoveredIndices = {}; // Track hovered indices

  @override
  void dispose() {
    _displayNameController.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _filterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Card(
                    margin: EdgeInsets.only(left: 16, right: 8, bottom: 8),
                    child: DefaultTextStyle(
                      style: DefaultTextStyle.of(
                        context,
                      ).style.copyWith(fontSize: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Remote Access Users management',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('Subtitle'),
                            SizedBox(width: double.infinity),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.only(left: 16, right: 8, bottom: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('Currently available remote users'),
                              SizedBox(width: 32.0),
                              ElevatedButton.icon(
                                onPressed: () async {
                                  await _createNewUser();
                                },
                                icon: Icon(Icons.add),
                                label: Text('Add new user'),
                              ),
                              Expanded(child: Container()),
                              SizedBox(
                                width: 200,
                                height: 40,
                                child: TextField(
                                  controller: _filterController,
                                  onChanged: (value) {
                                    setState(
                                      () {},
                                    ); // Implement filter logic here
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Filter',
                                    prefixIcon: Icon(Icons.search),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.0, width: double.infinity),
                          FutureBuilder(
                            future: getIt<ApiService>().getUsers(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return CircularProgressIndicator();
                              } else {
                                if (snapshot.hasError) {
                                  return CenterCard(
                                    label: 'Error: ${snapshot.error}',
                                  );
                                }
                                if (snapshot.data == null) {
                                  return CenterCard(label: 'No data available');
                                }
                                if (snapshot.data!.isEmpty) {
                                  return CenterCard(
                                    label: 'No remote users available',
                                  );
                                }
                                List<EcUser> users = snapshot.data!;
                                if (_filterController.text.isNotEmpty) {
                                  users =
                                      snapshot.data!.where((user) {
                                        return user.name.contains(
                                              _filterController.text,
                                            ) ||
                                            user.displayName!.contains(
                                              _filterController.text,
                                            ) ||
                                            user.email!.contains(
                                              _filterController.text,
                                            );
                                      }).toList();
                                }
                                if (users.isEmpty) {
                                  return CenterCard(
                                    label:
                                        'No remote user matches filter criteria',
                                  );
                                }
                                return Column(
                                  children: [
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: ClampingScrollPhysics(),
                                      itemCount: users.length,
                                      itemBuilder: (context, index) {
                                        final item = users[index];
                                        final isHovered = _hoveredIndices
                                            .contains(index);
                                        return Card(
                                          elevation: 8.0,
                                          clipBehavior: Clip.hardEdge,
                                          child: MouseRegion(
                                            onEnter: (event) {
                                              setState(() {
                                                _hoveredIndices.add(index);
                                              });
                                            },
                                            onExit: (event) {
                                              setState(() {
                                                _hoveredIndices.remove(index);
                                              });
                                            },
                                            child: InkWell(
                                              onTap: () {},
                                              child: Column(
                                                children: [
                                                  ListTile(
                                                    leading: Icon(Icons.person),
                                                    title: Text(
                                                      item.name.replaceFirst(
                                                        'RA_',
                                                        '',
                                                      ),
                                                    ),
                                                    subtitle: Text(
                                                      item.displayName != null
                                                          ? '${item.displayName!} (${item.email})}'
                                                          : '',
                                                    ),
                                                  ),
                                                  if (isHovered)
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                            8.0,
                                                          ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          ElevatedButton.icon(
                                                            onPressed: () async {
                                                              await _generateApiKey(
                                                                context,
                                                                item,
                                                              );
                                                            },
                                                            label:
                                                                _isUpdating
                                                                    ? CircularProgressIndicator()
                                                                    : Icon(
                                                                      Icons.key,
                                                                    ),
                                                          ),
                                                          SizedBox(width: 8.0),
                                                          ElevatedButton.icon(
                                                            onPressed:
                                                                _isUpdating
                                                                    ? null
                                                                    : () async {
                                                                      await _updateUserData(
                                                                        context,
                                                                        item,
                                                                      );
                                                                    },
                                                            label:
                                                                _isUpdating
                                                                    ? CircularProgressIndicator()
                                                                    : Icon(
                                                                      Icons
                                                                          .edit,
                                                                    ),
                                                          ),
                                                          SizedBox(width: 8.0),
                                                          ElevatedButton.icon(
                                                            onPressed:
                                                                _isUpdating
                                                                    ? null
                                                                    : () async {
                                                                      await _deleteUser(
                                                                        context,
                                                                        item.id,
                                                                      );
                                                                    },
                                                            label:
                                                                _isUpdating
                                                                    ? CircularProgressIndicator()
                                                                    : Icon(
                                                                      Icons
                                                                          .delete,
                                                                    ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      height: 16.0,
                                      width: double.infinity,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Displaying ${users.length} of ${snapshot.data!.length} users',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        ElevatedButton.icon(
                                          onPressed: () async {
                                            await _createNewUser();
                                          },
                                          icon: Icon(Icons.add),
                                          label: Text('Add new user'),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _createNewUser() async {
    EcUser user = EcUser(
      type: 'user',
      id: '0',
      scopeId: '0',
      createdOn: DateTime.now(),
      createdBy: '0',
      modifiedOn: DateTime.now(),
      modifiedBy: '0',
      optlock: 0,
      name: 'RA_',
      displayName: null,
      email: null,
      expirationDate: null,
      status: 'ENABLED',
      userType: 'INTERNAL',
    );
    var result = await _showInformationDialog(context, user, true);
    if (result != user) {
      setState(() {
        _isUpdating = true;
      });
      await getIt<ApiService>().createNewUser(result);
      setState(() {
        _isUpdating = false;
      });
    }
  }

  Future<void> _deleteUser(BuildContext context, String id) async {
    setState(() {
      _isUpdating = true;
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Delete"),
          content: Text("Are you sure you want to delete this user?"),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _isUpdating = false;
                });
              },
            ),
            TextButton(
              child: Text("Delete"),
              onPressed: () async {
                Navigator.of(context).pop();
                bool result = await getIt<ApiService>().deleteUser(id);
                if (!result) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to delete user')),
                    );
                  }
                }
                setState(() {
                  _isUpdating = false;
                });
              },
            ),
          ],
        );
      },
    );

    setState(() {
      _isUpdating = false;
    });
  }

  Future<void> _updateUserData(BuildContext context, EcUser item) async {
    var result = await _showInformationDialog(context, item, false);
    debugPrint('${result == item}');
    if (result != item) {
      setState(() {
        _isUpdating = true;
      });
      await getIt<ApiService>().updateUserData(result);
      setState(() {
        _isUpdating = false;
      });
    }
  }

  Future<void> _generateApiKey(BuildContext context, EcUser user) async {
    setState(() {
      _isUpdating = true;
    });
    Credentials credResult = await getIt<ApiService>().generateApiKey(user);
    setState(() {
      _isUpdating = false;
    });
    String token = await getIt<CryptoService>().generateActivationToken(
      credResult.apiKey,
      credResult.user.name,
      credResult.pwd,
    );

    if (context.mounted) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Credentials'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      'API Key: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SelectableText(
                      credResult.apiKey.isEmpty
                          ? 'NO API KEY GENERAETD'
                          : credResult.apiKey,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Password: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SelectableText(
                      credResult.pwd.isEmpty
                          ? 'NO PASSWORD GENERAETD'
                          : credResult.pwd,
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email token: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Flexible(child: SelectableText(token)),
                  ],
                ),
              ],
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<EcUser> _showInformationDialog(
    BuildContext context,
    EcUser user,
    bool createNewUser,
  ) async {
    return await showDialog(
      context: context,
      builder: (context) {
        _displayNameController.text = user.displayName ?? '';
        _emailController.text = user.email ?? '';
        _nameController.text = user.name.replaceFirst('RA_', '');
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              content: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (createNewUser)
                      TextFormField(
                        controller: _nameController,
                        validator: (value) {
                          return value!.isNotEmpty ? null : "Enter any text";
                        },
                        decoration: InputDecoration(hintText: "User name"),
                      ),
                    TextFormField(
                      controller: _displayNameController,
                      validator: (value) {
                        return value!.isNotEmpty ? null : "Enter any text";
                      },
                      decoration: InputDecoration(
                        hintText: "User display name",
                      ),
                    ),
                    TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        String pattern =
                            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
                        RegExp regex = RegExp(pattern);
                        if (value == null || !regex.hasMatch(value)) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                      decoration: InputDecoration(hintText: "User email"),
                    ),
                  ],
                ),
              ),
              title: Text(
                createNewUser
                    ? 'New Remote User'
                    : user.name.replaceFirst('RA_', ''),
              ),
              actions: <Widget>[
                ElevatedButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop(user);
                  },
                ),
                ElevatedButton(
                  child: Text('Confirm'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // Do something like updating SharedPreferences or User Settings etc.
                      Navigator.of(context).pop(
                        user.copyWith(
                          name: 'RA_${_nameController.text}',
                          displayName: _displayNameController.text,
                          email: _emailController.text,
                        ),
                      );
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
