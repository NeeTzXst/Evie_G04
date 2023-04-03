import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Screen/BookTimes.dart';
import 'package:myapp/Widget/styles.dart';

class ChargingScreen extends StatefulWidget {
  final id;
  ChargingScreen({super.key, this.id});
  static const routeName = '/charging';

  @override
  State<ChargingScreen> createState() => _ChargingScreenState();
}

class _ChargingScreenState extends State<ChargingScreen> {
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
            "Charging",
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
            // return Container(
            //   margin: const EdgeInsets.symmetric(vertical: 50),
            //   child: Column(
            //     children: [
            //       Stack(
            //         children: [
            //           Column(
            //             children: [
            //               SizedBox(
            //                 height: 100,
            //                 child: Row(
            //                   children: [
            //                     Expanded(
            //                       flex: 5,
            //                       child: Container(
            //                         height: 200,
            //                         decoration: const BoxDecoration(
            //                           border: Border(
            //                             top: BorderSide(),
            //                             bottom: BorderSide(),
            //                             right: BorderSide(),
            //                           ),
            //                         ),
            //                         child: Container(),
            //                       ),
            //                     ),
            //                     Expanded(
            //                       flex: 35,
            //                       child: Container(
            //                         height: 200,
            //                         decoration: const BoxDecoration(
            //                           border: Border(
            //                             top: BorderSide(),
            //                             bottom: BorderSide(),
            //                           ),
            //                         ),
            //                         child: Row(
            //                           mainAxisAlignment: MainAxisAlignment.end,
            //                           crossAxisAlignment:
            //                               CrossAxisAlignment.end,
            //                           children: [
            //                             const Expanded(
            //                                 flex: 15, child: Text('01')),
            //                           ],
            //                         ),
            //                       ),
            //                     ),
            //                     Expanded(
            //                       flex: 20,
            //                       child: Container(
            //                         height: 200,
            //                       ),
            //                     ),
            //                     Expanded(
            //                       flex: 35,
            //                       child: Container(
            //                         height: 200,
            //                         decoration: const BoxDecoration(
            //                           border: Border(
            //                             top: BorderSide(),
            //                             bottom: BorderSide(),
            //                           ),
            //                         ),
            //                         child: GestureDetector(
            //                           onTap: () => setState(
            //                               () => isSelected = !isSelected),
            //                           child: Container(
            //                             decoration: isSelected
            //                                 ? const BoxDecoration(
            //                                     gradient: LinearGradient(
            //                                       colors: [
            //                                         Colors.white,
            //                                         Colors.blue,
            //                                       ],
            //                                     ),
            //                                   )
            //                                 : const BoxDecoration(),
            //                             child: Row(
            //                               mainAxisAlignment:
            //                                   MainAxisAlignment.start,
            //                               crossAxisAlignment:
            //                                   CrossAxisAlignment.end,
            //                               children: [
            //                                 const Expanded(
            //                                     flex: 15, child: Text('04')),
            //                                 Expanded(
            //                                   flex: 85,
            //                                   child: Center(
            //                                     child: Text(
            //                                       isSelected
            //                                           ? 'Selected'
            //                                           : 'Avaliable',
            //                                       style: const TextStyle(
            //                                           fontSize: 24),
            //                                     ),
            //                                   ),
            //                                 ),
            //                               ],
            //                             ),
            //                           ),
            //                         ),
            //                       ),
            //                     ),
            //                     Expanded(
            //                       flex: 5,
            //                       child: Container(
            //                         height: 200,
            //                         decoration: const BoxDecoration(
            //                           border: Border(
            //                             top: BorderSide(),
            //                             bottom: BorderSide(),
            //                             left: BorderSide(),
            //                           ),
            //                         ),
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               SizedBox(
            //                 height: 100,
            //                 child: Row(
            //                   children: [
            //                     Expanded(
            //                       flex: 5,
            //                       child: Container(
            //                         height: 200,
            //                         decoration: const BoxDecoration(
            //                           border: Border(
            //                             right: BorderSide(),
            //                           ),
            //                         ),
            //                       ),
            //                     ),
            //                     Expanded(
            //                       flex: 35,
            //                       child: SizedBox(
            //                         height: 200,
            //                         child: Row(
            //                           mainAxisAlignment: MainAxisAlignment.end,
            //                           crossAxisAlignment:
            //                               CrossAxisAlignment.end,
            //                           children: [
            //                             Expanded(
            //                               flex: 85,
            //                               child: Container(),
            //                             ),
            //                             const Expanded(
            //                                 flex: 15, child: Text('02')),
            //                           ],
            //                         ),
            //                       ),
            //                     ),
            //                     Expanded(
            //                       flex: 20,
            //                       child: Container(
            //                         height: 200,
            //                       ),
            //                     ),
            //                     Expanded(
            //                       flex: 35,
            //                       child: SizedBox(
            //                         height: 200,
            //                         child: Row(
            //                           mainAxisAlignment: MainAxisAlignment.end,
            //                           crossAxisAlignment:
            //                               CrossAxisAlignment.end,
            //                           children: [
            //                             const Expanded(
            //                                 flex: 15, child: Text('05')),
            //                           ],
            //                         ),
            //                       ),
            //                     ),
            //                     Expanded(
            //                       flex: 5,
            //                       child: Container(
            //                         height: 200,
            //                         decoration: const BoxDecoration(
            //                           border: Border(
            //                             left: BorderSide(),
            //                           ),
            //                         ),
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               SizedBox(
            //                 height: 100,
            //                 child: Row(
            //                   children: [
            //                     Expanded(
            //                       flex: 5,
            //                       child: Container(
            //                         height: 200,
            //                         decoration: const BoxDecoration(
            //                           border: Border(
            //                             top: BorderSide(),
            //                             bottom: BorderSide(),
            //                             right: BorderSide(),
            //                           ),
            //                         ),
            //                       ),
            //                     ),
            //                     Expanded(
            //                       flex: 35,
            //                       child: Container(
            //                         height: 200,
            //                         decoration: const BoxDecoration(
            //                           border: Border(
            //                             top: BorderSide(),
            //                             bottom: BorderSide(),
            //                           ),
            //                         ),
            //                         child: Row(
            //                           mainAxisAlignment: MainAxisAlignment.end,
            //                           crossAxisAlignment:
            //                               CrossAxisAlignment.end,
            //                           children: [
            //                             Expanded(
            //                               flex: 85,
            //                               child: Container(),
            //                             ),
            //                             const Expanded(
            //                                 flex: 15, child: Text('03')),
            //                           ],
            //                         ),
            //                       ),
            //                     ),
            //                     Expanded(
            //                       flex: 20,
            //                       child: Container(
            //                         height: 200,
            //                       ),
            //                     ),
            //                     Expanded(
            //                       flex: 35,
            //                       child: Container(
            //                         height: 200,
            //                         decoration: const BoxDecoration(
            //                           border: Border(
            //                             top: BorderSide(),
            //                             bottom: BorderSide(),
            //                           ),
            //                         ),
            //                         child: Row(
            //                           mainAxisAlignment: MainAxisAlignment.end,
            //                           crossAxisAlignment:
            //                               CrossAxisAlignment.end,
            //                           children: [
            //                             const Expanded(
            //                                 flex: 15, child: Text('06')),
            //                           ],
            //                         ),
            //                       ),
            //                     ),
            //                     Expanded(
            //                       flex: 5,
            //                       child: Container(
            //                         height: 200,
            //                         decoration: const BoxDecoration(
            //                           border: Border(
            //                             top: BorderSide(),
            //                             bottom: BorderSide(),
            //                             left: BorderSide(),
            //                           ),
            //                         ),
            //                         child: Container(),
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ],
            //           ),
            //           SizedBox(
            //             height: 300,
            //             child: Row(
            //               children: [
            //                 Expanded(flex: 5, child: Container()),
            //                 Expanded(
            //                   flex: 35,
            //                   child: Container(
            //                     color: Colors.blue.withOpacity(0.4),
            //                     height: 300,
            //                   ),
            //                 ),
            //                 Expanded(flex: 20, child: Container()),
            //                 Expanded(flex: 35, child: Container()),
            //                 Expanded(flex: 5, child: Container()),
            //               ],
            //             ),
            //           ),
            //           SizedBox(
            //             height: 300,
            //             child: Row(
            //               children: [
            //                 Expanded(flex: 5, child: Container()),
            //                 const Expanded(
            //                   flex: 35,
            //                   child: Center(
            //                     child: RotatedBox(
            //                       quarterTurns: 3,
            //                       child: Text(
            //                         'For Charging',
            //                         style: TextStyle(
            //                             fontSize: 24,
            //                             fontWeight: FontWeight.bold),
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //                 Expanded(flex: 20, child: Container()),
            //                 Expanded(flex: 35, child: Container()),
            //                 Expanded(flex: 5, child: Container()),
            //               ],
            //             ),
            //           ),
            //         ],
            //       ),
            //       if (isSelected) const SizedBox(height: 100),
            //       if (isSelected)
            //         Container(
            //           padding: const EdgeInsets.all(20),
            //           width: MediaQuery.of(context).size.width,
            //           child: ElevatedButton(
            //             onPressed: () => Navigator.of(context).pop(),
            //             style: ElevatedButton.styleFrom(
            //               backgroundColor: Colors.blue[100],
            //             ),
            //             child: Text(
            //               'Continue',
            //               style: TextStyle(
            //                 color: Colors.blue[400],
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: 18,
            //               ),
            //             ),
            //           ),
            //         )
            //     ],
            //   ),
            // );
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
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => BookingTimeScreen(
                            stationid: widget.id,
                            spotid: spotId,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      color: Colors.amber,
                      width: 200,
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Spot : ' +
                                chargingSpot['charging_spot'].toString()),
                            const SizedBox(
                              width: 15,
                            ),
                            Text('Type : ' +
                                chargingSpot['charging_type'].toString()),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(isAvailable
                                ? 'Status : Available'
                                : 'Status : Unavailable'),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}
