import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/Screen/checkout.dart';
import 'package:myapp/Widget/styles.dart';
import 'package:slide_countdown/slide_countdown.dart';

import '../flutter_flow/flutter_flow_util.dart';

class timeRemining extends StatefulWidget {
  const timeRemining({super.key});

  @override
  State<timeRemining> createState() => _timeReminingState();
}

class _timeReminingState extends State<timeRemining> {
  String get userUID {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return 'No user';
    } else {
      return user.uid;
    }
  }

  Future<Map<String, dynamic>?> getUserBookinfo() async {
    log('user ID :' + userUID);
    log('GET USER BOOKING INFO');
    final userRef = FirebaseFirestore.instance
        .collection('/app/member/ID/$userUID/Booking');
    final userBookings = await userRef.get();
    if (userBookings.docs.isEmpty) {
      // Show Dialog
      log('YOU ARE NOT BOOKING');
    } else {
      log('YOU BOOKING');
      for (var booking in userBookings.docs) {
        log('YOUR BOOKING ID : ' + booking.id);
        final bookingData = booking.data();
        if (bookingData.isNotEmpty) {
          log('Booking is not emtpy');
        }
        return bookingData;
      }
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    getUserBookinfo();
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
          "Time Reminings",
          style: headerText,
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: getUserBookinfo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              Map<String, dynamic> data = snapshot.data!;
              Duration duration =
                  Duration(hours: (data['Duration'] / 60.0).toInt());
              var timeRemaining = duration;
              var dateString = DateFormat('yyyy-MM-dd').format(DateTime.now());
              var startTimeString = data['Start'];
              var fullDateTimeString = '$dateString $startTimeString';
              var startTime =
                  DateFormat('yyyy-MM-dd h:mm a').parse(fullDateTimeString);
              var currentTime = DateTime.now();
              log('startTime : ' + startTime.toString());
              log('currentTime : ' + currentTime.toString());
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Container(
                            child: Image.asset(
                              'assets/messageImage_1677661037176.jpg',
                              width: 300,
                              height: 250,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            child: Text(
                              data['Type'] + ' time',
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          currentTime.isBefore(startTime)
                              ? Text('Not time yet ,Your booking time is ' +
                                  data['Start'])
                              : Container(
                                  child: Center(
                                    child: SlideCountdown(
                                      duration: timeRemaining,
                                      onDone: () {
                                        timeRemaining -= Duration(seconds: 1);
                                      },
                                      slideDirection: SlideDirection.down,
                                      separator: ":",
                                      separatorType: SeparatorType.symbol,
                                      decoration:
                                          BoxDecoration(color: Colors.white),
                                      textStyle: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                          fontSize: 50,
                                          fontWeight: FontWeight.w700,
                                          color: Color.fromRGBO(0, 0, 0, 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: ((context) => checkout()),
                            ),
                          );
                        },
                        child: Container(
                          width: 170,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              "Finished",
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              );
            } else {
              return Center(child: Text("You haven't made booking"));
            }
          },
        ),
      ),
    );
  }
}
