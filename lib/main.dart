import 'package:flutter/material.dart';
import 'package:myapp/Database/saveState.dart';
import 'package:myapp/Screen/homePage.dart';
import 'package:myapp/Screen/splash.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSignedIn = false;

  @override
  void initState() {
    super.initState();
    getUserLoginStatus();
  }

  getUserLoginStatus() async {
    await saveState.getUserLoggedInStatus().then((value) => {
          if (value != null)
            {
              setState(() {
                _isSignedIn = value;
              })
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyApp',
      home: _isSignedIn ? homePage() : splash(),
    );
  }
}
