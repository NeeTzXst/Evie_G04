import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Database/saveState.dart';
import 'package:myapp/Screen/Drawer/helpCenter.dart';
import 'package:myapp/Screen/Drawer/myPayment.dart';
import 'package:myapp/Screen/addFirstvehicle.dart';
import 'package:myapp/Screen/addprofile.dart';
import 'package:myapp/Screen/homePage.dart';
import 'package:myapp/Screen/letyouin.dart';
import 'package:myapp/Widget/alertBox.dart';

class authService extends ChangeNotifier {
  // Sign up
  Future<void> signUp(
      String email, String password, BuildContext context) async {
    log('Function Sign Up ');
    try {
      await saveState.saveUserEmail(email);
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
          'EviePoints': 0,
          'reward25': 0,
          'reward50': 0
        },
      ).then(
        (value) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ProfileScreen(),
            ),
          );
        },
      );
      log((userCredential.user?.uid).toString());
    } on FirebaseAuthException catch (error) {
      log('Sign up error : ' + error.toString());
      String errorMessage;
      if (error.code == 'email-already-in-use') {
        errorMessage = 'This email is already in use.';
      } else if (error.code == 'invalid-email') {
        errorMessage = 'The email address is not valid.';
      } else if (error.code == 'weak-password') {
        errorMessage = 'Password should be at least 6 characters';
      } else {
        errorMessage = 'Please enter your email and password';
      }
      alertBox.showAlertBox(context, 'Error', errorMessage);
      log('FirebaseAuthException: $error');
    } catch (error, stackTrace) {
      alertBox.showAlertBox(
          context, 'Error', 'Please enter your email and password');
      log('Error: $error\n$stackTrace');
    }
  }

  // Sign up Anonymous
  Future<UserCredential> signInAnonymous(BuildContext context) async {
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
          .set({
        "Current_Location": {
          'description': '',
          'current_latitude': '',
          'current_longitude': '',
        },
        "Destination": {
          'description': '',
          'destination_latitude': '',
          'destination_longitude': '',
        },
      }).then(
        (value) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => homePage(),
            ),
          );
        },
      );

      return anonymous;
    } catch (error) {
      alertBox.showAlertBox(
          context, 'Unknown error occurred', error.toString());
      throw error; // Throw the error so it can be handled by the caller
    }
  }

  //Sign In
  Future<void> signIn(
      String email, String password, BuildContext context) async {
    log('Function Sign in');
    try {
      log('Try sign in ');
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then(
        (value) {
          log(email);
          log(password);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => homePage(),
            ),
          );
        },
      );
    } on FirebaseAuthException catch (error) {
      log('Sign in Error : ' + error.toString());
      String errorMessage;
      if (error.code == 'user-not-found') {
        errorMessage = 'No user found with this email.';
      } else if (error.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for this user';
      } else {
        errorMessage = 'Please enter your email and password';
      }
      alertBox.showAlertBox(context, 'Error', errorMessage);
    } catch (error, stackTrace) {
      alertBox.showAlertBox(
          context, 'Error', error.toString() + stackTrace.toString());
    }
  }

  //Sign out
  Future<void> signOut(BuildContext context) async {
    log('logout');
    try {
      await saveState.saveUserLoggedInStatus(false);
      log(await saveState.getUserLoggedInStatus().toString());
      await FirebaseAuth.instance
          .signOut()
          .then((value) => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => LetyouIn(),
                ),
              ));
    } catch (error, stackTrace) {
      alertBox.showAlertBox(context, 'Error signing out',
          error.toString() + stackTrace.toString());
      log('Error: $error\n$stackTrace');
    }
  }

  //Add Profile
  Future<void> addProfile(String fullname, String nickname, String number,
      File _image, BuildContext context) async {
    log('AddProfile');
    log('fullname : $fullname');
    log('nickname : $nickname');
    log('number : $number');
    final userId = FirebaseAuth.instance.currentUser!.uid;
    try {
      assert(_image != null);

      await saveState.saveFullname(fullname);
      await saveState.saveNickname(nickname);
      await saveState.savePhone(number);
      log(await saveState.saveFullname(fullname).toString());
      log(await saveState.saveNickname(nickname).toString());
      log(await saveState.savePhone(number).toString());
      if (fullname.isEmpty) {
        alertBox.showAlertBox(context, 'Error', 'Please enter Fullname');
      } else if (nickname.isEmpty) {
        alertBox.showAlertBox(context, 'Error', 'Please enter Nickname');
      } else if (number.isEmpty) {
        alertBox.showAlertBox(context, 'Error', 'Please enter Phone Number');
      } else if (_image == null) {
        alertBox.showAlertBox(
            context, 'Error', 'Please select your Profile Picture');
      } else {
        await FirebaseFirestore.instance
            .collection('app')
            .doc('member')
            .collection('ID')
            .doc(userId)
            .update({
          'Fullname': fullname,
          'Nickname': nickname,
          'Phone': number,
        }).then((value) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddFirstVehicle(),
            ),
          );
        });
      }
    } catch (error) {
      alertBox.showAlertBox(
          context, 'Error updating user profile', error.toString());
    }
  }

  //Add Vehicle
  Future<void> addVehicle(String Brand, String Type, String LicenseNum,
      BuildContext context) async {
    log('AddVehicle');
    final userId = FirebaseAuth.instance.currentUser!.uid;
    try {
      await saveState.saveUserLoggedInStatus(true);
      log(await saveState.getUserLoggedInStatus().toString());
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
      }).then((value) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => homePage(),
          ),
        );
      });
    } catch (error) {
      alertBox.showAlertBox(context, 'Error', error.toString());
      // Handle the error as appropriate for your app.
    }
  }

  // add card
  Future<void> addCard(
      BuildContext context,
      String typecard,
      String fullname,
      String cardNumber,
      String expirationM,
      String expirationY,
      String cvv) async {
    log('add card');
    final userId = FirebaseAuth.instance.currentUser!.uid; // call uid of user
    try {
      // await saveState.saveUserLoggedInStatus(true); // check user is login
      // log(await saveState.getUserLoggedInStatus().toString());
      await FirebaseFirestore.instance // return data to firebase
          // fo to path /app/member/ID/
          // if no collection Card it'll create collection Card
          // then set feild
          // set success then navigate to myPayment page
          .collection('app')
          .doc('member')
          .collection('ID')
          .doc(userId)
          .collection('Card')
          .doc()
          .set({
        'FullnameCard': fullname,
        'cardNumber': cardNumber,
        'expirationM': expirationM,
        'expirationY': expirationY,
        'cvv': cvv,
        'typeCard': typecard,
      }).then((value) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => myPayment(),
          ),
        );
      });
    } catch (error) {
      alertBox.showAlertBox(context, 'Error', error.toString());
      // Handle the error as appropriate for your app.
    }
  }

  // send feedback
  Future<void> sendFeedback(BuildContext context, String feedback) async {
    log('send feedback');
    // final userId = FirebaseAuth.instance.currentUser!.uid;
    try {
      // await saveState.saveUserLoggedInStatus(true); // check user is login
      // log(await saveState.getUserLoggedInStatus().toString());
      await FirebaseFirestore.instance
          .collection('web')
          .doc('helpcenter')
          .collection('feedback')
          .doc()
          .set({'opinion': feedback}).then((value) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => helpCenter(),
          ),
        );
      });
    } catch (error) {
      alertBox.showAlertBox(context, 'Error', error.toString());
      // Handle the error as appropriate for your app.
    }
  }
}
