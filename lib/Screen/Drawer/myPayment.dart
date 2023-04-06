import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Screen/AddCreditCard.dart';
import 'package:myapp/Screen/homePage.dart';
import 'package:myapp/Widget/styles.dart';
import '../flutter_flow/flutter_flow_theme.dart';

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
  String get userUID => FirebaseAuth.instance.currentUser!.uid;
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    FocusNode? _unfocusNode;
    return Scaffold(
        floatingActionButton: SizedBox(
          width: 350,
          height: 60,
          child: FloatingActionButton.extended(
            backgroundColor: primaryColor,
            label: Text(
              "Add Credit Card",
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
            "My Payment Methods",
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
              if (!snapshot.hasData) {
                return Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            side: BorderSide(color: Colors.black, width: 0.1),
                          ),
                          elevation: 7,
                        ))
                  ],
                );
              }
              if (snapshot.hasData) {
                return ListView(children: [
                  Container(
                      width: 460,
                      child: ListView.builder(
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (context, index) {
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      // padding: const EdgeInsets.symmetric(horizontal: 10),
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 10, 10, 0),
                                      child: GestureDetector(
                                        onTap: () {
                                          // Perform the desired action when the card is tapped.
                                          print("card pressed..");
                                        },
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  5, 0, 5, 0),
                                          child: SizedBox(
                                            height: 120,
                                            width: 360,
                                            child: Card(
                                              elevation: 0,
                                              color: Color.fromARGB(
                                                  255, 107, 207, 255),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              child: Column(
                                                children: [
                                                  ListTile(
                                                    title: Text(
                                                      "${snapshot.data!.docs[index].get('cardNumber')}",
                                                      style: TextStyle(
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Color(0xFF001D42),
                                                        fontFamily:
                                                            'Montserrat',
                                                      ),
                                                    ),
                                                    subtitle: Text(
                                                      "${snapshot.data!.docs[index].get('expirationM').get('expirationY')}",
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        // fontWeight: FontWeight.bold,
                                                        color:
                                                            Color(0xFF001D42),
                                                        fontFamily:
                                                            'Montserrat',
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
                            );
                          }))
                ]);
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
