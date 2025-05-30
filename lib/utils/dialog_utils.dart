// import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:flutter/material.dart';

class DialogUtils {
  static void showLoading(
      {required BuildContext context, required String messsage}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Row(
              children: [
                const CircularProgressIndicator(),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(messsage),
                )
              ],
            ),
          );
        });
  }

  static void hideLoading({required BuildContext context}) {
  
    Navigator.pop(context);
  }

  static void showMessage(
      {required BuildContext context,
      required String message,
      String? title,
      String? posActionsName,
      String? negActionsName,
      Function? posAcitons,
      Function? negActions}) {
    List<Widget> actions = [];
    if (posActionsName != null) {
      actions.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
            posAcitons?.call();
          },
          child: Text(posActionsName)));
    }
    if (negActionsName != null) {
      actions.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
            negActions?.call();
          },
          child: Text(negActionsName)));
    }
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(message),
            title: Text(title ?? " "),
            actions: actions,
          );
        });
  }
}
