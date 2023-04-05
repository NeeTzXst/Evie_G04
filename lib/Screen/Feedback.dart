import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myapp/Database/authService.dart';

import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';

import 'package:flutter/material.dart';

import 'Drawer/helpCenter.dart';
import 'GPSandTracking.dart';
import 'TechnicianandService.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: FeedbackWidget(),
    );
  }
}

class FeedbackWidget extends StatefulWidget {
  @override
  _FeedbackWidgetState createState() => _FeedbackWidgetState();
}

class _FeedbackWidgetState extends State<FeedbackWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  final _feedback = TextEditingController();
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
            child: InkWell(
              onTap: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => helpCenter()));
              },
              child: Icon(
                Icons.arrow_back,
                color: Color(0xFF1A74E2),
                size: 33,
              ),
            ),
          ),
          title: Align(
            alignment: AlignmentDirectional(-1, 0),
            child: Text(
              'Feedback',
              style: FlutterFlowTheme.of(context).title1.override(
                    fontFamily: 'Montserrat',
                    color: Color(0xFF1A74E2),
                  ),
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0,
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('web')
                .doc('helpcenter')
                .collection('feedback')
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
                return Column(children: [
                  Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (context, index) {
                            return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SingleChildScrollView(
                                  child: GestureDetector(
                                    onTap: () => FocusScope.of(context)
                                        .requestFocus(_unfocusNode),
                                    child: Align(
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        // mainAxisAlignment:
                                        //     MainAxisAlignment.start,
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(-1, 0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(30, 0, 0, 0),
                                              child: Text(
                                                "${snapshot.data!.docs[index].get('opinion')}",
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyText1
                                                    .override(
                                                      fontFamily: 'Montserrat',
                                                      color: Color(0xFF3FA0EF),
                                                      fontSize: 16,
                                                    ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 30, 0, 0),
                                            child: FFButtonWidget(
                                              icon: Icon(
                                                Icons.car_rental,
                                                color: Colors.black,
                                                size: 26,
                                              ),
                                              onPressed: () async {
                                                print(
                                                    'Technicianand Button pressed ...');
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            TechnicianandServiceWidget()));
                                              },
                                              text: 'Technician and Service',
                                              options: FFButtonOptions(
                                                width: 320,
                                                height: 60,
                                                color: Color(0xFF6BCFFF),
                                                textStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .subtitle2
                                                        .override(
                                                          fontFamily:
                                                              'Montserrat',
                                                          color: Colors.black,
                                                        ),
                                                borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                  width: 1,
                                                ),
                                                borderRadius: 8,
                                                decoration: BoxDecoration(),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 30, 0, 0),
                                            child: FFButtonWidget(
                                              icon: Icon(
                                                Icons.gps_fixed,
                                                color: Colors.black,
                                                size: 26,
                                              ),
                                              onPressed: () async {
                                                print('GPS Button pressed ...');
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            GPSandTrackingWidget()));
                                              },
                                              text: 'GPS  and Tracking ',
                                              options: FFButtonOptions(
                                                width: 320,
                                                height: 60,
                                                color: Color(0xFF6BCFFF),
                                                textStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .subtitle2
                                                        .override(
                                                          fontFamily:
                                                              'Montserrat',
                                                          color: Colors.black,
                                                        ),
                                                borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                  width: 1,
                                                ),
                                                borderRadius: 8,
                                                decoration: BoxDecoration(),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    30, 30, 20, 0),
                                            child: TextFormField(
                                              controller: _feedback,
                                              maxLines: 10,
                                              textCapitalization:
                                                  TextCapitalization.none,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                hintText:
                                                    'Put your feedback here!',
                                                hintStyle: TextStyle(
                                                    fontFamily: 'Montserrat',
                                                    color: Color(0xFF9E9E9E),
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.normal),
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            Color(0xff6bcfff))),
                                                filled: true,
                                                fillColor: Color.fromARGB(
                                                    255, 152, 216, 246),
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            'Montserrat',
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Please enter your feedback';
                                                }
                                                return null;
                                              },
                                              keyboardType: TextInputType.text,
                                              onSaved: (value) {
                                                // Do something with the feedback value
                                                print(value);
                                              },
                                            ),
                                          ),
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0, 0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 20, 0, 0),
                                              child: FFButtonWidget(
                                                text: "Send Feedback",
                                                onPressed: () {
                                                  authService().sendFeedback(
                                                      context, _feedback.text);
                                                  print(
                                                      'Send Feedback pressed..');
                                                },
                                                options: FFButtonOptions(
                                                    width: 330,
                                                    height: 55,
                                                    color: Color(0xFF6BCFFF),
                                                    textStyle: TextStyle(
                                                      fontFamily: 'Montserrat',
                                                      color: Color(0xFF1A74E2),
                                                      fontSize: 20,
                                                    ),
                                                    borderSide: BorderSide(
                                                      color: Colors.transparent,
                                                      width: 1,
                                                    ),
                                                    borderRadius: 10,
                                                    elevation: 0,
                                                    decoration:
                                                        BoxDecoration()),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0, 0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 100, 0, 0),
                                              child: Text(
                                                'Contact Us',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyText1
                                                    .override(
                                                      fontFamily: 'Montserrat',
                                                      color: Color(0xFF9E9E9E),
                                                      fontSize: 16,
                                                      decoration: TextDecoration
                                                          .underline,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ));
                          })),
                ]);
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
