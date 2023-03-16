import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:myapp/Database/dataBaseManager.dart';
import 'package:myapp/Models/destination_model.dart';
import 'package:myapp/Screen/homePage.dart';
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
  TextEditingController _destinationText = TextEditingController();
  TextEditingController _currenLocationText = TextEditingController();

  var uuid = Uuid();
  String _sessionToken = "122344";
  List<dynamic> _placesList = [];
  bool _isVisible = true;

  void onChange() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }

    getSuggesion(_destinationText.text);
  }

  void getSuggesion(String input) async {
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kGoogleApiKey&sessiontoken=$_sessionToken&language=multi';

    var response = await http.get(Uri.parse(request));

    if (response.statusCode == 200) {
      setState(() {
        _placesList = jsonDecode(response.body.toString())["predictions"];
      });
    } else {
      throw Exception("Fail to load data");
    }
  }

  @override
  void initState() {
    super.initState();
    _currenLocationText.addListener(() {
      onChange();
    });
    _destinationText.addListener(() {
      onChange();
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
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            size: 40,
            color: Color.fromRGBO(26, 116, 226, 1),
          ),
        ),
        title: Text(
          "Get Direction",
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: TextField(
                    controller: _currenLocationText,
                    decoration: InputDecoration(
                      hintText: "Where are you heading from ?",
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
                // Textfield Where are you going to ?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextField(
                    controller: _destinationText,
                    onTap: () {
                      _isVisible = true;
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
                // Current Location button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30)
                      .add(EdgeInsets.only(top: 20, bottom: 10)),
                  child: GestureDetector(
                    onTap: () {
                      print("Current station");
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.near_me,
                            size: 40,
                            color: Color.fromRGBO(26, 116, 226, 1),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Current station",
                            style: headerNormalText,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: Color.fromARGB(255, 148, 146, 146),
                  height: 15,
                  thickness: 1.5,
                  indent: 30,
                  endIndent: 30,
                ),
                SizedBox(
                  height: 10,
                ),
                //Choose on map button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: GestureDetector(
                    onTap: () {
                      print("Chose on map");
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
                            "Chose on map",
                            style: headerNormalText,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: GestureDetector(
                    onTap: () {
                      print("Get Direction");
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
                ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: ((context) => homePage()),
                      ),
                    );
                  },
                  child: Text("Get Direction"),
                ),
              ],
            ),
            if (_placesList.isNotEmpty)
              // Show Listview place
              Visibility(
                visible: _isVisible,
                child: Positioned(
                  top: 160, // Adjust this to fit your design
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Container(
                      color: Colors.white,
                      child: ListView.builder(
                        itemCount: _placesList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            onTap: () async {
                              List<Location> locations =
                                  await locationFromAddress(
                                      _placesList[index]['description']);
                              final Des = destination(
                                description: _placesList[index]['description'],
                                latitude: locations.last.latitude,
                                longitude: locations.last.longitude,
                              );

                              print(
                                  "${_placesList[index]['description']} latitude : ${locations.last.latitude}");
                              print(
                                  "${_placesList[index]['description']} longitude : ${locations.last.longitude}");

                              // Save Destination on Firebase
                              await dataBaseManager().saveLocation(Des);

                              setState(
                                () {
                                  _destinationText.text =
                                      _placesList[index]['description'];
                                  _placesList = [];
                                  _isVisible = false;
                                },
                              );
                            },
                            title: Text(_placesList[index]['description']),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
