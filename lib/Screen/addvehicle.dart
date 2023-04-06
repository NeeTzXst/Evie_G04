// ignore_for_file: prefer_const_constructors, duplicate_import, file_names, duplicate_ignore, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Database/authService.dart';
import 'package:myapp/Screen/Drawer/myCar.dart';
import 'package:myapp/Screen/homePage.dart';
import 'package:myapp/Widget/styles.dart';
import 'package:myapp/Widget/alertBox.dart';

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
        // ignore: prefer_const_constructors
        title: Text("Add Your Vehicle", style: headerText),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 23),
            child: Text("Brand", style: hintText),
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
                          style: hintTextlight,
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
                                          style: BlueDisplay),
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
            child: Text("Charger type", style: hintText),
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
                          style: hintTextlight,
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
                                          style: BlueDisplay),
                                    ]))
                            .toList(),
                      )))),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 23),
            child: Text("License Number", style: hintText),
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
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                              style: TextDisplay))
                    ])),
          ),
          SizedBox(
            height: 40,
          ),
          Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  if (_selectedBrand == null) {
                    alertBox.showAlertBox(
                        context, 'Error', 'Please select Car Brand');
                  } else if (_selectedType == null) {
                    alertBox.showAlertBox(
                        context, 'Error', 'Please select Charger type');
                  } else if (_LicenseNum.text.isEmpty) {
                    alertBox.showAlertBox(
                        context, 'Error', 'Please Enter License Number');
                  } else {
                    authService().addVehicle(_selectedBrand!, _selectedType!,
                        _LicenseNum.text, context);
                  }
                },
                child: Container(
                    width: 350,
                    height: 52,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: Color.fromRGBO(142, 219, 255, 0.543)),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: <Widget>[
                          Center(
                            child: Text("Confirm", style: itemDrawerText),
                          )
                        ])),
              )),
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
