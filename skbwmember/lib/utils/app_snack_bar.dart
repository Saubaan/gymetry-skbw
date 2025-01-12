import 'package:flutter/material.dart';

import '../theme/app_font.dart';


class AppSnackBar {

  static void showError(String message, context) {
    final theme = Theme.of(context).colorScheme;
    showCustomSnackBar(
      context,
      'Oops!',
      message,
      Icons.error,
      theme.error,
      theme.onError,
    );
  }

  static void showSuccess(String message, context) {
    showCustomSnackBar(
      context,
      'Success!',
      message,
      Icons.check_circle,
      Colors.green.shade600,
      Colors.white,
    );
  }

  static void showWarning(String message, context) {
    showCustomSnackBar(
      context,
      'Warning!',
      message,
      Icons.warning,
      Colors.orange.shade800,
      Colors.white,
    );
  }

  static void showInfo(String message, context) {
    showCustomSnackBar(
      context,
      'Information',
      message,
      Icons.info,
      Colors.grey.shade800,
      Colors.white,
    );
  }
}

showCustomSnackBar(BuildContext context, String title, String message, IconData icon, Color backgroundColor, Color textColor) {
  final sHeight = MediaQuery.of(context).size.height;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      clipBehavior: Clip.none,
      content: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: sHeight / 8,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(50),
                  blurRadius: 5,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Stack(
              children: [
                Container(
                  height: sHeight / 3,
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(25),
                    shape: BoxShape.circle,
                  ),
                ),
                Row(
                  children: [
                    SizedBox(width: 35),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              color: textColor,
                              fontSize: 20,
                              fontFamily: AppFont.primaryFont,
                            ),
                          ),
                          Text(
                            message,
                            style: TextStyle(
                              color: textColor,
                              fontSize: 12,
                              fontFamily: AppFont.primaryFont,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        },
                        icon: Icon(Icons.close, color: textColor)),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: -15,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: backgroundColor,
              ),
              child: Icon(
                icon,
                color: textColor,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
  );
}
