// ignore_for_file: unused_local_variable
import 'package:flutter/material.dart';
import 'package:myapp/Screen/AddCreditCard.dart';
import 'package:myapp/Screen/homePage.dart';
import 'package:myapp/Widget/styles.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  myPaymentState createState() => myPaymentState();
}

class myPaymentState extends State<myPayment> {
  String get userUID => FirebaseAuth.instance.currentUser!.uid;
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: SizedBox(
          width: 350,
          height: 60,
          child: FloatingActionButton.extended(
            backgroundColor: primaryColor,
            label: Text(
              "Add Payment Methods",
              style: itemWhiteDrawerText,
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
            "Payment Methods",
            style: headerText,
          ),
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('app')
                .doc('member')
                .collection('ID')
                .doc(userUID)
                .collection('Card')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Error');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    body: ListView(children: <Widget>[
          Container(
              width: 460,
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                          child: GestureDetector(
                            onTap: () {
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
                                        title: Text(
                                          "${snapshot.data!.docs[index].get('cardNumber')}",
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF001D42),
                                            fontFamily: 'Montserrat',
                                          ),
                                        ),
                                        subtitle: Text(
                                          "${snapshot.data!.docs[index].get('expirationM')}",
                                          style: TextStyle(
                                            fontSize: 18,
                                            // fontWeight: FontWeight.bold,
                                            color: Color(0xFF001D42),
                                            fontFamily: 'Montserrat',
                                          ),
                                        ),
                                        leading: Icon(
                                          Icons.credit_card,
                                          size: 80,
                                          // color: Color(0xFF3FA0EF),
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ]
          );
        },
      );
    }
              return Center(
            child: CircularProgressIndicator(),
          );
        }
      )
    );
  }
}
