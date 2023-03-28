import 'package:flutter/material.dart';
import 'package:myapp/Widget/styles.dart';

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

  static Future<void> showFullStationBox(BuildContext context, String body) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: redColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          content: Container(
            height: 70.0,
            width: 287.0,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.close_rounded,
                      size: 30,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    body,
                    style: StationFull,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
