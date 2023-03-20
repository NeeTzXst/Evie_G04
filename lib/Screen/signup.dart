import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/Database/authService.dart';
import 'package:myapp/Screen/addprofile.dart';
import 'package:myapp/Screen/addvehicle.dart';
import 'package:myapp/Screen/homePage.dart';
import 'package:myapp/Screen/login.dart';

// ignore: unused_import
import 'flutter_flow/flutter_flow_theme.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _SignupScreenState createState() => _SignupScreenState();
}

// ignore: non_constant_identifier_names
FlatButton({
  required void Function() onPressed,
  required EdgeInsets padding,
  required Text child,
}) {}

class _SignupScreenState extends State<SignupScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isRememberMe = false;
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: BackButton(color: Color.fromRGBO(26, 116, 226, 1)),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: GestureDetector(
              child: Stack(children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
              ),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 70),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Create your Account',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xff1A74E2),
                          fontSize: 40,
                          fontFamily: 'Montserrat',
                          height: 3
                          //fontWeight: FontWeight.bold
                          ),
                    ),
                    SizedBox(height: 50),
                    buildEmail(),
                    SizedBox(height: 20),
                    buildPassword(),
                    SizedBox(height: 60),
                    buildRegisterBtn(),
                    SizedBox(height: 50),
                    buildSigninBtn(),
                  ],
                ),
              ),
            ),
          ]))),
    );
  }

  // ignore: non_constant_identifier_names
  RaisedButton(
      {required int elevation,
      required void Function() onPressed,
      required EdgeInsets padding,
      required RoundedRectangleBorder shape,
      required Color color,
      required Text child}) {}

  Widget buildEmail() {
    // ignore: prefer_typing_uninitialized_variables
    //var fontWeight;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10),
        Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Color(0xFF6BCFFF),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 2))
                ]),
            height: 60,
            child: TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon: Icon(Icons.email, color: Color(0xff101010)),
                  hintText: 'Email',
                  hintStyle: TextStyle(
                    color: Colors.black38,
                    fontFamily: 'Montserrat',
                  )),
            ))
      ],
    );
  }

  Widget buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Color(0xFF6BCFFF),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 2),
              )
            ],
          ),
          height: 60,
          child: TextField(
            controller: _passwordController,
            obscureText: isObscure,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.lock,
                color: Color(0xff101010),
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
                icon: Icon(
                  isObscure ? Icons.visibility : Icons.visibility_off,
                  color: Color(0xff101010),
                ),
              ),
              hintText: 'Password',
              hintStyle: TextStyle(
                color: Colors.black38,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget buildRegisterBtn() {
    return Container(
      width: 450,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Color(0xff1A74E2)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Divider(
            height: 1,
            thickness: 5,
            color: Color(0xff1A74E2),
          ),
          SizedBox(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1.0),
            child: TextButton(
              onPressed: () {
                authService().signUp(
                    _emailController.text, _passwordController.text, context);
              },
              child: Text(
                "Register",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Montserrat",
                    fontStyle: FontStyle.normal,
                    fontSize: 21.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSigninBtn() {
    return GestureDetector(
        // ignore: avoid_print
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => LoginScreen()),
          );
        },
        child: RichText(
            text: TextSpan(children: [
          TextSpan(
              text: 'Already have an account? ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                fontFamily: 'Montserrat',
              )),
          TextSpan(
              text: 'Sign in',
              style: TextStyle(
                color: Color(0xff1A74E2),
                fontSize: 18,
                fontFamily: 'Montserrat',
                //fontWeight: FontWeight.bold
                height: 5,
              ))
        ])));
  }
}
