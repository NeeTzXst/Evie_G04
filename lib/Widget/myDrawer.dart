import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Database/authService.dart';
import 'package:myapp/Screen/Drawer/eviePotins.dart';
import 'package:myapp/Screen/Drawer/financialNews.dart';
import 'package:myapp/Screen/Drawer/helpCenter.dart';
import 'package:myapp/Screen/Drawer/history.dart';
import 'package:myapp/Screen/Drawer/howToUse.dart';
import 'package:myapp/Screen/Drawer/myCar.dart';
import 'package:myapp/Screen/Drawer/myPayment.dart';
import 'package:myapp/Screen/Drawer/profile.dart';
import 'package:myapp/Screen/Drawer/setting.dart';
import 'package:myapp/Screen/letyouin.dart';
import 'package:myapp/Widget/styles.dart';

class myDrawer extends StatefulWidget {
  const myDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<myDrawer> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<myDrawer> {
  User? currentUser;
  List<Widget>? drawerItem;

  String get userUID {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return 'No user';
    } else {
      return user.uid;
    }
  }

  DocumentReference get userDocument {
    final docRef = FirebaseFirestore.instance
        .collection('app')
        .doc('member')
        .collection('ID')
        .doc(userUID);
    return docRef;
  }

  Future<DocumentSnapshot> getUserData() async {
    return await userDocument.get();
  }

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
  }

  Widget memberHeader(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: getUserData(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.hasData && snapshot.data!.exists) {
          final userData = snapshot.data!;
          final userUid = FirebaseAuth.instance.currentUser!.uid;
          final image =
              FirebaseStorage.instance.ref().child('$userUid/profile.jpg');
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
                  return CircularProgressIndicator(); // Show a loading indicator while waiting for the image URL.
                } else if (imageUrlSnapshot.hasError) {
                  return Text('Error: ${imageUrlSnapshot.error}');
                } else {
                  final imageUrl = imageUrlSnapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.arrow_back,
                                size: 45,
                                color: primaryColor,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => profile()),
                              );
                            },
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 45,
                                  backgroundColor: primaryColor,
                                  backgroundImage: NetworkImage(imageUrl),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Container(
                                  width: 175,
                                  child: Text(
                                    userData['Fullname'],
                                    style: ProfileDrawerText,
                                    overflow: TextOverflow.clip,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }
              });
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget memberMenu(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Column(
        children: [
          ListTile(
            title: Text(
              'My Payment methods',
              style: itemDrawerText,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => myPayment(),
                ),
              );
            },
          ),
          ListTile(
            title: Text(
              'My Car',
              style: itemDrawerText,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => myCar(),
                ),
              );
            },
          ),
          ListTile(
            title: Text(
              'History',
              style: itemDrawerText,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => history(),
                ),
              );
            },
          ),
          ListTile(
            title: Text(
              'Financial News',
              style: itemDrawerText,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => financialNews(),
                ),
              );
            },
          ),
          ListTile(
            title: Text(
              'Evie Point',
              style: itemDrawerText,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => eviePoints(),
                ),
              );
            },
          ),
          ListTile(
            title: Text(
              'Help Center',
              style: itemDrawerText,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => helpCenter(),
                ),
              );
            },
          ),
          ListTile(
            title: Text(
              'How to use',
              style: itemDrawerText,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => howToUse(),
                ),
              );
            },
          ),
          ListTile(
            title: Text(
              'Setting',
              style: itemDrawerText,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => setting(),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 55),
            child: ListTile(
              title: Center(
                child: Text(
                  'Logout',
                  style: itemDrawerlogputText,
                ),
              ),
              onTap: () {
                authService().signOut(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget guestHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 15),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Row(
              children: [
                Icon(
                  Icons.arrow_back,
                  size: 45,
                  color: primaryColor,
                )
              ],
            ),
          ),
          Image.asset(
            'assets/EVIE.png',
            width: 150,
            height: 150,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => LetyouIn()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Container(
                width: 250,
                height: 55,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    "Sign in to Evie",
                    style: itemWhiteDrawerText,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget guestMenu(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Column(
        children: [
          ListTile(
            title: Text(
              'Financial News',
              style: itemDrawerText,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => financialNews(),
                ),
              );
            },
          ),
          ListTile(
            title: Text(
              'Help Center',
              style: itemDrawerText,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => helpCenter(),
                ),
              );
            },
          ),
          ListTile(
            title: Text(
              'How to use',
              style: itemDrawerText,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => howToUse(),
                ),
              );
            },
          ),
          ListTile(
            title: Text(
              'Setting',
              style: itemDrawerText,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => setting(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            currentUser == null || currentUser!.isAnonymous
                ? guestHeader(context)
                : memberHeader(context),
            currentUser == null || currentUser!.isAnonymous
                ? guestMenu(context)
                : memberMenu(context),
          ],
        ),
      ),
    );
  }
}
