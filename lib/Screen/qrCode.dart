import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Screen/homePage.dart';
import 'package:myapp/Screen/timeRemining.dart';
import 'package:myapp/flutter_flow/flutter_flow_util.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:myapp/Widget/styles.dart';

class qrCode extends StatefulWidget {
  final bookingId;
  final duration;
  final stationID;
  var type;
  var spotSlot;
  var StationName;
  var date;
  var start;
  var end;
  var spotID;
  var userBookID;
  var selectedCar;
  qrCode(
      {super.key,
      this.bookingId,
      this.duration,
      this.stationID,
      this.type,
      this.spotSlot,
      this.StationName,
      this.date,
      this.start,
      this.end,
      this.spotID,
      this.userBookID,
      this.selectedCar});

  @override
  State<qrCode> createState() => _qrCodeState();
}

class _qrCodeState extends State<qrCode> {
  String get userUID {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return 'No user';
    } else {
      return user.uid;
    }
  }

  Future<void> checkIn() async {
    log('stationID : ' + widget.stationID.toString());
    log('spotID : ' + widget.spotID.toString());
    log("User ID : " + userUID);
    CollectionReference check = FirebaseFirestore.instance.collection(
        '/web/owner/charging Station/${widget.stationID}/charging Spot/${widget.spotID}/booking');

    QuerySnapshot checkqr = await check.where('uid', isEqualTo: userUID).get();

    if (checkqr.docs.isNotEmpty) {
      final bookingDocSnapshot = checkqr.docs.first;
      final bookingData = bookingDocSnapshot.data();
      log(bookingData.toString());

      final bookingStartTime = bookingDocSnapshot['startTime'];
      final bookingEndTime = bookingDocSnapshot['endTime'];
      final currentTime = DateTime.now();
      final currentTimeString = DateFormat('hh:mm a').format(currentTime);
      final currentTimeDateTime =
          DateFormat('hh:mm a').parse(currentTimeString);
      final bookingStartDateTime =
          DateFormat('hh:mm a').parse(bookingStartTime);
      final bookingEndDateTime = DateFormat('hh:mm a').parse(bookingEndTime);

      if ((currentTimeDateTime.isAfter(bookingStartDateTime) &&
              currentTimeDateTime.isBefore(bookingEndDateTime) ||
          currentTimeDateTime == bookingStartDateTime)) {
        log("มาทัน");
        FirebaseFirestore.instance
            .collection(
                '/web/owner/charging Station/${widget.stationID}/charging Spot/')
            .doc(widget.spotID)
            .update({'status': "false"}).then((value) {
          //Navigator.of(context).pop();
        }).catchError((error) {
          print("Failed to update charging spot: $error");
        });
        // Show "Welcome to Spot" dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Welcome to Spot',
                style: TextStyle(
                    color: Colors.green, fontWeight: FontWeight.bold)),
            content: Text('Your booking is valid at this time.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => timeRemining(),
                  ),
                ),
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else if (currentTimeDateTime == bookingEndDateTime) {
        log("มาสายเกิน");
        // Show "Sorry" dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Sorry,your can't come to the spot",
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            content: Text('Your booking is late at this time.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        log("ยังไม่ถึงเวลาที่จอง");
        // Show "Not your time" dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Not your time',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            content: Text('Your booking is not valid at this time.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } else {
      // Show "Didn't find your booking" dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Didn't find your booking"),
          content: Text('Please check your UID and try again.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Future<Map<String, dynamic>?> getUser() async {
    final db = FirebaseFirestore.instance;
    var docRef = db.collection('/app/member/ID').doc(userUID);
    log('User ID : ' + userUID);
    try {
      log('try');
      var doc = await docRef.get();
      if (doc.exists) {
        log('if');
        var data = doc.data()!;
        return data;
      } else {
        log("Document does not exist");
        return null;
      }
    } catch (error) {
      log(error.toString());
      return null;
    }
  }

  Future<void> deleteBooking() async {
    log('WAIT TO DELETE ALL BOOKING');
    CollectionReference webBookingsRef = FirebaseFirestore.instance.collection(
        '/web/owner/charging Station/${widget.stationID}/charging Spot/${widget.spotID}/booking');

    CollectionReference userBookingsRef = FirebaseFirestore.instance
        .collection('/app/member/ID/$userUID/Booking');

    log('bookingId : ' + widget.bookingId);
    log('userBookID : ' + widget.userBookID);
    log('stationID : ' + widget.stationID);
    log('widget.spotID : ' + widget.spotID);
    try {
      log('try');
      log('webBookingsRef : ' + webBookingsRef.toString());
      await webBookingsRef.doc(widget.bookingId).delete().whenComplete(() {
        FirebaseFirestore.instance
            .collection(
                '/web/owner/charging Station/${widget.stationID}/charging Spot/')
            .doc(widget.spotID)
            .update({'status': "true"});
        log('DELETE WEB BOOKING');
      });
      await userBookingsRef.doc(widget.userBookID).delete().whenComplete(() {
        log('DELETE USER BOOKING');
      });
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    // log('UserUID : ' + userUID);
    // log('Type : ' + widget.type);
    // log('bookingId : ' + widget.bookingId.toString());
    // log('stationID : ' + widget.stationID.toString());
    // log('spotSlot : ' + widget.spotSlot.toString());
    // log('userBook ID: ' + widget.userBookID);
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
                      data: "$userUID",
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
                      FutureBuilder<Map<String, dynamic>?>(
                        future: getUser(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.hasData) {
                            Map<String, dynamic> names = snapshot.data!;
                            return Padding(
                              padding: const EdgeInsets.only(
                                top: 22,
                                left: 13,
                              ),
                              child: Text(names['Fullname'],
                                  style: BlueDisplayBold),
                            );
                          } else {
                            return Text('No data');
                          }
                        },
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
                        child: Text("${widget.start} - ${widget.end}",
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
                        child: Text("Vehicle", style: TextDisplay),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 13,
                          left: 10,
                        ),
                        child: Text(widget.selectedCar, style: BlueDisplayBold),
                      )
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
                        child: Text(widget.date, style: BlueDisplayBold),
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
                      FutureBuilder<Map<String, dynamic>?>(
                        future: getUser(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.hasData) {
                            Map<String, dynamic> names = snapshot.data!;
                            return Padding(
                              padding: const EdgeInsets.only(
                                top: 13,
                                left: 12,
                              ),
                              child:
                                  Text(names['Phone'], style: BlueDisplayBold),
                            );
                          } else {
                            return Text('No data');
                          }
                        },
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // Padding(
                //   padding: const EdgeInsets.only(
                //     left: 10,
                //   ),
                // ),
                Container(
                  width: 100,
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
                              builder: (context) => homePage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 100,
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
                                      child: GestureDetector(
                                        onTap: () {
                                          deleteBooking().whenComplete(
                                            () => {
                                              log('DELETE ALL BOOKING'),
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      homePage(),
                                                ),
                                              )
                                            },
                                          );
                                        },
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
                                              Center(
                                                child: Text("Confirm",
                                                    style: TextDisplay),
                                              )
                                            ],
                                          ),
                                        ),
                                      ))
                                ],
                              );
                            },
                          );
                        },
                      )
                    ],
                  ),
                ),
                Container(
                  width: 100,
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
                        child: Text("Check", style: BlueDisplayBold),
                        onPressed: () {
                          log('Check');
                          checkIn();
                        },
                      ),
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
