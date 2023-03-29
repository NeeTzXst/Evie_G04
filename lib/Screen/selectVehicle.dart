import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Widget/styles.dart';

class selectVehicle extends StatefulWidget {
  const selectVehicle({super.key});

  @override
  State<selectVehicle> createState() => _selectVehicleState();
}

class _selectVehicleState extends State<selectVehicle> {
  String get userUID => FirebaseAuth.instance.currentUser!.uid;

  int? _selectedVehicleIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        width: 350,
        height: 60,
        child: FloatingActionButton.extended(
          backgroundColor: primaryColor,
          label: Text(
            "Continue",
            style: itemWhiteDrawerText,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
          "Select your vehicle",
          style: headerText,
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('app')
            .doc('member')
            .collection('ID')
            .doc(userUID)
            .collection('Vehicle')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      side: BorderSide(color: Colors.black, width: 0.01),
                    ),
                    elevation: 7,
                    child: Container(
                      height: 120,
                      child: Row(
                        children: [
                          Container(
                            width: 150,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "${snapshot.data!.docs[index].get('Brand')}",
                                  style: hintTextBlack,
                                ),
                                Image.asset(
                                  'assets/Audi Car.png',
                                  width: 120,
                                  height: 80,
                                ),
                              ],
                            ),
                          ),
                          VerticalDivider(
                            thickness: 0.1,
                            color: Colors.black,
                          ),
                          Container(
                            width: 195,
                            child: Row(
                              children: [
                                Container(
                                  width: 145,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Charger type : ${snapshot.data!.docs[index].get('Charger type')}",
                                        overflow: TextOverflow.clip,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "License Number : ${snapshot.data!.docs[index].get('License Number')}",
                                        overflow: TextOverflow.clip,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 50,
                                  child: Radio(
                                    activeColor: primaryColor,
                                    value: index,
                                    groupValue: _selectedVehicleIndex,
                                    fillColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.selected)) {
                                          return Colors
                                              .blue; // color when selected
                                        } else {
                                          return Colors
                                              .blue; // color when not selected
                                        }
                                      },
                                    ),
                                    onChanged: ((value) {
                                      setState(
                                        () {
                                          _selectedVehicleIndex = value;
                                          log(_selectedVehicleIndex.toString());
                                        },
                                      );
                                    }),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
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
