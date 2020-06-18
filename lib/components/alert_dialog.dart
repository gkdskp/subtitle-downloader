import 'package:flutter/material.dart';

enum DialogType {
  MessageDialog,
  Loading
}

Future<void> showMyDialog(BuildContext context, DialogType type, String message,
    {List<Widget> actions}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      if(type == DialogType.MessageDialog)
        return getMessageDialog(context: context, message: message, actions: actions);
      else 
        return getLoadingDialog(message);
    },
  );
}

AlertDialog getMessageDialog(
        {BuildContext context, String message, List<Widget> actions}) =>
    AlertDialog(
      content: Text(message),
      actions: (actions != null)
          ? actions
          : <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
    );

AlertDialog getLoadingDialog(String message) => AlertDialog(
      content:Row(children: [
            CircularProgressIndicator(),
            SizedBox(width: 50),
            Text(
              message
            )
      ]),
    );

