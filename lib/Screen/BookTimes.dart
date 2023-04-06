// ignore_for_file: prefer_const_constructors
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:myapp/Screen/makePayment.dart';
import 'package:myapp/Widget/styles.dart';

class BookingTimeScreen extends StatefulWidget {
  var stationid;
  var spotid;
  var uid;
  var type;
  var StationName;
  BookingTimeScreen({
    super.key,
    this.stationid,
    this.spotid,
    this.uid,
    this.type,
    this.StationName,
  });

  @override
  State<BookingTimeScreen> createState() => _BookingTimeScreenState();
}

var charging;
var userid;
var spot;
var spotSlot;
var types;

String get userUID {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    return 'No user';
  } else {
    return user.uid;
  }
}

//'/web/owner/charging Station/$charging/charging Spot/$spot/booking'

class _BookingTimeScreenState extends State<BookingTimeScreen> {
  DateTime timeStart = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, DateTime.now().hour, DateTime.now().minute);
  DateTime timeEnd = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, DateTime.now().hour, DateTime.now().minute + 1);

  String date = DateFormat('dd MMMM, EEEE').format(DateTime.now());

  Future<int?> getData() async {
    final db = FirebaseFirestore.instance;
    var docRef = db
        .collection(
            '/web/owner/charging Station/${widget.stationid}/charging Spot')
        .doc(widget.spotid);
    try {
      log('try');
      var doc = await docRef.get();
      if (doc.exists) {
        log('if');
        var data = doc.data()!;
        spotSlot = data['charging_spot'];
        log('Slot : ' + spotSlot.toString());
        return spotSlot;
      } else {
        print("Document does not exist");
        return null;
      }
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<void> storeBooking(BuildContext context, DateTime timeStart,
      DateTime timeEnd, String userid) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    String startTimeString = DateFormat('hh:mm a').format(timeStart);
    String endTimeString = DateFormat('hh:mm a').format(timeEnd);

    DateTime startTime = DateFormat('hh:mm a').parse(startTimeString);
    DateTime endTime = DateFormat('hh:mm a').parse(endTimeString);

    int duration = endTime.difference(startTime).inMinutes;

    log('startTime : ' + startTimeString);
    log("endTime : " + endTimeString);
    log("Daration : " + duration.toString());

    CollectionReference bookingsRef = _firestore.collection(
        '/web/owner/charging Station/$charging/charging Spot/$spot/booking');
    // Query to check for overlapping bookings
    QuerySnapshot overlappingBookings =
        await bookingsRef.where('startTime', isLessThan: endTimeString).get();

    QuerySnapshot overlappingBookings1 = await bookingsRef
        .where('endTime', isGreaterThan: startTimeString)
        .get();

    // Query to check for overlapping bookings
    QuerySnapshot overlappingBookings2 =
        await bookingsRef.where('startTime', isEqualTo: startTimeString).get();

    QuerySnapshot overlappingBookings3 =
        await bookingsRef.where('endTime', isEqualTo: endTimeString).get();

    // If there are any overlapping bookings, display an AlertDialog and return
    if ((overlappingBookings.docs.isNotEmpty &&
            overlappingBookings1.docs.isNotEmpty) ||
        (overlappingBookings2.docs.isNotEmpty &&
            overlappingBookings3.docs.isNotEmpty)) {
      AlertDialog alert = AlertDialog(
        title: Text('Booking Status',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            )),
        content: Text('Booking failed. There is an overlapping booking.'),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
      return;
      //
    } else if (endTime.difference(startTime).inMinutes == 0) {
      AlertDialog alert = AlertDialog(
        title: Text('Booking Status',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            )),
        content: Text('Booking failed. Start time and End time is the same.'),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
      return;
    } else if (endTime.difference(startTime).inMinutes < 0) {
      AlertDialog alert = AlertDialog(
        title: Text('Booking Status',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            )),
        content: Text('Booking failed. There is not daily.'),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
      return;
    } else {
      // Otherwise, store the new booking and display an AlertDialog
      DocumentReference docRef = await bookingsRef.add({
        'startTime': startTimeString,
        'endTime': endTimeString,
        'uid': userid,
        'charging_station': charging,
        'charging_spot': spot,
        'duration': duration,
      });

      String bookId = docRef.id;

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color.fromARGB(255, 255, 207, 85),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            title: Center(
              child: Text('Warning !!', style: StationFull),
            ),
            content: Column(
                mainAxisSize: MainAxisSize.min,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: 'If you are over ', style: PopupTextBlack),
                        TextSpan(text: '30 minutes ', style: PopupTextRed),
                        TextSpan(
                            text:
                                'late, your booking will be canceled. If you park for longer than your booked time, you will be fined.',
                            style: PopupTextBlack),
                      ],
                    ),
                  ),
                ]),
            actions: [
              Align(
                alignment: Alignment.center,
                child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        log('Booking Id : ' + bookId);
                        log('Station Id : ' + charging);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => makePaymentWidget(
                              bookingId: bookId,
                              duration: duration,
                              stationID: charging,
                              type: types,
                              spotSlot: spotSlot,
                              StationName: widget.StationName,
                              date: date,
                              start: startTimeString,
                              end: endTimeString,
                              spotID: spot,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: 200,
                        height: 52,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            color: Color.fromRGBO(255, 255, 255, 1)),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: <Widget>[
                              Center(
                                child: Text("Accept", style: hintText),
                              )
                            ]),
                      ),
                    )),
              )
            ],
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    log('Charging Spot ID : ' + widget.spotid);
    log('Staiont ID : ' + widget.stationid);
  }

  @override
  Widget build(BuildContext context) {
    spot = widget.spotid;
    userid = widget.uid;
    charging = widget.stationid;
    types = widget.type;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        leading: BackButton(color: Color.fromRGBO(26, 116, 226, 1)),
        // ignore: prefer_const_constructors
        title: Text("Booking Time", style: Mytextstyle.blue24),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.type.toString() + ' Area',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(26, 116, 226, 1),
                fontSize: 24,
              ),
            ),
            Text(
              widget.StationName,
              style: TextStyle(
                color: Color.fromRGBO(107, 207, 255, 1),
                fontSize: 24,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Icon(
                        Icons.directions_car,
                        color: Color.fromRGBO(26, 116, 226, 1),
                        size: 40,
                      ),
                      FutureBuilder<int?>(
                        future: getData(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.hasData) {
                            num spotSlot = snapshot.data!;
                            return Text(
                              '0' +
                                  spotSlot.toString() +
                                  ' ' +
                                  widget.type +
                                  ' Spot',
                              style: TextStyle(
                                fontSize: 20,
                                color: Color.fromRGBO(26, 116, 226, 1),
                              ),
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
            SizedBox(height: 15),
            Text(
              'Price Traffic',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(26, 116, 226, 1),
                fontSize: 24,
              ),
            ),
            Text(
              'You can change the duration of booking by selecting any one of the options below.',
              style: TextStyle(
                color: Color.fromRGBO(107, 207, 255, 1),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Icon(
                    Icons.calendar_month_outlined,
                    color: Color.fromRGBO(26, 116, 226, 1),
                    size: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      date,
                      style: TextStyle(
                          color: Color.fromRGBO(26, 116, 226, 1), fontSize: 20),
                    ),
                  )
                ],
              ),
            ),
            Text(
              'Duration',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(26, 116, 226, 1),
                fontSize: 24,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                    flex: 45,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Start Hour',
                          style: TextStyle(
                              color: Color.fromRGBO(26, 116, 226, 1),
                              fontSize: 20),
                        ),
                        CupertinoButton(
                          onPressed: () => _showDialog(
                            CupertinoDatePicker(
                              initialDateTime: timeStart,
                              mode: CupertinoDatePickerMode.time,
                              use24hFormat: true,
                              onDateTimeChanged: (DateTime newTime) {
                                setState(() => timeStart = newTime);
                              },
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color.fromRGBO(26, 116, 226, 1),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  '${timeStart.hour.toString().length == 1 ? '0${timeStart.hour}' : timeStart.hour}:${timeStart.minute.toString().length == 1 ? '0${timeStart.minute}' : timeStart.minute}',
                                  style: TextStyle(
                                    color: Color.fromRGBO(107, 207, 255, 1),
                                  ),
                                ),
                                Icon(
                                  Icons.schedule,
                                  size: 15,
                                  color: Color.fromRGBO(26, 116, 226, 1),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    )),
                const Expanded(
                    flex: 10,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 17),
                      child: Icon(
                        Icons.arrow_right_alt,
                        size: 40,
                        color: Color.fromRGBO(26, 116, 226, 1),
                      ),
                    )),
                Expanded(
                    flex: 45,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'End Hour',
                          style: TextStyle(
                              color: Color.fromRGBO(26, 116, 226, 1),
                              fontSize: 20),
                        ),
                        CupertinoButton(
                          onPressed: () => _showDialog(
                            CupertinoDatePicker(
                              initialDateTime: timeEnd,
                              mode: CupertinoDatePickerMode.time,
                              use24hFormat: true,
                              onDateTimeChanged: (DateTime newTime) {
                                setState(() => timeEnd = newTime);
                              },
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color.fromRGBO(26, 116, 226, 1),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  '${timeEnd.hour.toString().length == 1 ? '0${timeEnd.hour}' : timeEnd.hour}:${timeEnd.minute.toString().length == 1 ? '0${timeEnd.minute}' : timeEnd.minute}',
                                  style: TextStyle(
                                    color: Color.fromRGBO(107, 207, 255, 1),
                                  ),
                                ),
                                Icon(
                                  Icons.schedule,
                                  size: 15,
                                  color: Color.fromRGBO(26, 116, 226, 1),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    )),
              ],
            ),
            SizedBox(height: 100),
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  storeBooking(context, timeStart, timeEnd, userUID);
                },
                child: Container(
                    width: 320,
                    height: 52,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: Color.fromRGBO(107, 207, 255, 0.4),
                    ),
                    child: Center(
                      child: Text(
                        'Continue',
                        style: BlueDisplayBold,
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
              height: 400,
              padding: const EdgeInsets.only(top: 6.0),
              color: Color.fromARGB(255, 255, 255, 255),
              child: SafeArea(
                top: false,
                child: child,
              ),
            ));
  }
}

class Mytextstyle {
  static const TextStyle black21 = TextStyle(
      color: Color.fromRGBO(0, 0, 0, 1),
      fontWeight: FontWeight.w500,
      fontFamily: "Montserrat",
      fontStyle: FontStyle.normal,
      fontSize: 21.0);

  static const TextStyle blue24 = TextStyle(
      color: Color.fromRGBO(26, 116, 226, 1),
      fontWeight: FontWeight.w500,
      fontFamily: "Montserrat",
      fontStyle: FontStyle.normal,
      fontSize: 24.0);

  static const TextStyle blue15 = TextStyle(
      color: Color.fromRGBO(26, 116, 226, 1),
      fontWeight: FontWeight.w400,
      fontFamily: "Montserrat",
      fontStyle: FontStyle.normal,
      fontSize: 15.0);
}

const primaryColor = Color.fromRGBO(26, 116, 226, 1);
final PopupTextBlack = GoogleFonts.montserrat(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: Colors.black,
);

final PopupTextRed = GoogleFonts.montserrat(
    fontSize: 16, fontWeight: FontWeight.w600, color: Colors.red);

final hintText = GoogleFonts.montserrat(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: primaryColor,
);

final StationFull = GoogleFonts.montserrat(
  fontSize: 22,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);
