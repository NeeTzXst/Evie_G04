import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Screen/BookTimes.dart';
import 'package:myapp/Screen/qrCode.dart';

import '../flutter_flow/flutter_flow_drop_down.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';

class makePaymentWidget extends StatefulWidget {
  final bookingId;
  final duration;
  final stationID;
  makePaymentWidget({super.key, this.bookingId, this.duration, this.stationID});
  @override
  _MakePaymentWidgetState createState() => _MakePaymentWidgetState();
}

var station;

class _MakePaymentWidgetState extends State<makePaymentWidget> {
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  static const List<String> coupon = [
    "25% off Charging prices",
    "50% off Charging prices"
  ];

  CollectionReference bookingsRef = FirebaseFirestore.instance.collection(
      '/web/owner/charging Station/$charging/charging Spot/$spot/booking');

  DocumentReference stationRef = FirebaseFirestore.instance
      .collection('/web/owner/charging Station')
      .doc(station);

  Future<String?> getData() async {
    final db = FirebaseFirestore.instance;
    var docRef = db.collection('/web/owner/charging Station').doc(station);

    try {
      log('try');
      var doc = await docRef.get();
      if (doc.exists) {
        var data = doc.data()!;
        int price = data['charging_price'];
        log(price.toString());
        return price.toString();
      } else {
        print("Document does not exist");
        return null;
      }
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<void> deleteBooking() async {
    log(widget.bookingId);
    bookingsRef.doc(widget.bookingId).delete();
    log("deleteBooking");
  }

  String? _selectedCoupon;
  @override
  Widget build(BuildContext context) {
    log(stationRef.toString());
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xFF1A74E2),
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
            child: InkWell(
              onTap: () async {
                deleteBooking().then((value) {
                  Navigator.pop(context);
                });
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 33,
              ),
            ),
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 400,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Color(0xFF1A74E2),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(200),
                      bottomRight: Radius.circular(200),
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        child: Image(
                          image: NetworkImage(
                            'https://media.discordapp.net/attachments/1056191443657572372/1086294835402641509/icon.png?width=126&height=126',
                          ),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Text(
                          'CARD',
                          style: FlutterFlowTheme.of(context)
                              .subtitle1
                              .override(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                        child: Text(
                          '5000',
                          style: FlutterFlowTheme.of(context).title1.override(
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                              fontSize: 50,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Text(
                          'Amount to be paid',
                          style: FlutterFlowTheme.of(context)
                              .bodyText1
                              .override(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                  child: Text(
                    'CARD DETAILS',
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Montserrat',
                          color: Color(0xFF1A74E2),
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 15, 20, 0),
                  child: TextFormField(
                    textCapitalization: TextCapitalization.none,
                    obscureText: false,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide:
                              BorderSide(color: Color(0xFF6BCFFF), width: 2)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide:
                              BorderSide(color: Color(0xFF6BCFFF), width: 2)),
                      hintText: 'FIRST - LAST NAME',
                      hintStyle: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Montserrat',
                        color: Color(0xFF1A74E2),
                      ),
                    ),
                    textAlign: TextAlign.center,
                    maxLines: null,
                    validator: (value) {
                      if (value!.isEmpty) {
                        print(value);
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      // do something when the text is changed
                      print(value);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 15, 20, 0),
                  child: TextFormField(
                    textCapitalization: TextCapitalization.none,
                    obscureText: false,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.payment,
                        color: Color(0xff6bcfff),
                        size: 28,
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide:
                              BorderSide(color: Color(0xFF6BCFFF), width: 2)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide:
                              BorderSide(color: Color(0xFF6BCFFF), width: 2)),
                      hintText: '**** **** **** 1234',
                      hintStyle: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Montserrat',
                        color: Color(0xFF1A74E2),
                      ),
                    ),
                    textAlign: TextAlign.center,
                    maxLines: null,
                    validator: (value) {
                      if (value!.isEmpty) {
                        print(value);
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      // do something when the text is changed
                      print(value);
                    },
                  ),
                ),
                Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: SizedBox(
                      width: 352,
                      height: 60,
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                  color: Color(0xFF6BCFFF), width: 2)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                  color: Color(0xFF6BCFFF), width: 2)),
                        ),
                        value: _selectedCoupon,
                        onChanged: (value) {
                          setState(() {
                            _selectedCoupon = value;
                            print('Coupon :  $_selectedCoupon');
                          });
                        },
                        hint: Container(
                            child: Text(
                          'Select Coupon',
                          style: TextStyle(
                              color: Color(0xFF1A74E2),
                              fontFamily: 'Montserrat',
                              fontSize: 18),
                          textAlign: TextAlign.left,
                        )),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Color(0xFF1A74E2),
                          size: 28,
                        ),
                        isExpanded: true,
                        // The list of options
                        items: coupon
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      e,
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ))
                            .toList(),
                        selectedItemBuilder: (BuildContext context) => coupon
                            .map((e) => Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        e,
                                        textAlign: TextAlign.left,
                                        // style: Mytextstyle.blue19),
                                      ),
                                    ]))
                            .toList(),
                      ),
                    )),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: FFButtonWidget(
                    onPressed: () {
                      print('Make payment pressed ...');
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor:
                                  Color.fromARGB(255, 107, 207, 255),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              title: Center(
                                  child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 100,
                              )),
                              content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Text(
                                    //   "Your payment is successful!",
                                    //   style: TextStyle(
                                    //       fontFamily: 'Montserrat',
                                    //       color: Color(0xFF1A74E2),
                                    //       fontWeight: FontWeight.bold),
                                    // ),
                                    RichText(
                                        text: TextSpan(children: <TextSpan>[
                                      TextSpan(
                                        text: 'Your payment is',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: ' successful',
                                        style: TextStyle(
                                            color: Color(0xFF1A74E2),
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: '!',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ]))
                                  ]),
                              actions: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 0, 20, 20),
                                  child: FFButtonWidget(
                                    onPressed: () {
                                      print('Continue pressed ...');
                                      print('wait for another page');
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) => qrCode()));
                                    },
                                    text: 'Continue',
                                    options: FFButtonOptions(
                                      width: 330,
                                      height: 55,
                                      color: Color.fromARGB(255, 26, 116, 226),
                                      textStyle: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: 10,
                                      elevation: 0,
                                      decoration: BoxDecoration(),
                                    ),
                                  ),
                                )
                              ],
                            );
                          });
                    },
                    text: 'Make Payment',
                    options: FFButtonOptions(
                        width: 350,
                        height: 60,
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        color: Color(0xFF6BCFFF),
                        textStyle:
                            FlutterFlowTheme.of(context).subtitle2.override(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF1A74E2),
                                  fontSize: 20,
                                ),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: 8,
                        decoration: BoxDecoration(),
                        elevation: 0),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
