import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/Screen/checkout.dart';
import 'package:myapp/Widget/styles.dart';
import 'package:slide_countdown/slide_countdown.dart';

class timeRemining extends StatefulWidget {
  const timeRemining({super.key});

  @override
  State<timeRemining> createState() => _timeReminingState();
}

class _timeReminingState extends State<timeRemining> {
  Duration _duration = Duration(hours: 2);
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
          "Time Reminings",
          style: headerText,
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      child: Image.asset(
                        'assets/messageImage_1677661037176.jpg',
                        width: 300,
                        height: 250,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: Text(
                        "Parking time",
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(0, 0, 0, 1),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: Center(
                        child: SlideCountdown(
                          duration: _duration,
                          slideDirection: SlideDirection.down,
                          separator: ":",
                          separatorType: SeparatorType.symbol,
                          decoration: BoxDecoration(color: Colors.white),
                          textStyle: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(0, 0, 0, 1),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: ((context) => checkout()),
                      ),
                    );
                  },
                  child: Container(
                    width: 170,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        "Finished",
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(0, 0, 0, 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Container(
//               child: Image.asset(
//                 'assets/messageImage_1677661037176.jpg',
//                 width: 300,
//                 height: 250,
//               ),
//             ),
//             Container(
//               child: Text(
//                 "Parking time",
//                 style: GoogleFonts.montserrat(
//                   textStyle: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.w600,
//                     color: Color.fromRGBO(0, 0, 0, 1),
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               child: Center(
//                 child: SlideCountdown(
//                   duration: _duration,
//                   slideDirection: SlideDirection.down,
//                   separator: ":",
//                   separatorType: SeparatorType.symbol,
//                   decoration: BoxDecoration(color: Colors.white),
//                   textStyle: GoogleFonts.montserrat(
//                     textStyle: TextStyle(
//                       fontSize: 50,
//                       fontWeight: FontWeight.w700,
//                       color: Color.fromRGBO(0, 0, 0, 1),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             GestureDetector(
//               onTap: () {
//                 // Navigator.of(context).push(
//                 //   MaterialPageRoute(
//                 //     builder: ((context) => checkOut()),
//                 //   ),
//                 // );
//               },
//               child: Container(
//                 width: 150,
//                 height: 50,
//                 decoration: BoxDecoration(
//                   color: Colors.blue,
//                   borderRadius: BorderRadius.circular(18),
//                 ),
//                 child: Center(
//                   child: Text(
//                     "Finished",
//                     style: GoogleFonts.montserrat(
//                       textStyle: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w500,
//                         color: Color.fromRGBO(0, 0, 0, 1),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
