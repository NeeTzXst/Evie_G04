// ignore_for_file: prefer_const_constructors, duplicate_ignore, sort_child_properties_last
// ignore: unused_import, avoid_web_libraries_in_flutter
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/services.dart';
// ignore: implementation_imports, unnecessary_import
import 'package:flutter/src/widgets/basic.dart';
// ignore: implementation_imports, unnecessary_import
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/Database/authService.dart';
import 'package:myapp/Screen/Drawer/profile.dart';
import 'package:myapp/Screen/addvehicle.dart';
// ignore: depend_on_referenced_packages
// ignore: unused_import
// import 'package:evie/login.dart';
//import 'package:evie/Addvehicle.dart';

class ProfileScreen extends StatefulWidget {
  // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  File? _image;
  String? _imageUrl;

  var alertBox;
  String get userUID => FirebaseAuth.instance.currentUser!.uid;
  final _fullname = TextEditingController();
  final _nickname = TextEditingController();
  final _number = TextEditingController();
  final _email = TextEditingController();

  final picker = ImagePicker();

  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    try {
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
          log('Image uploaded to Firebase Storage!');
        });
      } else {
        log('No image selected.');
      }
    } catch (e) {
      log('Error uploading image to Firebase Storage: $e');
    }
  }

  Future<DocumentSnapshot> getUserData() async {
    final userUid = FirebaseAuth.instance.currentUser!.uid;
    final userDocument = FirebaseFirestore.instance
        .collection('app')
        .doc('member')
        .collection('ID')
        .doc(userUid);

    return await userDocument.get();
  }

  DocumentReference get userDocument {
    final userUid = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection('app')
        .doc('member')
        .collection('ID')
        .doc(userUid);
  }

  Future<void> _uploadImage() async {
    if (_image == null) {
      return;
    }

    try {
      final reference =
          FirebaseStorage.instance.ref().child('$userUID').child('profile.jpg');

      await reference.putFile(_image!);
      final url = await reference.getDownloadURL();
      setState(() {
        _imageUrl = url;
      });
      print(url);
    } on FirebaseException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to upload image: ${error.message}'),
        ),
      );
    }
  }

  void _updateUserData() async {
    await _uploadImage();
    final userUid = FirebaseAuth.instance.currentUser!.uid;
    final userDocument = FirebaseFirestore.instance
        .collection('app')
        .doc('member')
        .collection('ID')
        .doc(userUid);
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
        body: FutureBuilder<DocumentSnapshot>(
            future: getUserData(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                ); // Show a loading indicator while waiting for the data.
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final userData = snapshot.data!;
                return ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 550,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () async {
                                  log('get Image');
                                  await getImage();
                                },
                                child: CircleAvatar(
                                  radius: 90,
                                  backgroundColor: Color(0xFF6BCFFF),
                                  child: _image != null
                                      ? ClipOval(
                                          child: Image.file(
                                            _image!,
                                            fit: BoxFit.cover,
                                            width: 180,
                                            height: 180,
                                          ),
                                        )
                                      : Icon(
                                          Icons.camera_alt_outlined,
                                          size: 60,
                                        ),
                                ),
                              ),
                            ],
                          ),
                          // FFlatButton.icon(
                          //   textColor: Theme.of(context).primaryColor,
                          //   onPresssed: () {} ,
                          //   icon: Icon(Icons.image) ,
                          //   label: Text('Add Image'),
                          //   ),
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
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: TextField(
                                  controller: _fullname,
                                  keyboardType: TextInputType.emailAddress,
                                  style: TextStyle(color: Colors.black87),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    //contentPadding: EdgeInsets.only(top: 2),
                                    hintText: 'Full name',
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
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
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
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
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
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
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
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
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
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
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
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
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 350,
                        height: 52,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            color: Color.fromRGBO(26, 116, 226, 1)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                              onPressed: () {
                                authService().addProfile(
                                    _fullname.text,
                                    _nickname.text,
                                    _number.text,
                                    _email.text,
                                    context);
                                _updateUserData();
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            })));
    // row(
    //     {required MainAxisAlignment mainAxisAlignment,
    //     required List<SingleChildScrollView> children}) {}
  }
}
