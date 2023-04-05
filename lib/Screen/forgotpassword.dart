// ignore_for_file: prefer_const_constructors
// import 'package:evie/flutter_flow/flutter_flow_theme.dart';
// import 'package:evie/via_email.dart';
// import 'package:evie/via_sms.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Screen/via_email.dart';
import 'package:myapp/flutter_flow/flutter_flow_theme.dart';

class ForgotpasswordScreen extends StatefulWidget {
  
  const ForgotpasswordScreen({Key? key}) : super(key: key);
  @override
  ForgotpasswordScreenState createState() => ForgotpasswordScreenState();
}

class ForgotpasswordScreenState extends State<ForgotpasswordScreen> {
  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    FocusNode? _unfocusNode;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        leading: BackButton(color: Color.fromRGBO(26, 116, 226, 1)),
        title: Text(
            "Forgot Password",
            style: TextStyle(
                color: Color.fromRGBO(26, 116, 226, 1),
                fontWeight: FontWeight.w500,
                fontFamily: "Montserrat",
                fontStyle: FontStyle.normal,
                fontSize: 19.0),
          ),
        ),
         body: SafeArea(
          child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Align(
            alignment: AlignmentDirectional(0, 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: const [],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(50, 0, 50, 0),
                    child: Text(
                      'Select which contact details\nshould we use to reset your \npassword',
                      textAlign: TextAlign.left,
                      maxLines: 3,
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Montserrat',
                            color: Color(0xFF484848),
                          ),
                    ),
                  ),
                  SizedBox(
                    height: 39,
                  ),
                  Align(
              alignment: Alignment.center,
              child: Container(
                  width: 264,
                  height: 104,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      color: Color(0xff6BCFFF)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: <Widget>[
                        TextButton(
                          child: Text(
                            "VIA SMS",
                            style: TextStyle(
                                color: Color(0xff101010),
                                fontWeight: FontWeight.w400,
                                fontFamily: "Montserrat",
                                fontStyle: FontStyle.normal,
                                fontSize: 20.0),
                          ),
                          onPressed: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => SMSScreen()));
                          },
                        ),
                ],
              ),
            ),
          ),
          SizedBox(
                    height: 19,
                  ),
                  Align(
              alignment: Alignment.center,
              child: Container(
                  width: 264,
                  height: 104,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      color: Color(0xff6BCFFF)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: <Widget>[
                        TextButton(
                          child: Text(
                            "VIA Email",
                            style: TextStyle(
                                color: Color(0xff101010),
                                fontWeight: FontWeight.w400,
                                fontFamily: "Montserrat",
                                fontStyle: FontStyle.normal,
                                fontSize: 20.0),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EMAILScreen()));
                          },
                        ),
                      ]
                    ),
                  ),
                )
                ]
              )
            )
          )
        )
      )
    );
  }
}