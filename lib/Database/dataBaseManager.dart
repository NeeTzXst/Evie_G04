import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/Models/currentLocation_model.dart';
import 'package:myapp/Models/destination_model.dart';

class dataBaseManager {
  final CollectionReference location =
      FirebaseFirestore.instance.collection('Test');

  String get userUID => FirebaseAuth.instance.currentUser!.uid;

  DocumentReference get appMember {
    return FirebaseFirestore.instance
        .collection('app')
        .doc('member')
        .collection('ID')
        .doc(userUID);
  }

  // Save Destination
  Future<void> saveLocation(destination des) async {
    log('saveLocation');
    await appMember.update(des.toJson());
  }

  //Save Current Location,Latitude, Longitude
  Future<void> saveCurrentLocation(currentLocation current) async {
    await appMember.update(current.toJson());
  }

  Future<Map<String, dynamic>?> fetchCurrentLocation() async {
    DocumentReference<Map<String, dynamic>> userDoc = FirebaseFirestore.instance
        .collection('app')
        .doc('member')
        .collection('ID')
        .doc(userUID);
    DocumentSnapshot<Map<String, dynamic>> docSnapshot = await userDoc.get();

    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      Map<String, dynamic>? currentLocation = data?['Current_Location'];
      return currentLocation;
    }
    throw Exception('Document does not exist on the database');
  }

  Future<Map<String, dynamic>?> fetchDestinationLocation() async {
    DocumentReference<Map<String, dynamic>> userDoc = FirebaseFirestore.instance
        .collection('app')
        .doc('member')
        .collection('ID')
        .doc(userUID);
    DocumentSnapshot<Map<String, dynamic>> docSnapshot = await userDoc.get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      Map<String, dynamic>? currentLocation = data?['Destination'];
      return currentLocation;
    }
    throw Exception('Document does not exist on the database');
  }

  Future<Map<String, dynamic>?> fetchChargingType(String id) async {
    DocumentReference<Map<String, dynamic>> locationDoc = FirebaseFirestore
        .instance
        .collection('web')
        .doc('owner')
        .collection('charging_station')
        .doc(id);

    DocumentSnapshot<Map<String, dynamic>> docSnapshot =
        await locationDoc.get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      Map<String, dynamic>? currentLocation = data?['Destination'];
      return currentLocation;
    }
    throw Exception('Document does not exist on the database');
  }

  //Get Destination Location
  Future<destination> getDestinationLocation() async {
    final snapshot = await location.doc('Destination').get();
    final data = snapshot.data() as Map<String, dynamic>;
    return destination.fromJson(data);
  }
}
