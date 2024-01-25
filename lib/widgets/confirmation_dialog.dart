import 'package:flutter/material.dart';

Future<T?> showConfirmationDialog<T>({
  required BuildContext context,
  required String title,
  bool isDismissable = false,
  String? body,
  String? optionOne,
  VoidCallback? onOptionOne,
  String? optionTwo,
  VoidCallback? onOptionTwo,
  bool useRootNavigator = true,
}) async {
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: body == null ? null : Text(body),
    actions: [
      if (optionOne != null)
        TextButton(
          onPressed: onOptionOne ??
              () {
                Navigator.of(context).pop(false);
              },
          child: Text(optionOne),
        ),
      if (optionTwo != null)
        TextButton(
          onPressed: onOptionTwo,
          child: Text(optionTwo),
        ),
    ],
  );

  return await showDialog(
    context: context,
    barrierColor: Colors.black.withAlpha(50),
    barrierDismissible: isDismissable,
    builder: (BuildContext context) {
      return alert;
    },
    useRootNavigator: useRootNavigator,
  );
}
