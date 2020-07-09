import 'package:flutter/material.dart';

class AlertBox extends AlertDialog {
  AlertBox({Widget title, Widget message, List<Widget> actions})
      : super(
          title: title,
          content: message,
          actions: actions,
        );
        
  factory AlertBox.loadingMessage() {
    return AlertBox(
      message: Row(
        children: [
          CircularProgressIndicator(),
          SizedBox(
            width: 15,
          ),
          Text('Loading')
        ],
      ),
    );
  }

  factory AlertBox.actionsMessage(String title, String message, List<Widget> actions) {
    return AlertBox(
      title: Text(title),
      message: Text(message),
      actions: actions,
    );
  }
}

