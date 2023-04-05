import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/Screen/homePage.dart';
import 'package:myapp/Widget/alertBox.dart';
import 'package:myapp/Widget/styles.dart';
import 'package:myapp/flutter_flow/flutter_flow_util.dart';
import 'package:qr/qr.dart';
import 'package:qr_flutter/qr_flutter.dart';

class checkout extends StatefulWidget {
  var spotslolt;
  var type;
  var stationID;
  var spotID;
  var userBookId;
  checkout(
      {super.key,
      this.spotslolt,
      this.type,
      this.stationID,
      this.spotID,
      this.userBookId});

  @override
  State<checkout> createState() => _checkoutState();
}

class _checkoutState extends State<checkout> {
  String get userUID {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return 'No user';
    } else {
      return user.uid;
    }
  }

  Future<void> deleteBooking() async {
    CollectionReference userBookingsRef = FirebaseFirestore.instance
        .collection('/app/member/ID/$userUID/Booking');

    //log('bookingId : ' + widget.bookingId);
    log('userBookID : ' + widget.userBookId);
    log('stationID : ' + widget.stationID);
    log('widget.spotID : ' + widget.spotID);
    await userBookingsRef.doc(widget.userBookId).delete().whenComplete(() {
      log('DELETE USER BOOKING');
    });
  }

  Future<void> _checkOutBooking() async {
    // Get the booking with the given UID

    CollectionReference check = FirebaseFirestore.instance.collection(
        '/web/owner/charging Station/${widget.stationID}/charging Spot/${widget.spotID}/booking');
    print('stationID : ' + widget.stationID.toString());
    print('spotID : ' + widget.spotID.toString());
    print('userUID : ' + userUID.toString());

    QuerySnapshot checkqr = await check.where('uid', isEqualTo: userUID).get();

    if (checkqr.docs.isNotEmpty) {
      final bookingDocSnapshot = checkqr.docs.first;
      final DocID = bookingDocSnapshot.id;
      final bookingData = bookingDocSnapshot.data();
      log('bookingData : ' + bookingData.toString());
      log('bookingDocID : ' + DocID.toString());
      final bookingStartTime = bookingDocSnapshot['startTime'];
      final bookingEndTime = bookingDocSnapshot['endTime'];
      final currentTime = DateTime.now();
      final currentTimeString = DateFormat('hh:mm a').format(currentTime);
      final currentTimeDateTime =
          DateFormat('hh:mm a').parse(currentTimeString);
      final bookingStartDateTime =
          DateFormat('hh:mm a').parse(bookingStartTime);
      final bookingEndDateTime = DateFormat('hh:mm a').parse(bookingEndTime);
      int duration =
          currentTimeDateTime.difference(bookingEndDateTime).inMinutes;

      if ((currentTimeDateTime.isAfter(bookingStartDateTime) &&
              currentTimeDateTime.isBefore(bookingEndDateTime) ||
          currentTimeDateTime == bookingStartDateTime)) {
        log("ออกภายในเวลา");
        // Show "Welcome to Spot" dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Thank you for using ours service.',
                style: TextStyle(
                    color: Colors.green, fontWeight: FontWeight.bold)),
            content: Text('Have a nice day !!.'),
            actions: [
              TextButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection(
                          '/web/owner/charging Station/${widget.stationID}/charging Spot/')
                      .doc(widget.spotID)
                      .update({'status': "true"}).then((value) {
                    try {
                      log('webBookingsRef : ' + check.toString());
                      check.doc(DocID).delete().whenComplete(() {
                        log('DELETE WEB BOOKING');
                        deleteBooking();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => homePage()));
                      });
                    } catch (e) {
                      log(e.toString());
                    }
                  }).catchError((error) {
                    print("Failed to update charging spot: $error");
                  });
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else if ((currentTimeDateTime == bookingEndDateTime) ||
          duration <= 30) {
        log("ออกเกือบเลท");
        // Show "Sorry" dialog
        log("ออกภายในเวลา");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Thank you for using ours service ",
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            content: Text('Have a nice day !!.'),
            actions: [
              TextButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection(
                          '/web/owner/charging Station/${widget.stationID}/charging Spot/')
                      .doc(widget.spotID)
                      .update(
                    {'status': "true"},
                  ).whenComplete(
                    () {
                      try {
                        log('webBookingsRef : ' + check.toString());
                        check.doc(DocID).delete().whenComplete(() {
                          log('DELETE WEB BOOKING');
                          deleteBooking();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => homePage()));
                        });
                      } catch (e) {
                        log(e.toString());
                      }
                    },
                  );
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else if (duration > 30) {
        // Show "Not your time" dialog
        log('currentTime : ' + currentTime.toString());
        log('currentTimeDateTime : ' + currentTimeDateTime.toString());
        log('bookingEndTime : ' + bookingEndTime.toString());
        log('bookingEndDateTime : ' + bookingEndDateTime.toString());
        double TotalPrice = (duration / 60) * 500;
        log('duration : ' + duration.toString());
        log('TotalPrice : ' + TotalPrice.toString());
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Please pay a charge!!',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            content: Text(
                'Your service is over the time that you has bookings. Your total charge is ${TotalPrice.toStringAsFixed(2)} baht'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Center(child: Text('Please pay a charge!!')),
                          content: Image.asset('assets/QRCODE.jpg'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection(
                                          '/web/owner/charging Station/${widget.stationID}/charging Spot/')
                                      .doc(widget.spotID)
                                      .update(
                                    {'status': "true"},
                                  ).whenComplete(
                                    () {
                                      try {
                                        log('webBookingsRef : ' +
                                            check.toString());
                                        check
                                            .doc(DocID)
                                            .delete()
                                            .whenComplete(() {
                                          log('DELETE WEB BOOKING');
                                          deleteBooking();
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      homePage()));
                                        });
                                      } catch (e) {
                                        log(e.toString());
                                      }
                                    },
                                  );
                                },
                                child: Text('Ok'))
                          ],
                        );
                      });
                },
                child: Text('Ok'),
              ),
            ],
          ),
        );
      } else {
        log("ไม่เจอเช็คอิน");
        // Show "Not your time" dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Sorry,can't see your check in",
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

  @override
  void initState() {
    super.initState();
    log('Type : ' + widget.type.toString());
    log('Spotslot : ' + widget.spotslolt.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            size: 40,
            color: Color.fromRGBO(26, 116, 226, 1),
          ),
        ),
        title: Text(
          "Check Out",
          style: headerText,
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Center(
            child: Text(
              "Scan this QR Code for Checkout",
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(113, 113, 113, 1),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              "0${widget.spotslolt} ${widget.type}",
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            width: 260,
            height: 260,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: QrImage(
              version: QrVersions.auto,
              data: userUID,
              padding: EdgeInsets.all(25),
              foregroundColor: Colors.white,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            width: 200,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: Color.fromRGBO(107, 207, 255, 0.6),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                TextButton(
                  child: Text("Check out", style: BlueDisplayBold),
                  onPressed: () {
                    log('Check out');
                    _checkOutBooking();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
