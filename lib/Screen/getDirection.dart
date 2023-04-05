import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:myapp/Database/dataBaseManager.dart';
import 'package:myapp/Models/destination_model.dart';
import 'package:myapp/Screen/homePage.dart';
import 'package:myapp/Widget/alertBox.dart';
import 'package:myapp/Widget/styles.dart';
import 'package:myapp/variables.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class getDirection extends StatefulWidget {
  const getDirection({
    super.key,
  });

  @override
  State<getDirection> createState() => _getDirectionState();
}

class _getDirectionState extends State<getDirection> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController _destinationText = TextEditingController();

  var uuid = Uuid();
  String _sessionToken = "122344";
  List<dynamic> _destinationList = [];
  bool _isDestinationVisible = true;
  double current_latitude = 0;
  double current_longitude = 0;
  String current_description = '';

  void onDestinationChange() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }

    searchDestination(_destinationText.text);
  }

  void searchDestination(String input) async {
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kGoogleApiKey&sessiontoken=$_sessionToken&language=multi';

    var response = await http.get(Uri.parse(request));

    if (response.statusCode == 200) {
      setState(() {
        _destinationList = jsonDecode(response.body.toString())["predictions"];
      });
    } else {
      throw Exception("Fail to load data");
    }
  }

  Future<void> getCurrentLocation() async {
    if (auth.currentUser != null && auth.currentUser!.isAnonymous) {
      log('Guest current');
      Map<String, dynamic>? currentLocation =
          await dataBaseManager().guestfetchCurrentLocation();
      if (currentLocation != null) {
        log('fetchCurrentLocation complete ');
        current_latitude = currentLocation['current_latitude'];
        current_longitude = currentLocation['current_longitude'];
        current_description = currentLocation['description'];

        log('load Current_Latitude: $current_latitude, Current_Longitude: $current_longitude, Current_Description: $current_description');
      } else {
        log('Current location is null');
      }
    } else {
      log('Member current');
      Map<String, dynamic>? currentLocation =
          await dataBaseManager().fetchCurrentLocation();
      if (currentLocation != null) {
        log('fetchCurrentLocation complete ');
        current_latitude = currentLocation['current_latitude'];
        current_longitude = currentLocation['current_longitude'];
        current_description = currentLocation['description'];

        log('load Current_Latitude: $current_latitude, Current_Longitude: $current_longitude, Current_Description: $current_description');
      } else {
        log('Current location is null');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _destinationText.addListener(() {
      onDestinationChange();
    });
    getCurrentLocation();
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
          "Get Directions",
          style: headerText,
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                // Textfield Where are you heading from ?
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Container(
                    height: 60,
                    width: 400,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(107, 207, 255, 0.7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: Text(
                        current_description,
                        style: hintText,
                      )),
                    ),
                  ),
                ),
                // Textfield Where are you going to ?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextField(
                    controller: _destinationText,
                    onTap: () {
                      _isDestinationVisible = true;
                    },
                    decoration: InputDecoration(
                      hintText: "Where are you going to ?",
                      hintStyle: hintText,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      fillColor: Color.fromRGBO(107, 207, 255, 0.7),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Divider(
                  color: Color.fromARGB(255, 148, 146, 146),
                  height: 15,
                  thickness: 1.5,
                  indent: 30,
                  endIndent: 30,
                ),
                // SizedBox(
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: GestureDetector(
                    onTap: () {
                      if (auth.currentUser != null &&
                          auth.currentUser!.isAnonymous) {
                        alertBox.showAlertBox(context, "Please login",
                            "Login to use this function");
                      } else {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: ((context) => homePage()),
                          ),
                        );
                      }
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.map,
                            size: 40,
                            color: Color.fromRGBO(26, 116, 226, 1),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Get Direction",
                            style: headerNormalText,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (_destinationList.isNotEmpty)
              Visibility(
                visible: _isDestinationVisible,
                child: Positioned(
                  top: 180,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                    ),
                    child: Container(
                      color: Colors.green,
                      child: ListView.builder(
                          itemCount: _destinationList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              onTap: () async {
                                try {
                                  List<Location> locations =
                                      await locationFromAddress(
                                          _destinationList[index]
                                              ['description']);
                                  final Des = destination(
                                    description: _destinationList[index]
                                        ['description'],
                                    latitude: locations.last.latitude,
                                    longitude: locations.last.longitude,
                                  );
                                  log("${_destinationList[index]['description']} latitude : ${locations.last.latitude}");
                                  log("${_destinationList[index]['description']} longitude : ${locations.last.longitude}");
                                  // Save Destination on Firebase
                                  if (auth.currentUser != null &&
                                      auth.currentUser!.isAnonymous) {
                                    await dataBaseManager()
                                        .gusetsaveLocation(Des);
                                  } else {
                                    await dataBaseManager().saveLocation(Des);
                                  }

                                  setState(
                                    () {
                                      _destinationText.text =
                                          _destinationList[index]
                                              ['description'];
                                      _destinationList = [];
                                      _isDestinationVisible = false;
                                    },
                                  );
                                } catch (e) {
                                  log('Error : $e');
                                }
                              },
                              title:
                                  Text(_destinationList[index]['description']),
                            );
                          }),
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
