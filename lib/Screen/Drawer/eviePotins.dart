import 'package:flutter/material.dart';
import 'package:myapp/Widget/styles.dart';

class eviePoints extends StatefulWidget {
  const eviePoints({super.key});

  @override
  State<eviePoints> createState() => _eviePointsState();
}

class _eviePointsState extends State<eviePoints> {
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
          "Evie Points",
          style: headerText,
        ),
      ),
    );
  }
}
