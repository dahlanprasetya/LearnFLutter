import 'package:flutter/material.dart';

class ConfirmationDialog {
  static Future<bool> show({
    required BuildContext context,
    String title = "Confirmation",
    String content = "Are you sure you want to proceed?",
    String confirmText = "Yes",
    String cancelText = "No",
    required bool isEnabled, //if false then the dialog won't show
  }) async {
    late bool? result;
    if (isEnabled) {
      result = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pop(true); // Returns true when confirmed.
                },
                child: Text(confirmText),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pop(false); // Returns false when canceled.
                },
                child: Text(cancelText),
              ),
            ],
          );
        },
      );
    } else {
      result = true;
    }
    return result ?? false;
  }
}