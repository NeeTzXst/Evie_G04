import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/Screen/homePage.dart';
import 'package:myapp/Widget/styles.dart';
import 'package:myapp/Widget/alertBox.dart';
// import 'package:myapp/Widget/alertBox.dart';
import 'editprofile.dart';

class profile extends StatefulWidget {
  const profile({super.key});
  @override
  State<profile> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<profile> {
  File? _image;
  String? _imageUrl;

  var alertBox;
  String get userUID => FirebaseAuth.instance.currentUser!.uid;

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  Future<void> getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      print('No image selected.');
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
    return FirebaseFirestore.instance
        .collection('app')
        .doc('member')
        .collection('ID')
        .doc(userUID);
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

  @override
  void initState() {
    super.initState();
    getUserData().then((userData) {
      _fullNameController.text = userData['Fullname'] ?? '';
      _nicknameController.text = userData['Nickname'] ?? '';
      _phoneNumberController.text = userData['Phone'] ?? '';
      _emailController.text = userData['Email'] ?? '';
    });
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
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => homePage(),
                ),
              );
            },
            child: Icon(
              Icons.arrow_back,
              size: 40,
              color: Color.fromRGBO(26, 116, 226, 1),
            ),
          ),
          title: Text(
            "My Profile",
            style: headerText,
          ),
        ),
        body: FutureBuilder<DocumentSnapshot>(
          future: getUserData(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              log(snapshot.data!.data().toString());
              final userData = snapshot.data!;
              final userUid = FirebaseAuth.instance.currentUser!.uid;
              final image =
                  FirebaseStorage.instance.ref().child('$userUid/profile.jpg');

              // ignore: body_might_complete_normally_catch_error
              final imageUrlFuture = image.getDownloadURL().catchError((error) {
                if (error is FirebaseException &&
                    error.code == 'object-not-found') {
                  return 'assets/Imageholder.png';
                }
              });
              return FutureBuilder(
                  future: imageUrlFuture,
                  builder: (context, imageUrlSnapshot) {
                    if (imageUrlSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (imageUrlSnapshot.hasError) {
                      return Text('Error: ${imageUrlSnapshot.error}');
                    } else {
                      final imageUrl = imageUrlSnapshot.data!;
                      return ListView(
                        children: <Widget>[
                          Container(
                            height: 250,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: <Widget>[
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      minRadius: 60.0,
                                      child: CircleAvatar(
                                        radius: 90.0,
                                        backgroundImage: imageUrl.isNotEmpty
                                            ? NetworkImage(imageUrl)
                                            : AssetImage(
                                                imageUrlSnapshot.error
                                                    .toString(),
                                              ) as ImageProvider<Object>,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 23),
                            child: Text("Full name", style: hintText),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 350,
                              height: 52,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                color: Color.fromARGB(255, 107, 207, 255),
                              ),
                              padding: const EdgeInsets.only(left: 13),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(userData['Fullname'],
                                        style: TextDisplay),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 23),
                            child: Text("Nickname", style: hintText),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 350,
                              height: 52,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                color: Color.fromARGB(255, 107, 207, 255),
                              ),
                              padding: const EdgeInsets.only(left: 13),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(userData['Nickname'],
                                        style: TextDisplay),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 23),
                            child: Text("Phone Number", style: hintText),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 350,
                              height: 52,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                color: Color.fromARGB(255, 107, 207, 255),
                              ),
                              padding: const EdgeInsets.only(left: 13),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(userData['Phone'],
                                        style: TextDisplay),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 23),
                            child: Text("Email", style: hintText),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                                width: 350,
                                height: 52,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  color: Color.fromARGB(255, 107, 207, 255),
                                ),
                                padding: const EdgeInsets.only(left: 13),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(userData['Email'],
                                            style: TextDisplay),
                                      )
                                    ])),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 150,
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
                                    child: Text("Edit Profile",
                                        style: itemWhiteDrawerText),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  editprofile()));
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  });
            }
          }),
        ));
  }
}
