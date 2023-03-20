import 'package:flutter/material.dart';

class alertBox extends StatelessWidget {
  const alertBox({Key? key});

  @override
  Widget build(BuildContext context) {
    // Return a placeholder widget for the build method.
    return SizedBox.shrink();
  }

  // Define a separate method for showing the dialog box.
  static Future<void> showAlertBox(
      BuildContext context, String title, String body) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(body),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
