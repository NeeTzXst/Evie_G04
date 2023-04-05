// ignore_for_file: unused_local_variable
import 'package:flutter/material.dart';
import 'package:myapp/Screen/homePage.dart';
import 'package:myapp/Widget/styles.dart';

import '../AddCreditCard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: myPayment(),
    );
  }
}

class myPayment extends StatefulWidget {
  const myPayment({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  myPaymentState createState() => myPaymentState();
}

class myPaymentState extends State<myPayment> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    FocusNode? _unfocusNode;
    return Scaffold(
        //  extendBodyBehindAppBar: true,
        floatingActionButton: SizedBox(
          width: 350,
          height: 60,
          child: FloatingActionButton.extended(
            backgroundColor: secondColor,
            label: Text(
              "Add New Credit Card",
              style: headerText,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddCreditCardWidget()));
            },
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              print("pressed");
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => homePage(),
                ),
              );
            },
            child: Icon(
              Icons.arrow_back,
              size: 40,
              color: Color.fromRGBO(26, 116, 226, 1),
            ),
          ),
          title: Text(
            "Payment Methods",
            style: headerText,
          ),
        ),
        body: ListView(children: <Widget>[
          Container(
              width: 460,
              // height: 510,
              child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          // padding: const EdgeInsets.symmetric(horizontal: 10),
                          padding:
                              EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                          child: GestureDetector(
                            onTap: () {
                              // Perform the desired action when the card is tapped.
                              print("card pressed..");
                            },
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                              child: SizedBox(
                                height: 120,
                                width: 360,
                                child: Card(
                                  elevation: 0,
                                  color: Color.fromARGB(255, 107, 207, 255),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Padding(
                                            padding: EdgeInsets.only(top: 20),
                                            child: Text(
                                              '1111 2222 3333 4444',
                                              style: BlueDisplayBold,
                                            )),
                                        subtitle: Padding(
                                            padding: EdgeInsets.only(top: 20),
                                            child: Text(
                                              'Expires 09/28',
                                              style: BlueDisplayBold,
                                            )),
                                        leading: Icon(
                                          Icons.credit_card,
                                          size: 80,
                                          // color: Color(0xFF3FA0EF),
                                          color: Colors.black,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]))
        ]));
  }
}
