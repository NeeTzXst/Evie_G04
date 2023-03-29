import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/Widget/styles.dart';
import 'package:qr/qr.dart';
import 'package:qr_flutter/qr_flutter.dart';

class checkout extends StatefulWidget {
  const checkout({super.key});

  @override
  State<checkout> createState() => _checkoutState();
}

class _checkoutState extends State<checkout> {
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
          "Check Out",
          style: headerText,
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Center(
            child: Text(
              "Scan this QR Code for Checkout",
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(113, 113, 113, 1),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              "04 Charging Spot",
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            width: 260,
            height: 260,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: QrImage(
              version: QrVersions.auto,
              data: "data",
              padding: EdgeInsets.all(25),
              foregroundColor: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
