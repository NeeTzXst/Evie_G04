import 'package:flutter/material.dart';
import 'package:myapp/Screen/homePage.dart';
import 'package:myapp/Widget/styles.dart';

class qrCode extends StatefulWidget {
  const qrCode({super.key});

  @override
  State<qrCode> createState() => _qrCodeState();
}

class _qrCodeState extends State<qrCode> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);

    // Get screen width and height
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        // leading: GestureDetector(
        //   onTap: () {
        //     Navigator.of(context).pop();
        //   },
        //   child: Icon(
        //     Icons.arrow_back,
        //     size: 40,
        //     color: Color.fromRGBO(26, 116, 226, 1),
        //   ),
        // ),
        title: Text(
          "Park booking",
          style: headerText,
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 330,
                  height: 270,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    color: primaryColor,
                  ),
                  child: Text('data'),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 330,
                  height: 270,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    color: secondColor,
                  ),
                  child: Text('data'),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 140,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: secondColor,
                    ),
                    child: Center(
                        child: Text(
                      'Back',
                      style: BlueDisplay,
                    )),
                  ),
                ),
                Container(
                  width: 140,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: redColor,
                  ),
                  child: Center(
                      child: Text(
                    'Cencel',
                    style: TextDisplay,
                  )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
