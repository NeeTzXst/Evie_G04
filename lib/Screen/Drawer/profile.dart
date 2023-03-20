import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Screen/homePage.dart';
import 'package:myapp/Widget/styles.dart';
import 'editprofile.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<profile> {
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
            return CircularProgressIndicator(); // Show a loading indicator while waiting for the data.
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final userData = snapshot.data!;
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
                              backgroundImage: NetworkImage(
                                  'https://serving.photos.photobox.com/853892988c364763c7aad97da7e68041ca985eb1b1ba353fdbb4d95a917073bf11ccdaf4.jpg'),
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
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: Color.fromARGB(255, 107, 207, 255),
                    ),
                    padding: const EdgeInsets.only(left: 13),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(userData['Fullname'], style: TextDisplay),
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
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: Color.fromARGB(255, 107, 207, 255),
                    ),
                    padding: const EdgeInsets.only(left: 13),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(userData['Nickname'], style: TextDisplay),
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
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: Color.fromARGB(255, 107, 207, 255),
                    ),
                    padding: const EdgeInsets.only(left: 13),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(userData['Phone'], style: TextDisplay),
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
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: Color.fromARGB(255, 107, 207, 255),
                      ),
                      padding: const EdgeInsets.only(left: 13),
                      child: Column(mainAxisAlignment: MainAxisAlignment.center,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child:
                                  Text(userData['Email'], style: TextDisplay),
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
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: Color.fromRGBO(26, 116, 226, 1)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: <Widget>[
                        TextButton(
                          child:
                              Text("Edit Profile", style: itemWhiteDrawerText),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => editprofile()));
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
