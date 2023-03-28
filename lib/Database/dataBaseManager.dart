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
    await appMember.update(des.toJson());
  }

  //Save Current Location,Latitude, Longitude
  Future<void> saveCurrentLocation(currentLocation current) async {
    await appMember.update(current.toJson());
  }

  //Get Current Location
  Future<currentLocation> getCurrentLocation() async {
    final snapshot = await location.doc('CurrentLocation').get();
    final data = snapshot.data() as Map<String, dynamic>;
    final description = (data)["description"];
    final latitude = (data)["latitude"];
    final longitude = (data)["longitude"];
    //print("data ${data}");
    return currentLocation(
      description: description,
      latitude: latitude ?? 0.0,
      longitude: longitude ?? 0.0,
    );
  }

  //Get Destination Location
  Future<destination> getDestinationLocation() async {
    final snapshot = await location.doc('Destination').get();
    final data = snapshot.data() as Map<String, dynamic>;
    return destination.fromJson(data);
  }
}
