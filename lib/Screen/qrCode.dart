// ignore_for_file: prefer_const_constructors, camel_case_types, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:myapp/Screen/homePage.dart';
import 'package:qr/qr.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:myapp/Widget/styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: qrCode(),
    );
  }
}

class qrCode extends StatefulWidget {
  const qrCode({super.key});

  @override
  State<qrCode> createState() => _qrCodeState();
}

class _qrCodeState extends State<qrCode> {
  @override
  Widget build(BuildContext context) {
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
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 320,
              height: 280,
              decoration: BoxDecoration(
                color: Color.fromRGBO(63, 160, 239, 1),
                borderRadius: BorderRadius.all(Radius.circular(35.0)),
              ),
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "02 Parking Spot",
                      style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontWeight: FontWeight.w400,
                          fontFamily: "Montserrat",
                          fontStyle: FontStyle.normal,
                          fontSize: 24.0),
                    ),
                  ),
                  Container(
                    width: 230,
                    height: 230,
                    child: QrImage(
                      version: QrVersions.auto,
                      data: "1234567890",
                      padding: EdgeInsets.all(25),
                      foregroundColor: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 320,
              height: 280,
              decoration: BoxDecoration(
                color: Color.fromRGBO(107, 207, 255, 0.8),
                borderRadius: BorderRadius.all(Radius.circular(35.0)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 22,
                          left: 20,
                        ),
                        child: Text("Name", style: TextDisplay),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 22,
                          left: 10,
                        ),
                        child: Text("ToonMaiRu", style: BlueDisplayBold),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 13,
                          left: 20,
                        ),
                        child: Text("Area", style: TextDisplay),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 13,
                          left: 10,
                        ),
                        child:
                            Text("KU Charging Station", style: BlueDisplayBold),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 13,
                          left: 20,
                        ),
                        child: Text("Duration", style: TextDisplay),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 13,
                          left: 10,
                        ),
                        child: Text("1 hours", style: BlueDisplayBold),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 13,
                          left: 20,
                        ),
                        child: Text("Time", style: TextDisplay),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 13,
                          left: 10,
                        ),
                        child: Text("09am - 10am", style: BlueDisplayBold),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 13,
                          left: 20,
                        ),
                        child: Text("Vehicle", style: TextDisplay),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 13,
                          left: 10,
                        ),
                        child: Text("Ford", style: BlueDisplayBold),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 13,
                          left: 20,
                        ),
                        child: Text("Date", style: TextDisplay),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 13,
                          left: 10,
                        ),
                        child: Text("16 Dec 2099", style: BlueDisplayBold),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 13,
                          left: 20,
                        ),
                        child: Text("Phone", style: TextDisplay),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 13,
                          left: 10,
                        ),
                        child: Text("012-345-6789", style: BlueDisplayBold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Align(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Padding(
                //   padding: const EdgeInsets.only(
                //     left: 10,
                //   ),
                // ),
                Container(
                    width: 120,
                    height: 52,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: Color.fromRGBO(107, 207, 255, 0.6),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: <Widget>[
                          TextButton(
                            child: Text("Back", style: BlueDisplayBold),
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => homePage()));
                            },
                          ),
                        ])),
                SizedBox(
                  width: 20,
                ),
                Container(
                  width: 120,
                  height: 52,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Color.fromRGBO(255, 107, 107, 0.6),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: <Widget>[
                      TextButton(
                          child: Text("Cancel", style: TextDisplay),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor:
                                      Color.fromARGB(255, 243, 100, 112),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                  title: Center(
                                    child: Text('Are you sure ?',
                                        style: TextDisplay),
                                  ),
                                  content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        Text(
                                          "If you cancel your booking, your ",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        Text(
                                          " payment will not be refunded.",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ]),
                                  actions: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        width: 200,
                                        height: 52,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8.0)),
                                            color: Color.fromRGBO(
                                                255, 255, 255, 1)),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            // ignore: prefer_const_literals_to_create_immutables
                                            children: <Widget>[
                                              TextButton(
                                                child: Text("Confirm",
                                                    style: TextDisplay),
                                                onPressed: () {},
                                              )
                                            ]),
                                      ),
                                    )
                                  ],
                                );
                              },
                            );
                          })
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
