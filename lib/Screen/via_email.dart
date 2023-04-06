// import 'dart:js';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EMAILScreen extends StatefulWidget {
  const EMAILScreen({Key? key}) : super(key: key);
  @override
  EMAILScreenState createState() => EMAILScreenState();
}

class EMAILScreenState extends State<EMAILScreen> {
  final _emailController = TextEditingController();

  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      // showDialog(
      //   context: context,
      //   builder: (context) {
      //     return AlertDialog(
      //       content: Text('Password reset link sent! check your email'),
      //     );
      //   },
      // );
    } on FirebaseAuthException catch (e) {
      print(e);
      // showDialog(
      //   context: context,
      //   builder: (context) {
      //     return AlertDialog(
      //       content: Text(e.message.toString()),
      //     );
      //   },
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers, unused_local_variable
    FocusNode? _unfocusNode;
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          leading: const BackButton(color: Color.fromRGBO(26, 116, 226, 1)),
          title: const Text(
            "VIA EMAIL",
            style: TextStyle(
                color: Color.fromRGBO(26, 116, 226, 1),
                fontWeight: FontWeight.w500,
                fontFamily: "Montserrat",
                fontStyle: FontStyle.normal,
                fontSize: 19.0),
          ),
        ),
        body: SafeArea(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              "Enter Your Email and we will send you a password reset link",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(height: 10),
          Padding(
              padding: EdgeInsets.only(top: 50),
              child: Container(
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
                  ))),
          SizedBox(
            height: 10,
          ),
          MaterialButton(
            onPressed: () => passwordReset(),
            child: Text("Reset Password"),
            color: Color(0xFF1A74E2),
          )
        ])));
  }
}
