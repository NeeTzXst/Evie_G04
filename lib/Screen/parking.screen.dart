import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Screen/BookTimes.dart';
import 'package:myapp/Widget/alertBox.dart';
import 'package:myapp/Widget/styles.dart';

class ParkingScreen extends StatefulWidget {
  final id;
  var Stationname;
  ParkingScreen({super.key, this.id, this.Stationname});
  static const routeName = '/parking';

  @override
  State<ParkingScreen> createState() => _ParkingScreenState();
}

class _ParkingScreenState extends State<ParkingScreen> {
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    log('Station ID : ' + widget.id);
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
            "Parking",
            style: headerText,
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('web')
              .doc('owner')
              .collection('charging Station')
              .doc(widget.id)
              .collection('charging Spot')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              log(snapshot.hasError.toString());
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                DocumentSnapshot chargingSpot = snapshot.data!.docs[index];
                bool isAvailable = chargingSpot['status'] == 'true';
                String spotId = chargingSpot.id;
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                      onTap: () {
                        log('isAvailable : ' + isAvailable.toString());
                        if (isAvailable) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => BookingTimeScreen(
                                stationid: widget.id,
                                spotid: spotId,
                                type: 'Parking',
                                StationName: widget.Stationname,
                              ),
                            ),
                          );
                        } else {
                          alertBox.showAlertBox(context, "SpotStatus",
                              'This Parking spot is unavailable');
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 250,
                              height: 120,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromRGBO(26, 116, 226, 1),
                                  width: 3,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text('Spot : ' +
                                      chargingSpot['charging_spot'].toString()),
                                  isAvailable
                                      ? Text('Available')
                                      : Image.asset(
                                          'assets/blue-car.png',
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )

                      // Container(
                      //   color: secondColor,
                      //   width: 200,
                      //   height: 100,
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(15.0),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //       children: [
                      //         Text('Spot : ' +
                      //             chargingSpot['charging_spot'].toString()),
                      //         Text(
                      //           'Type : ' +
                      //               chargingSpot['charging_type'].toString(),
                      //           overflow: TextOverflow.fade,
                      //         ),
                      //         Text(isAvailable
                      //             ? 'Status : Available'
                      //             : 'Status : Unavailable'),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      ),
                );
              },
            );
          },
        ));
  }
}
