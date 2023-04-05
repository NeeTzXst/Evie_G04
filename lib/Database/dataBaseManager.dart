import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/Models/currentLocation_model.dart';
import 'package:myapp/Models/destination_model.dart';

class dataBaseManager {
  String get userUID => FirebaseAuth.instance.currentUser!.uid;

  DocumentReference get appMember {
    return FirebaseFirestore.instance
        .collection('app')
        .doc('member')
        .collection('ID')
        .doc(userUID);
  }

  DocumentReference get appGuest {
    return FirebaseFirestore.instance
        .collection('app')
        .doc('guest')
        .collection('ID')
        .doc(userUID);
  }

  // Save Destination
  Future<void> saveLocation(destination des) async {
    log('Save Location');
    log(
      'latitude : ' + des.latitude.toString(),
    );
    log(
      'longitude : ' + des.latitude.toString(),
    );
    log(
      'des : ' + des.description.toString(),
    );
    await appMember.update(des.toJson());
  }

  Future<void> gusetsaveLocation(destination des) async {
    log('Guest Save Location');
    log(
      'latitude : ' + des.latitude.toString(),
    );
    log(
      'longitude : ' + des.latitude.toString(),
    );
    log(
      'des : ' + des.description.toString(),
    );
    await appGuest.update(des.toJson());
  }

  Future<void> guestsaveCurrenLocation(currentLocation current) async {
    log('Guest save CurrentLocation');
    log(
      'latitude : ' + current.latitude.toString(),
    );
    log(
      'longitude : ' + current.latitude.toString(),
    );
    log(
      'des : ' + current.description.toString(),
    );
    await appGuest.update(current.toJson());
  }

  //Save Current Location,Latitude, Longitude
  Future<void> saveCurrentLocation(currentLocation current) async {
    log('Save CurrentLocation');
    log(
      'latitude : ' + current.latitude.toString(),
    );
    log(
      'longitude : ' + current.latitude.toString(),
    );
    log(
      'des : ' + current.description.toString(),
    );
    await appMember.update(current.toJson());
  }

  Future<Map<String, dynamic>?> fetchCurrentLocation() async {
    log('member fetch CurrentLocation');
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

  Future<Map<String, dynamic>?> guestfetchCurrentLocation() async {
    log('guest fetch CurrentLocation');
    DocumentReference<Map<String, dynamic>> userDoc = await FirebaseFirestore
        .instance
        .collection('app')
        .doc('guest')
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
    log('member fetch DestinationLocation');
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

  Future<Map<String, dynamic>?> guestfetchDestinationLocation() async {
    log('guest fetch DestinationLocation');
    DocumentReference<Map<String, dynamic>> userDoc = FirebaseFirestore.instance
        .collection('app')
        .doc('guest')
        .collection('ID')
        .doc(userUID);
    DocumentSnapshot<Map<String, dynamic>> docSnapshot = await userDoc.get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      Map<String, dynamic>? DestinationLocation = data?['Destination'];
      return DestinationLocation;
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
}
