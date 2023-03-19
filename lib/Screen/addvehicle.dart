// ignore_for_file: prefer_const_constructors, duplicate_import, file_names, duplicate_ignore, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Database/authService.dart';
import 'package:myapp/Screen/homePage.dart';

class AddVehicle extends StatefulWidget {
  const AddVehicle({Key? key}) : super(key: key);

  @override
  State<AddVehicle> createState() => AddVehicleState();
}

class AddVehicleState extends State<AddVehicle> {
  static const List<String> brands = [
    "Tesla",
    "Chevrolet",
    "Ford",
    "Porsche",
    "Mercedes-Benz",
    "BMW",
    "Nissan",
    "Honda",
    "Toyota",
    "Volkswagen",
    "Hyundai",
    "Jaguar",
    "Mini",
    "Audi",
    "Kia"
  ];

  static const List<String> types = ["Type 1", "Type 2", "CCS", "CHAdeMO"];

  String? _selectedBrand;
  String? _selectedType;
  final _LicenseNum = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        leading: BackButton(color: Color.fromRGBO(26, 116, 226, 1)),
        // ignore: prefer_const_constructors
        title: Text("Add YourVehicle", style: Mytextstyle.blue19),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 23),
            child: Text("Brand", style: Mytextstyle.blue15),
          ),
          Align(
              alignment: Alignment.center,
              child: SizedBox(
                  // padding:
                  //     const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  width: 350,
                  height: 52,
                  child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        value: _selectedBrand,
                        onChanged: (value) {
                          setState(() {
                            _selectedBrand = value;
                            print('Type :  $_selectedBrand');
                          });
                        },
                        // ignore: avoid_unnecessary_containers
                        hint: Container(
                            child: Text(
                          'Select your car brand',
                          style: TextStyle(
                              color: Color.fromRGBO(107, 207, 255, 1)),
                          textAlign: TextAlign.left,
                        )),
                        // set the color of the dropdown menu
                        dropdownColor: Color.fromARGB(255, 255, 255, 255),
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Color.fromRGBO(26, 116, 226, 1),
                        ),
                        isExpanded: true,

                        // The list of options
                        items: brands
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      e,
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ))
                            .toList(),
                        selectedItemBuilder: (BuildContext context) => brands
                            .map((e) => Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(e,
                                          textAlign: TextAlign.left,
                                          style: Mytextstyle.blue19),
                                    ]))
                            .toList(),
                      )))),
          // SizedBox(
          //   height: 10,
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 23),
          //   child: Text("Model", style: Mytextstyle.blue15),
          // ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 23),
            child: Text("Charger type", style: Mytextstyle.blue15),
          ),
          Align(
              alignment: Alignment.center,
              child: SizedBox(
                  // padding:
                  //     const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  width: 350,
                  height: 52,
                  child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        value: _selectedType,
                        onChanged: (value1) {
                          setState(() {
                            _selectedType = value1;
                            print('Type :  $_selectedType');
                          });
                        },
                        // ignore: avoid_unnecessary_containers
                        hint: Container(
                            child: Text(
                          'Select your charger type',
                          style: TextStyle(
                              color: Color.fromRGBO(107, 207, 255, 1)),
                          textAlign: TextAlign.left,
                        )),
                        // set the color of the dropdown menu
                        dropdownColor: Color.fromARGB(255, 255, 255, 255),
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Color.fromRGBO(26, 116, 226, 1),
                        ),
                        isExpanded: true,

                        // The list of options
                        items: types
                            .map((value1) => DropdownMenuItem(
                                  value: value1,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      value1,
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ))
                            .toList(),
                        selectedItemBuilder: (BuildContext context) => types
                            .map((d) => Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(d,
                                          textAlign: TextAlign.left,
                                          style: Mytextstyle.blue19),
                                    ]))
                            .toList(),
                      )))),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 23),
            child: Text("License Number", style: Mytextstyle.blue15),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
                width: 350,
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                padding: const EdgeInsets.only(left: 13),
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: <Widget>[
                      Align(
                          alignment: Alignment.centerLeft,
                          child: TextField(
                            controller: _LicenseNum,
                            decoration: InputDecoration(
                                hintText: "Enter your License number",
                                hintStyle: TextStyle(
                                  color: Color.fromRGBO(107, 207, 255, 1),
                                )),
                            style: TextStyle(
                                color: Color.fromRGBO(26, 116, 226, 1),
                                fontWeight: FontWeight.w400,
                                fontFamily: "Montserrat",
                                fontStyle: FontStyle.normal,
                                fontSize: 19.0),
                          ))
                    ])),
          ),
          SizedBox(
            height: 40,
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
                width: 350,
                height: 52,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Color.fromRGBO(142, 219, 255, 0.543)),
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: <Widget>[
                      TextButton(
                        child: Text(
                          "Confirm",
                          style: TextStyle(
                              color: Color.fromRGBO(26, 116, 226, 1),
                              fontWeight: FontWeight.w500,
                              fontFamily: "Montserrat",
                              fontStyle: FontStyle.normal,
                              fontSize: 21.0),
                        ),
                        onPressed: () async {
                          await authService()
                              .addVehicle(_selectedBrand!, _selectedType!,
                                  _LicenseNum.text)
                              .then(
                                (value) => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => homePage(),
                                  ),
                                ),
                              );
                        },
                      )
                    ])),
          ),
          SizedBox(
            height: 20,
          ),
          Image.network(
              "https://cdn.discordapp.com/attachments/1056191443657572372/1076447327302189076/image_2.jpg")
        ],
      ),
    );
  }
}

class Mytextstyle {
  static const TextStyle black21 = TextStyle(
      color: Color.fromRGBO(0, 0, 0, 1),
      fontWeight: FontWeight.w500,
      fontFamily: "Montserrat",
      fontStyle: FontStyle.normal,
      fontSize: 21.0);

  static const TextStyle blue19 = TextStyle(
      color: Color.fromRGBO(26, 116, 226, 1),
      fontWeight: FontWeight.w400,
      fontFamily: "Montserrat",
      fontStyle: FontStyle.normal,
      fontSize: 19.0);

  static const TextStyle blue15 = TextStyle(
      color: Color.fromRGBO(26, 116, 226, 1),
      fontWeight: FontWeight.bold,
      fontFamily: "Montserrat",
      fontStyle: FontStyle.normal,
      fontSize: 15.0);
}
