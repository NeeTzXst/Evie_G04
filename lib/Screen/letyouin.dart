// ignore_for_file: unnecessary_import, avoid_print,, prefer_const_constructors, duplicate_ignore 
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myapp/Screen/homePage.dart';
import 'package:myapp/Screen/login.dart';
import 'package:myapp/Screen/signup.dart';
import '../flutter_flow/flutter_flow_theme.dart';

import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LetyouIn extends StatefulWidget {
  const LetyouIn({Key? key}) : super(key: key);
  
  @override
  // ignore: library_private_types_in_public_api
  _LetyouInState createState() => _LetyouInState();
}

class _LetyouInState extends State<LetyouIn> {
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  singInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    print(userCredential.user?.displayName);
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: SingleChildScrollView(
            // alignment: const AlignmentDirectional(0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                Align(
                  alignment: const AlignmentDirectional(0, 0),
                  child: Text(
                    'Let\'s you in',
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Montserrat',
                          color: const Color(0xFF1A74E2),
                          fontSize: 50,
                          lineHeight: 5.5,
                        ),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(0, 0),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 34, 0, 16),
                    child: FFButtonWidget(
                      onPressed: () {
                        print('ButtonGoogle pressed ...');
                        singInWithGoogle();
                      },
                      text: 'Continue with',
                      icon: const FaIcon(
                        FontAwesomeIcons.google,
                        color: Color(0xFFB92C2C),
                      ),
                      options: FFButtonOptions(
                        width: 251,
                        height: 47,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0))),
                          
                        color: const Color(0xFF6BCFFF),
                        textStyle:
                            FlutterFlowTheme.of(context).subtitle2.override(
                                  fontFamily: 'Montserrat',
                                  color: const Color(0xFF101010),
                                ),
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                        ),
                        
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(0, 0),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                    child: FFButtonWidget(
                      onPressed: () {
                        print('ButtonFacebook pressed ...');
                      },
                      text: 'Continue with',
                      icon: const FaIcon(
                        FontAwesomeIcons.facebook,
                        color: Color(0xFF184E77),
                      ),
                      options: FFButtonOptions(
                        width: 251,
                        height: 47,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0))),
                        color: const Color(0xFF6BCFFF),
                        textStyle:
                            FlutterFlowTheme.of(context).subtitle2.override(
                                  fontFamily: 'Montserrat',
                                  color: const Color(0xFF101010),
                                ),
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(0, 0),
                  child: FFButtonWidget(
                    onPressed: () {
                      print('ButtonLine pressed ...');
                    },
                    text: 'Continue with',
                    icon: const FaIcon(
                      FontAwesomeIcons.line,
                      color: Color(0xFF26A826),
                    ),
                    options: FFButtonOptions(
                      width: 251,
                      height: 47,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0))),
                      color: const Color(0xFF6BCFFF),
                      textStyle:
                          FlutterFlowTheme.of(context).subtitle2.override(
                                fontFamily: 'Montserrat',
                                color: const Color(0xFF101010),
                              ),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                Row(
  // ignore: prefer_const_literals_to_create_immutables
  children: [
    Expanded(
      child: Divider(
        color: Color(0xff1A74E2),
        height: 36,
        thickness: 5,
      ),
    ),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        'Or',
        style: TextStyle(
          fontSize: 16,
          fontFamily: 'Montserrat',
          color: Color(0xff1A74E2),
        ),
      ),
    ),
    Expanded(
      child: Divider(
        color: Color(0xff1A74E2),
        height: 36,
        thickness: 5,
      ),
    ),
  ],
),
                Align(
                  alignment: const AlignmentDirectional(0, 0),
                  child: FFButtonWidget(
                    onPressed: () {
                      print('Signin pressed ...');
                      Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => LoginScreen()),
                            );
                    },
                    text: 'Sign in with password',
                    options: FFButtonOptions(
                      width: 282,
                      height: 47,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0))),
                      color: const Color(0xFF1A74E2),
                      textStyle:
                          FlutterFlowTheme.of(context).subtitle2.override(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                              ),
                      // ignore: prefer_const_constructors
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                Align(
                  // ignore: prefer_const_constructors
                  alignment: AlignmentDirectional(0, 0),
                  child: GestureDetector(
                    onTap: () {Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => homePage()),
                            ); },
                    child: RichText(
                      text: TextSpan(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          TextSpan(
            text: 'Sign in with ',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w500,
              fontFamily: 'Montserrat',
            )
          ),
          TextSpan(
            text: 'Guest',
            style: TextStyle(
              color: Color(0xff1A74E2),
              fontSize: 18,
              fontFamily: 'Montserrat',
              height: 3,
              //fontWeight: FontWeight.bold
              // height: 10,
            )
          )
        ]
      )
    )
  )
                ),
                Padding(
                  // ignore: prefer_const_constructors
                  padding: EdgeInsetsDirectional.fromSTEB(0, 47, 0, 0),
                  child: GestureDetector(
                    onTap: () {
                      print("sign up ");
                      Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => SignupScreen()),
                            ); 
                    },
                    child: RichText(
                      text: TextSpan(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          TextSpan(
            text: 'Don\'t have an account? ',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w500,
              fontFamily: 'Montserrat',
            )
          ),
          TextSpan(
            text: 'Sign Up',
            style: TextStyle(
              color: Color(0xff1A74E2),
              fontSize: 18,
              fontFamily: 'Montserrat',
              //fontWeight: FontWeight.bold
              height: 1,
            )
          )
        ]
      )
    )
  )
                  ),
                ]
                ),
              ),
            ),
          ),
        );
  }
}


