import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'GPSandTracking.dart';
import 'HelpCenter.dart';
import 'TechnicianandService.dart';

// import 'feedback_model.dart';
// export 'feedback_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: FeedbackWidget(),
    );
  }
}

class FeedbackWidget extends StatefulWidget {
  const FeedbackWidget({Key? key}) : super(key: key);

  @override
  _FeedbackWidgetState createState() => _FeedbackWidgetState();
}

class _FeedbackWidgetState extends State<FeedbackWidget> {
  // late GPSandTrackingModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // _model = createModel(context, () => TechnicianandServiceModel());

    // On page load action.
    // SchedulerBinding.instance.addPostFrameCallback((_) async {
    //   context.pushNamed('HelpCenter');
    // });
  }

  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  // @override
  // void dispose() {
  //   _model.dispose();

  //   _unfocusNode.dispose();
  //   super.dispose();
  // }

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
        elevation: 2,
      ),
      body: SingleChildScrollView(
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
                      'แอพสะดวกมากๆเลย เยี่ยมมาก',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Montserrat',
                            color: Color(0xFF6BCFFF),
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
                      hintText: 'Search topics',
                      hintStyle:
                          FlutterFlowTheme.of(context).bodyText1.override(
                                fontFamily: 'Montserrat',
                                color: Color(0xFF9E9E9E),
                                fontSize: 18,
                              ),
                      labelStyle:
                          FlutterFlowTheme.of(context).bodyText1.override(
                                fontFamily: 'Montserrat',
                                color: Color(0xFF9E9E9E),
                                fontSize: 18,
                              ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        print(value);
                      }
                    },
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      // do something when the text is changed
                      print(value);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                  child: FFButtonWidget(
                    icon: Icon(
                      Icons.car_rental,
                      color: Colors.black,
                      size: 26,
                    ),
                    onPressed: () async {
                      print('Technicianand Button pressed ...');
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
                          FlutterFlowTheme.of(context).subtitle2.override(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                              ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: 8,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
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
                              builder: (context) => GPSandTrackingWidget()));
                    },
                    text: 'GPS  and Tracking ',
                    options: FFButtonOptions(
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
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(30, 30, 20, 0),
                  child: TextFormField(
                    maxLines: 10,
                    decoration: InputDecoration(
                      hintText: 'Put your feedback here!',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff6bcfff))),
                      filled: true,
                      fillColor: Color.fromARGB(255, 152, 216, 246),
                    ),
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Montserrat',
                          color: Color(0xFF9E9E9E),
                          fontSize: 16,
                        ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your feedback';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      // Do something with the feedback value
                    },
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                    child: Text(
                      'Contact Us',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Montserrat',
                            color: Color(0xFF9E9E9E),
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
