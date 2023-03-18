// ignore_for_file: prefer_const_constructors, duplicate_ignore, sort_child_properties_last
// ignore: unused_import, avoid_web_libraries_in_flutter
// import 'dart:js';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/services.dart';
// ignore: implementation_imports, unnecessary_import
import 'package:flutter/src/widgets/basic.dart';
// ignore: implementation_imports, unnecessary_import
import 'package:flutter/src/widgets/framework.dart';
import 'package:myapp/Screen/addvehicle.dart';
// ignore: depend_on_referenced_packages
// ignore: unused_import
// import 'package:evie/login.dart';
//import 'package:evie/Addvehicle.dart';

class ProfileScreen extends StatefulWidget {
  // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  final _fullname = TextEditingController();
  final _nickname = TextEditingController();
  final _number = TextEditingController();
  final _email = TextEditingController();

  Future<void> addProfile() async {
    print('======== Email : ${_fullname.text} ================');
    print('======== Password : ${_nickname.text} ==========');
    print('======== Email : ${_number.text} =============');
    print('======== Password : ${_email.text} =============');
    final userId = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('app')
        .doc('member')
        .collection('ID')
        .doc(userId)
        .update({
      'Fullname': _fullname.text,
      'Nickname': _nickname.text,
      'Phone': _number.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: BackButton(color: Color.fromRGBO(26, 116, 226, 1)),
          // ignore: prefer_const_constructors
          title: Text(
            "Create your profile",
            style: TextStyle(
                color: Color.fromRGBO(26, 116, 226, 1),
                fontWeight: FontWeight.w500,
                fontFamily: "Montserrat",
                fontStyle: FontStyle.normal,
                fontSize: 19.0),
          ),
        ),
        body: ListView(children: <Widget>[
          SizedBox(
              height: 550,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          CircleAvatar(
                            radius: 90,
                            backgroundColor: Color(0xFF6BCFFF),
                          ),
                          // FFlatButton.icon(
                          //   textColor: Theme.of(context).primaryColor,
                          //   onPresssed: () {} ,
                          //   icon: Icon(Icons.image) ,
                          //   label: Text('Add Image'),
                          //   ),
                        ]),
                    SizedBox(
                      height: 70,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 23, right: 23),
                        child: Container(
                            height: 47,
                            alignment: Alignment.centerRight,
                            decoration: BoxDecoration(
                              color: Color(0xFF6BCFFF),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextField(
                                controller: _fullname,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(color: Colors.black87),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(top: 2),
                                    hintText: 'Full name',
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Montserrat',
                                    ))))),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 23, right: 23),
                        child: Container(
                            height: 47,
                            alignment: Alignment.centerRight,
                            decoration: BoxDecoration(
                              color: Color(0xFF6BCFFF),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextField(
                                controller: _nickname,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(color: Colors.black87),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(top: 2),
                                    hintText: 'Nick name',
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Montserrat',
                                    ))))),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 23, right: 23),
                        child: Container(
                            height: 47,
                            alignment: Alignment.centerRight,
                            decoration: BoxDecoration(
                              color: Color(0xFF6BCFFF),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextField(
                                controller: _number,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(color: Colors.black87),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(top: 2),
                                    hintText: 'Number',
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Montserrat',
                                    ))))),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 23, right: 23),
                        child: Container(
                            height: 47,
                            alignment: Alignment.centerRight,
                            decoration: BoxDecoration(
                              color: Color(0xFF6BCFFF),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextField(
                                controller: _email,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(color: Colors.black87),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(top: 2),
                                    hintText: 'Email',
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Montserrat',
                                    ))))),
                  ])),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
                width: 350,
                height: 52,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Color.fromRGBO(26, 116, 226, 1)),
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: <Widget>[
                      TextButton(
                        child: Text(
                          "Add Your Vehicle",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Montserrat",
                              fontStyle: FontStyle.normal,
                              fontSize: 20.0),
                        ),
                        onPressed: () async {
                          await addProfile().then((value) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddVehicle())));
                        },
                      )
                    ])),
          ),
        ]));
  }

  row(
      {required MainAxisAlignment mainAxisAlignment,
      required List<SingleChildScrollView> children}) {}
}

// class FFlatButton {
//   static icon({required Null Function() onPresssed, required Icon icon, required Text label, required Color textColor}) {}
// }

// ignore: non_constant_identifier_names
