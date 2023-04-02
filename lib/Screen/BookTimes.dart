// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingTimeScreen extends StatefulWidget {
  var stationid;
  var spotid;
  var uid;

  BookingTimeScreen({this.stationid, this.spotid, this.uid});

  @override
  State<BookingTimeScreen> createState() => _BookingTimeScreenState();
}

var charging;
var userid;
var spot;

Future<void> storeBooking(
    BuildContext context, DateTime timeStart, DateTime timeEnd) async {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String startTimeString = DateFormat('yyyy-MM-dd HH:mm:ss').format(timeStart);
  String endTimeString = DateFormat('yyyy-MM-dd HH:mm:ss').format(timeEnd);

  CollectionReference bookingsRef = _firestore.collection('bookings');
  print(startTimeString);
  print(endTimeString);

  // Query to check for overlapping bookings
  QuerySnapshot overlappingBookings = await bookingsRef.get();

  QuerySnapshot overlappingBookings1 =
      await bookingsRef.where('endTime', isGreaterThan: startTimeString).get();

  // If there are any overlapping bookings, display an AlertDialog and return
  if (overlappingBookings.docs.isNotEmpty ||
      overlappingBookings1.docs.isNotEmpty) {
    AlertDialog alert = AlertDialog(
      title: Text('Booking Status'),
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
  }

  // Otherwise, store the new booking and display an AlertDialog
  bookingsRef.add({
    'startTime': startTimeString,
    'endTime': endTimeString,
    'uid': userid,
    'charging_station': charging,
    'charging_pot': spot
  });
  AlertDialog alert = AlertDialog(
    title: Text('Booking Status'),
    content: Text('Booking successful!'),
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
}

class _BookingTimeScreenState extends State<BookingTimeScreen> {
  DateTime timeStart = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, DateTime.now().hour, DateTime.now().minute);
  DateTime timeEnd = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, DateTime.now().hour, DateTime.now().minute + 1);

  String date = DateFormat('dd MMMM, EEEE').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    spot = widget.spotid;
    userid = widget.uid;
    charging = widget.stationid;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        leading: BackButton(color: Color.fromRGBO(26, 116, 226, 1)),
        // ignore: prefer_const_constructors
        title: Text("Booking Time", style: Mytextstyle.blue24),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Parking area',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(26, 116, 226, 1),
                fontSize: 24,
              ),
            ),
            Text(
              'KU Charging Station',
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
                      Text(
                        '04 Parking Spot',
                        style: TextStyle(
                          color: Color.fromRGBO(26, 116, 226, 1),
                        ),
                      )
                    ],
                  ),
                  Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Icon(
                        Icons.location_pin,
                        color: Color.fromRGBO(26, 116, 226, 1),
                        size: 40,
                      ),
                      Text(
                        '20 km away',
                        style: TextStyle(
                          color: Color.fromRGBO(26, 116, 226, 1),
                        ),
                      )
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
              child: Container(
                  width: 320,
                  height: 52,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Color.fromRGBO(107, 207, 255, 0.4),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: <Widget>[
                        TextButton(
                          child: Text(
                            "Continue",
                            style: TextStyle(
                                color: Color.fromRGBO(26, 116, 226, 1),
                                fontWeight: FontWeight.w500,
                                fontFamily: "Montserrat",
                                fontStyle: FontStyle.normal,
                                fontSize: 21.0),
                          ),
                          onPressed: () =>
                              storeBooking(context, timeStart, timeEnd),
                        )
                      ])),
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
