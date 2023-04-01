// ignore_for_file: unused_local_variable
import 'package:flutter/material.dart';
import 'package:myapp/Screen/homePage.dart';
import 'package:myapp/Widget/styles.dart';

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
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
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
        body: ListView
        (children: <Widget>[
          SizedBox(
              height: 100,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.payment),
                              border: InputBorder.none,
                              hintText: 'Card',
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]
                )
              )
            ]
          )
        );
  }
}
