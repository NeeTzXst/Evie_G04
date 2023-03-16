import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget howToUsePage(
        {required Color color,
        required String urlImg,
        required String title,
        required String subtitle,
        required BuildContext context,
        required Widget name}) =>
    Container(
      color: color,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: ((context) => name)));
                  },
                  child: Text(
                    "Skip",
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(22, 40, 88, 1))),
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: Image.asset(
              urlImg,
              fit: BoxFit.contain,
              width: 300,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Container(
              width: 400,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(0, 0, 0, 1))),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Container(
              width: 350,
              child: Text(
                subtitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(113, 113, 113, 1))),
              ),
            ),
          ),
        ],
      ),
    );
