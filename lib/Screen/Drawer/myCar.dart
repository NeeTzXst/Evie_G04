import 'package:flutter/material.dart';
import 'package:myapp/Widget/styles.dart';

class myCar extends StatefulWidget {
  const myCar({super.key});

  @override
  State<myCar> createState() => _myCarState();
}

class _myCarState extends State<myCar> {
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
          "My Cars",
          style: headerText,
        ),
      ),
    );
  }
}
