import 'package:animated_tree_view/tree_view/tree_node.dart';
import 'package:animated_tree_view/tree_view/tree_view.dart';
import 'package:animated_tree_view/tree_view/widgets/expansion_indicator.dart';
import 'package:animated_tree_view/tree_view/widgets/indent.dart';
import 'package:flutter/material.dart';
import 'package:remote_access/main.dart';
import 'package:remote_access/model/remote_access_device.dart';
import 'package:remote_access/services/api_service.dart';
import 'package:remote_access/utilities/palette.dart';

class GeographicDeviceTree extends StatefulWidget {
  const GeographicDeviceTree({super.key});

  @override
  State<GeographicDeviceTree> createState() => _GeographicDeviceTreeState();
}

class _GeographicDeviceTreeState extends State<GeographicDeviceTree> {
  late TreeNode<Explorable> geographicTree;
  @override
  void initState() {
    geographicTree = _getTreeStructure();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TreeView.simpleTyped<Explorable, TreeNode<Explorable>>(
      tree: geographicTree,
      showRootNode: true,
      expansionBehavior: ExpansionBehavior.scrollToLastChild,
      expansionIndicatorBuilder: (context, node) {
        if (node.isRoot) {
          return PlusMinusIndicator(
            tree: node,
            alignment: Alignment.centerLeft,
            color: Palette.kEurotech,
          );
        }

        return ChevronIndicator.rightDown(
          tree: node,
          alignment: Alignment.centerLeft,
          color: Palette.kEurotech,
        );
      },
      onTreeReady: (controller) {
        controller.expandAllChildren(geographicTree);
      },
      indentation: const Indentation(),
      builder:
          (context, node) => Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: ListTile(
              title: Text(
                node.data?.path == null
                    ? _getDDTitle(node.data!.device!)
                    : node.data!.path!,
              ),
              subtitle:
                  node.data?.path == null
                      ? Text(_getDDSubtitle(node.data!.device!))
                      : null,
              leading: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: node.icon,
              ),
            ),
          ),
    );
  }

  String _getDDSubtitle(RemoteAccessDevice rad) {
    return '${rad.account.name}/${rad.device.displayName != null ? rad.device.displayName! : rad.device.clientId}';
  }

  String _getDDTitle(RemoteAccessDevice rad) {
    return '${rad.downstreamDevice.name} (${rad.downstreamDevice.iPv4})';
  }

  TreeNode<Explorable> _getTreeStructure() {
    TreeNode<Explorable> result = TreeNode<Explorable>.root(
      data: Branch(path: 'World'),
    );

    List<RemoteAccessDevice> devices =
        getIt<ApiService>().getRemoteAccessDevices();
    for (RemoteAccessDevice rad in devices) {
      final parts = rad.downstreamDevice.namespace!.split('/');
      _insertIntoHierarchy(result, parts, rad);
    }

    return result;
  }

  void _insertIntoHierarchy(
    TreeNode<Explorable> currentNode,
    List<String> parts,
    RemoteAccessDevice rad,
  ) {
    if (parts.isEmpty) {
      return;
    }
    String fullPath = '';
    for (String s in parts) {
      fullPath += '$s/';
    }
    debugPrint('$fullPath (${rad.downstreamDevice.name})');

    final currentPart = parts.first;
    final remainingParts = parts.sublist(1);

    if (remainingParts.isEmpty) {
      for (final entity in currentNode.children.entries) {
        if (((entity.value) as TreeNode<Explorable>).data!.path ==
            currentPart) {
          entity.value.add(LeafNode(data: Leaf(device: rad)));
          return;
        }
      }
      final newNode = BranchNode(data: Branch(path: currentPart));
      currentNode.add(newNode);
      newNode.add(LeafNode(data: Leaf(device: rad)));
    } else {
      for (final entity in currentNode.children.entries) {
        if (((entity.value) as TreeNode<Explorable>).data!.path ==
            currentPart) {
          _insertIntoHierarchy(
            entity.value as TreeNode<Explorable>,
            remainingParts,
            rad,
          );
          return;
        }
      }
      TreeNode<Explorable> newNode = BranchNode(
        data: Branch(path: currentPart),
      );
      currentNode.add(newNode);
      _insertIntoHierarchy(newNode, remainingParts, rad);
    }
  }
}

extension on ExplorableNode {
  Icon get icon {
    if (isRoot) return const Icon(Icons.public, color: Palette.kEurotech);

    if (this is BranchNode) {
      if (isExpanded) {
        return const Icon(Icons.flag_circle_outlined, color: Palette.kEurotech);
      }
      return const Icon(Icons.flag_circle, color: Palette.kEurotech);
    }

    if (this is LeafNode) {
      return const Icon(Icons.factory, color: Palette.kEurotech);
    }

    return const Icon(Icons.build, color: Palette.kEurotech);
  }
}

abstract class Explorable {
  final String? path;
  final RemoteAccessDevice? device;

  Explorable({this.path, this.device});

  @override
  String toString() => device!.downstreamDevice.name;
}

class Branch extends Explorable {
  Branch({super.path, super.device});
}

class Leaf extends Explorable {
  Leaf({super.path, super.device});
}

typedef ExplorableNode = TreeNode<Explorable>;
typedef BranchNode = TreeNode<Branch>;
typedef LeafNode = TreeNode<Leaf>;
