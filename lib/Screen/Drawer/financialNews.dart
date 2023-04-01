import 'package:flutter/material.dart';
import 'package:myapp/Widget/styles.dart';

class financialNews extends StatefulWidget {
  const financialNews({super.key});

  @override
  State<financialNews> createState() => _financialNewsState();
}

class _financialNewsState extends State<financialNews> {
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
          "Financial News",
          style: headerText,
        ),
      ),
      body: ListView(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Colors.black, width: 0.01),
                  ),
                  elevation: 7,
                  child: Container(
                    height: 120,
                    child: Row(children: [
                      Container(
                        width: 350,
                        height: 110,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Brand",
                              style: hintTextBlack,
                            ),
                            Image.asset(
                              'assets/Audi Car.png',
                              width: 120,
                              height: 80,
                            ),
                          ],
                        ),
                      ),
                    ]),
                  )))
        ],
      ),
    );
  }
}
