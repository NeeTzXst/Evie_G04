import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Screen/parking.screen.dart';
import 'package:myapp/Widget/styles.dart';

class test extends StatefulWidget {
  final id;
  const test({super.key, required this.id});

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  late Stream<DocumentSnapshot> infoLocation;

  @override
  void initState() {
    super.initState();
    log(widget.id);
    infoLocation = FirebaseFirestore.instance
        .collection('web')
        .doc('owner')
        .collection('charging Station')
        .doc(widget.id)
        .snapshots();
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
          "Parking or Charging",
          style: headerText,
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: infoLocation,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            log(snapshot.hasError.toString());
          }
          if (snapshot.hasData) {
            final info = snapshot.data!;
            return SafeArea(
              child: Column(
                children: [
                  Image.network(info['charging_image']),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                info['charging_station'],
                                style: TextDisplay,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Text('5.0'),
                                  SizedBox(width: 10),
                                  Icon(Icons.star, color: Colors.blue),
                                  Icon(Icons.star, color: Colors.blue),
                                  Icon(Icons.star, color: Colors.blue),
                                  Icon(Icons.star, color: Colors.blue),
                                  Icon(Icons.star, color: Colors.blue),
                                  SizedBox(width: 10),
                                  Text('4 review'),
                                ],
                              ),
                              const Text('Charging Station'),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                shape: const CircleBorder()),
                            child: const Icon(Icons.directions),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: const [
                        Expanded(
                          flex: 10,
                          child: Icon(
                            Icons.ev_station_outlined,
                            color: Colors.blue,
                          ),
                        ),
                        Expanded(flex: 40, child: Text('CHAdeMO')),
                        Expanded(flex: 40, child: Text('50 kW')),
                        Expanded(flex: 10, child: Text('1/1')),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: const [
                        Expanded(
                          flex: 10,
                          child: Icon(
                            Icons.ev_station_outlined,
                            color: Colors.blue,
                          ),
                        ),
                        Expanded(flex: 40, child: Text('CCS')),
                        Expanded(flex: 40, child: Text('50 kW')),
                        Expanded(flex: 10, child: Text('1/1')),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                            flex: 1,
                            child: Icon(
                              Icons.fmd_good_outlined,
                              color: Colors.blue,
                            )),
                        Expanded(
                          flex: 9,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                info['charging_detail'],
                              ),
                              Text('Made in Kasetsart University')
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ParkingScreen()));
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  const MaterialStatePropertyAll<Color>(
                                      Colors.lightBlue),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: const [
                                  Icon(
                                    Icons.fmd_good_outlined,
                                    size: 50,
                                    color: Colors.black,
                                  ),
                                  Text(
                                    'Parking',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 24),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 5,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor:
                                  const MaterialStatePropertyAll<Color>(
                                      Colors.lightBlue),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: const [
                                  Icon(Icons.ev_station_outlined,
                                      size: 50, color: Colors.black),
                                  Text(
                                    'Charging',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 24),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
