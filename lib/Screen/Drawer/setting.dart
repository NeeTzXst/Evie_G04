import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Screen/login.dart';
import 'package:myapp/Widget/styles.dart';

class setting extends StatefulWidget {
  const setting({super.key});

  @override
  State<setting> createState() => _settingState();
}

final userUid = FirebaseAuth.instance.currentUser!.uid;

Future<void> deleteAccount(String userUid) async {
  CollectionReference UserID =
      FirebaseFirestore.instance.collection('/app/member/ID/');
  try {
    await UserID.doc(userUid).delete();
  } catch (e) {
    log('Error deleting user data from Firestore: $e');
  }
  try {
    await FirebaseAuth.instance.currentUser!.delete();
    await FirebaseAuth.instance.signOut();
    log('User with UID $userUid has been deleted.');
  } catch (e) {
    log('Error deleting user from Firebase Authentication: $e');
  }
}

class _settingState extends State<setting> {
  String get userUID => FirebaseAuth.instance.currentUser!.uid;

  DocumentReference get userDocument {
    return FirebaseFirestore.instance
        .collection('app')
        .doc('member')
        .collection('ID')
        .doc(userUID);
  }

  Future<DocumentSnapshot> getUserData() async {
    return await userDocument.get();
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
          "Setting",
          style: headerText,
        ),
      ),
      body: ListView(children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Align(
            alignment: Alignment.center,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: <Widget>[
                  Container(
                    width: 350,
                    height: 38,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1.5,
                                color: Color.fromRGBO(26, 116, 226, 1)))),
                    child: TextButton(
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
                                  child: Text('Delete Account ?',
                                      style: TextDisplay),
                                ),
                                content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      Text(
                                        "Can you please share to us what was not working? We are fixing bugs as soon as we spot them. If something slipped through our fingers, we’d be so grateful to be aware of it and fix it",
                                        textAlign: TextAlign.center,
                                      ),
                                    ]),
                                actions: [
                                  Align(
                                      alignment: Alignment.center,
                                      child: GestureDetector(
                                        onTap: () async {
                                          deleteAccount(userUid).whenComplete(
                                            () => {
                                              log('DELETE ALL BOOKING'),
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoginScreen(),
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
                                              ]),
                                        ),
                                      ))
                                ],
                              );
                            },
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Delete Account", style: BlueDisplay),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                              color: Color.fromRGBO(26, 116, 226, 1),
                            )
                          ],
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 350,
                    height: 38,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1.5,
                                color: Color.fromRGBO(26, 116, 226, 1)))),
                    child: TextButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            Text("Version 0.1", style: BlueDisplay),
                          ],
                        )),
                  ),
                  SizedBox(height: 20),
                ])),
      ]),
    );
  }
}
