import 'package:flutter/material.dart';
import 'package:myapp/Screen/Drawer/howToUse.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<splash> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 2000), () {});
    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => howToUse(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Image.asset(
            'assets/EVIE.png',
            fit: BoxFit.cover,
            width: 300,
          ),
        ),
      ),
    );
  }
}
