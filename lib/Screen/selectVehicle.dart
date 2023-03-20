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
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  elevation: 4,
                  child: Container(
                    height: 120,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${snapshot.data!.docs[index].get('Brand')}",
                            ),
                            Image.asset(
                              'assets/EVIE.png',
                              width: 80,
                              height: 80,
                            ),
                          ],
                        ),
                        VerticalDivider(
                          thickness: 0.1,
                          color: Colors.black,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${snapshot.data!.docs[index].get('Charger type')}",
                              style: itemDrawerText,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${snapshot.data!.docs[index].get('License Number')}",
                              style: itemDrawerText,
                            ),
                          ],
                        )
                      ],
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
// "${snapshot.data!.docs[index].get('Brand')}"
