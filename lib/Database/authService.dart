import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Screen/letyouin.dart';

class authService {
  // Sign up
  Future<void> signUp(String email, String password) async {
    log('signUp ');
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      log('Email : $email');
      log('Password : $password');
      await FirebaseFirestore.instance
          .collection('app')
          .doc('member')
          .collection('ID')
          .doc(userCredential.user?.uid)
          .set(
        {
          'uid': userCredential.user?.uid,
          'Email': email,
          'password': password,
        },
      );
      log((userCredential.user?.uid).toString());
    } catch (error, stackTrace) {
      log(stackTrace.toString());
    }
  }

  // Sign up Anonymous
  Future<UserCredential> signInAnonymous() async {
    log('Sign in Anonymous');
    try {
      UserCredential anonymous =
          await FirebaseAuth.instance.signInAnonymously();
      log('Anonymous user signed in: ${anonymous.user?.uid}');
      await FirebaseFirestore.instance
          .collection('app')
          .doc('guest')
          .collection('ID')
          .doc(anonymous.user?.uid)
          .set({}); // Set any data you want to store for the anonymous user

      return anonymous;
    } catch (error) {
      log('Unknown error occurred: $error');
      throw error; // Throw the error so it can be handled by the caller
    }
  }

  //Sign In
  Future<void> signIn(String email, String password) async {
    log('sign in');
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then(
        (value) {
          log(email);
          log(password);
        },
      );
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        log('No user found with this email.');
      } else if (error.code == 'wrong-password') {
        log('Wrong password provided for this user.');
      } else {
        log('Error: ${error.code}');
      }
    } catch (error) {
      log('Unknown error occurred: $error');
    }
  }

  //Sign out
  Future<void> signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signOut()
          .then((value) => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => LetyouIn(),
                ),
              ));
    } catch (e) {
      print('Error while signing out: $e');
    }
  }

  //Add Profile
  Future<void> addProfile(
      String fullname, String nickname, String number, String email) async {
    log('fullname : $fullname');
    print('nickname : $nickname');
    print('number : $number');
    print('email : $email ');
    final userId = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('app')
        .doc('member')
        .collection('ID')
        .doc(userId)
        .update({
      'Fullname': fullname,
      'Nickname': nickname,
      'Phone': number,
    });
  }

  //Add Vehicle
  Future<void> addVehicle(String Brand, String Type, String LicenseNum) async {
    log('SddVehicle');
    final userId = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('app')
        .doc('member')
        .collection('ID')
        .doc(userId)
        .collection('Vehicle')
        .doc()
        .set({
      'Brand': Brand,
      'Charger type': Type,
      'License Number': LicenseNum
    });
  }
}
