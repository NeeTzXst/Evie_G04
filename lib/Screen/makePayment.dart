import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: makePaymentWidget(),
    );
  }
}

class makePaymentWidget extends StatefulWidget {
  @override
  _MakePaymentWidgetState createState() => _MakePaymentWidgetState();
}

class _MakePaymentWidgetState extends State<makePaymentWidget> {
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
          child: InkWell(
              child: Icon(
                Icons.arrow_back,
                color: Color(0xFF1A74E2),
                size: 33,
              ),
              onTap: () async {
                // wait for condition
                // Navigator.push(
                //     context, MaterialPageRoute(builder: (context) => Payment()));
              }),
        ),
        title: Align(
          alignment: AlignmentDirectional(-1, 0),
          child: Text(
            'Make Payment',
            style: TextStyle(
              fontFamily: 'Montserrat',
              color: Color(0xFF1A74E2),
            ),
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 2,
      ),
      body: SafeArea(
          child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [Text('data')],
        ),
      )),
    );
  }
}
