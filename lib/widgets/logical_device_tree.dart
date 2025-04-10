import 'package:animated_tree_view/tree_view/tree_node.dart';
import 'package:animated_tree_view/tree_view/tree_view.dart';
import 'package:animated_tree_view/tree_view/widgets/expansion_indicator.dart';
import 'package:animated_tree_view/tree_view/widgets/indent.dart';
import 'package:flutter/material.dart';
import 'package:remote_access/model/configuration/downstream_device.dart';
import 'package:remote_access/model/ec_account.dart';
import 'package:remote_access/model/ec_device.dart';
import 'package:remote_access/utilities/palette.dart';

class LogicalDeviceTree extends StatelessWidget {
  const LogicalDeviceTree({super.key, required this.deviceTree});

  final TreeNode<dynamic> deviceTree;

  @override
  Widget build(BuildContext context) {
    return TreeView.simple(
      tree: deviceTree,
      onTreeReady: (controller) {
        controller.expandAllChildren(deviceTree, recursive: true);
      },
      indentation: Indentation(style: IndentStyle.roundJoint),
      showRootNode: true,
      shrinkWrap: true,
      expansionBehavior: ExpansionBehavior.collapseOthersAndSnapToTop,
      expansionIndicatorBuilder: (context, node) {
        return ChevronIndicator.rightDown(
          tree: node,
          alignment: Alignment.centerLeft,
          color: Palette.kEurotech,
        );
      },
      builder: (context, item) {
        String title;
        String subtitle;
        bool visible;
        Widget leading;
        Color cardColor;
        if (item.data is EcAccount) {
          title = (item.data as EcAccount).name;
          subtitle = (item.data as EcAccount).parentAccountPath;
          visible = (item.data as EcAccount).visibleInUi!;
          leading = Icon(Icons.account_tree);
          cardColor = Palette.kEurotech.shade600;
        } else if (item.data is EcDevice) {
          String status = (item.data as EcDevice).connection!.status!;
          title =
              '${(item.data as EcDevice).clientId} ${(item.data as EcDevice).displayName != null ? '(${(item.data as EcDevice).displayName!})' : ''} - $status';
          subtitle =
              (item.data as EcDevice).applicationIdentifiers != null
                  ? (item.data as EcDevice).applicationIdentifiers!
                  : '';
          visible = (item.data as EcDevice).visibleInUi!;
          leading = Icon(Icons.router);
          cardColor = Palette.kEurotech.shade700;
        } else {
          title =
              '${(item.data as DownstreamDevice).name} (${(item.data as DownstreamDevice).type})';
          subtitle = (item.data as DownstreamDevice).iPv4;
          visible = true;
          leading = Icon(Icons.settings_input_component);
          cardColor = Palette.kEurotech.shade800;
        }

        return Visibility(
          visible: visible,
          child: Card(
            //elevation: 8.0,
            color: cardColor,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: ListTile(
                leading: leading,
                title: Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(subtitle),
              ),
            ),
          ),
        );
      },
    );
  }
}
