import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/Database/authService.dart';
import 'package:myapp/Database/saveState.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:myapp/Screen/forgotpassword.dart';
import 'package:myapp/Screen/homePage.dart';
import 'package:myapp/Screen/signup.dart';

// ignore: unused_import
import 'flutter_flow/flutter_flow_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

// ignore: non_constant_identifier_names
FlatButton({
  required void Function() onPressed,
  required EdgeInsets padding,
  required Text child,
}) {}

class _LoginScreenState extends State<LoginScreen> {
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
                      'Login to your Account',
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
                    buildRememberCb(),
                    buildSigninBtn(),
                    buildForgotPassBtn(),
                    buildSignUpBtn(),
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

  Widget buildForgotPassBtn() {
    return Container(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => ForgotpasswordScreen()),
          );
        },
        child: Text(
          'Forgot the Password?',
          style: TextStyle(
            color: Color(0xff1A74E2),
            fontFamily: 'Montserrat',
            height: 5,
          ),
        ),
      ),
    );
  }

  Widget buildRememberCb() {
    return Center(
      child: SizedBox(
        height: 80,
        child: Row(
          children: <Widget>[
            Theme(
              data: ThemeData(unselectedWidgetColor: Colors.black),
              child: Checkbox(
                  value: isRememberMe,
                  checkColor: Colors.black,
                  activeColor: Color(0xff6BCFFF),
                  onChanged: (value) {
                    setState(() {
                      log(value.toString());
                      isRememberMe = value!;
                      saveState.saveUserLoggedInStatus(true);
                    });
                  }),
            ),
            Text(
              'Remember me',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Montserrat',
                //fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildSigninBtn() {
    // ignore: avoid_unnecessary_containers
    return SizedBox(
      height: 100,
      child: Align(
        alignment: Alignment.center,
        child: Container(
            width: 450,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                color: Color(0xff1A74E2)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      log('Press sign in');
                      print(
                          '${_emailController.text} , ${_passwordController.text}');
                      authService().signIn(_emailController.text,
                          _passwordController.text, context);
                    },
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Montserrat",
                          fontStyle: FontStyle.normal,
                          fontSize: 21.0),
                    ),
                  )
                ])),
      ),
    );
  }

  Widget buildSignUpBtn() {
    return GestureDetector(
        // ignore: avoid_print
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => SignupScreen()),
          );
        },
        child: RichText(
            text: TextSpan(children: [
          TextSpan(
              text: 'Don\'t have an account? ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                fontFamily: 'Montserrat',
              )),
          TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: Color(0xff1A74E2),
                fontSize: 18,
                fontFamily: 'Montserrat',
                height: 5,
              ))
        ])));
  }
}
