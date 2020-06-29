import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';

enum DialogType { MessageDialog, Loading, OpenWithDialog }

Future<void> showAlertDialog(
    BuildContext context, DialogType type, String message,
    {List<Function> actions}) async {
      print('Hookeu');
      print(actions.toString());
  AlertDialog dialog;
  if (type == DialogType.MessageDialog)
    dialog = getMessageDialog(context: context, message: message);
  else if (type == DialogType.Loading)
    dialog = getLoadingDialog(message);
  else
   { 
     dialog = await getOpenWithDialog(context, actions[0]);
}
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return dialog;
    },
  );
}

AlertDialog getMessageDialog({BuildContext context, String message}) =>
    AlertDialog(
      content: Text(message),
      actions: <Widget>[
        FlatButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );

AlertDialog getLoadingDialog(String message) => AlertDialog(
      content: Row(children: [
        CircularProgressIndicator(),
        SizedBox(width: 50),
        Text(message)
      ]),
    );

Future<AlertDialog> getOpenWithDialog(BuildContext context, Function openMXPlayer) async {
  print('Hihgvgjjkhjkgk');
  bool hasMX;

  try {
    hasMX = await DeviceApps.isAppInstalled('com.mxtech.videoplayer.ad') || await DeviceApps.isAppInstalled('com.mxtech.videoplayer.pro');
  } catch(_) {
    hasMX = false;
  }

  return AlertDialog(
    content: Text('Download complete'),
    actions: <Widget>[
      FlatButton(
        child: Text('Dismiss'),
        onPressed: () {
         Navigator.pop(context);
        },
      ),
      if (hasMX)
        FlatButton(
          child: Text('Open with MX Player'),
          onPressed: () {
           openMXPlayer();
          },
        )
    ],
  );
}
