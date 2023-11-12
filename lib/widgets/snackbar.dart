import 'package:flutter/material.dart';

class TopSnackBarOverlay {
  static OverlayEntry? _overlayEntry;

  static void showTopSnackbar({
    required BuildContext context,
    required String message,
    required IconData icon,
    double duration = 2,
    Color backgroundColor = Colors.white,
    TextStyle textStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
  }) async {
    _overlayEntry?.remove();
    _overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        top: MediaQuery.of(context).padding.top + 5,
        left: 10,
        right: 10,
        child: SafeArea(
          child: Material(
            child: Container(
              height: 75,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Icon(
                      icon,
                      color: Colors.white,
                      weight: 10,
                    ),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        message,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
    if (_overlayEntry != null) {
      Overlay.of(context).insert(_overlayEntry!);
    }
    await Future.delayed(Duration(seconds: duration.toInt()));
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
