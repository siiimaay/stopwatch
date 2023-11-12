import 'package:flutter/material.dart';

import 'confirmation_dialog.dart';

class MenuItemPopup extends StatelessWidget {
  final Function()? onDelete;

  MenuItemPopup({required this.onDelete}) : super();

  PopupMenuItem<PopupMenuAction> _buildPopupMenuItem(String title,
      IconData iconData, PopupMenuAction action, BuildContext context) {
    return PopupMenuItem<PopupMenuAction>(
      value: action,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            title,
          ),
          const Spacer(),
          Icon(
            iconData,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<PopupMenuAction>(
      icon: const Icon(
        Icons.more_vert,
        size: 32,
      ),
      elevation: 2,
      offset: const Offset(0.0, 50),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8.0),
          bottomRight: Radius.circular(8.0),
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
      itemBuilder: (ctx) => [
        _buildPopupMenuItem(
          'Delete',
          Icons.delete,
          PopupMenuAction.DELETE,
          ctx,
        ),
      ],
      onSelected: (PopupMenuAction action) async {
        switch (action) {
          case PopupMenuAction.DELETE:
            showDialog(
              barrierColor: Colors.white.withOpacity(0),
              context: context,
              builder: (BuildContext context) {
                return ConfirmationDialog(
                  onConfirm: onDelete?.call(),
                  title: 'Do you want to delete?',
                  child: const Text("You cannot undo this action"),
                );
              },
            );
            break;
        }
      },
    );
  }
}

enum PopupMenuAction { DELETE }
