import 'package:flutter/material.dart';

import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';
import '../Feedback.dart';
import '../GPSandTracking.dart';
import '../TechnicianandService.dart';
import '../homePage.dart';

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
      home: helpCenter(),
    );
  }
}

class helpCenter extends StatefulWidget {
  @override
  State<helpCenter> createState() => _helpCenterState();
}

class _helpCenterState extends State<helpCenter> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
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
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => homePage()));
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
            'Help Center',
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
            child: Align(
              alignment: AlignmentDirectional(0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(30, 20, 0, 0),
                      child: Text(
                        'About Us',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Color(0xFF9E9E9E),
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(30, 20, 30, 0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        hintText: 'Search topics such as Evie',
                        hintStyle: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Montserrat',
                          color: Color(0xFF9E9E9E),
                        ),
                      ),
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Montserrat',
                            color: Color(0xFF1A74E2),
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
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
                    padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                    child: FFButtonWidget(
                      icon: Icon(
                        Icons.car_rental,
                        color: Colors.black,
                        size: 26,
                      ),
                      onPressed: () {
                        print('Technicianand Button pressed ...');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TechnicianandServiceWidget()));
                      },
                      text: 'Technician and Service',
                      options: FFButtonOptions(
                        elevation: 0,
                        width: 320,
                        height: 60,
                        color: Color(0xFF6BCFFF),
                        textStyle:
                            FlutterFlowTheme.of(context).subtitle2.override(
                                  fontFamily: 'Montserrat',
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
                    padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                    child: FFButtonWidget(
                      icon: Icon(
                        Icons.gps_fixed,
                        color: Colors.black,
                        size: 26,
                      ),
                      onPressed: () {
                        print('GPS Button pressed ...');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GPSandTrackingWidget()));
                      },
                      text: 'GPS  and Tracking ',
                      options: FFButtonOptions(
                        elevation: 0,
                        width: 320,
                        height: 60,
                        color: Color(0xFF6BCFFF),
                        textStyle:
                            FlutterFlowTheme.of(context).subtitle2.override(
                                  fontFamily: 'Montserrat',
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
                    padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                    child: FFButtonWidget(
                      icon: Icon(
                        Icons.feedback_outlined,
                        color: Colors.black,
                        size: 26,
                      ),
                      onPressed: () {
                        print('Feedback Button pressed ...');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FeedbackWidget()));
                      },
                      text: 'Feedback',
                      options: FFButtonOptions(
                        elevation: 0,
                        width: 320,
                        height: 60,
                        color: Color(0xFF6BCFFF),
                        textStyle:
                            FlutterFlowTheme.of(context).subtitle2.override(
                                  fontFamily: 'Montserrat',
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
                    padding: EdgeInsetsDirectional.fromSTEB(0, 170, 0, 0),
                    child: Text(
                      'Contact Us',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Montserrat',
                            color: Color(0xFF9E9E9E),
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                          ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
