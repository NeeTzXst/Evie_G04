import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Screen/homePage.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:myapp/Widget/styles.dart';

class qrCode extends StatefulWidget {
  final bookingId;
  final duration;
  final stationID;
  var type;
  var spotSlot;
  var StationName;
  qrCode(
      {super.key,
      this.bookingId,
      this.duration,
      this.stationID,
      this.type,
      this.spotSlot,
      this.StationName});

  @override
  State<qrCode> createState() => _qrCodeState();
}

String get userUID {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    return 'No user';
  } else {
    return user.uid;
  }
}

class _qrCodeState extends State<qrCode> {
  Future<String?> getname() async {
    final db = FirebaseFirestore.instance;
    var docRef = db.collection('/app/member/ID').doc(userUID);
    log('User ID : ' + userUID);
    try {
      log('try');
      var doc = await docRef.get();
      if (doc.exists) {
        log('if');
        var data = doc.data()!;
        String name = data['Fullname'];
        return name;
      } else {
        print("Document does not exist");
        return null;
      }
    } catch (error) {
      print(error);
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    log('UserUID : ' + userUID);
    log('Type : ' + widget.type);
    log('bookingId : ' + widget.bookingId.toString());
    log('stationID : ' + widget.stationID.toString());
    log('spotSlot : ' + widget.spotSlot.toString());
  }

  @override
  Widget build(BuildContext context) {
    num totalDuration = widget.duration / 60;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        title: Text(
          widget.type + ' Booking',
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
                      '0' +
                          widget.spotSlot.toString() +
                          ' ' +
                          widget.type +
                          ' Spot',
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
                      FutureBuilder<String?>(
                          future: getname(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (snapshot.hasData) {
                              String names = snapshot.data!;
                              return Padding(
                                padding: const EdgeInsets.only(
                                  top: 22,
                                  left: 20,
                                ),
                                child: Text(names, style: BlueDisplayBold),
                              );
                            } else {
                              return Text('No data');
                            }
                          }),
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
                          top: 10,
                          left: 10,
                        ),
                        child: Text(widget.StationName, style: BlueDisplayBold),
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
                        child: Text('Duration', style: TextDisplay),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 13,
                          left: 10,
                        ),
                        child: Text(
                            (totalDuration.toStringAsFixed(2)).toString() +
                                ' hours',
                            style: BlueDisplayBold),
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
