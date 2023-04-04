import 'package:flutter/material.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import 'Drawer/helpCenter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      home: GPSandTrackingWidget(),
    );
  }
}

class GPSandTrackingWidget extends StatefulWidget {
  @override
  _GPSandTrackingWidgetState createState() => _GPSandTrackingWidgetState();
}

class _GPSandTrackingWidgetState extends State<GPSandTrackingWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
    Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
            child: InkWell(
              onTap: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => helpCenter()));
              },
              child: Icon(
                Icons.arrow_back,
                color: Color(0xFF1A74E2),
                size: 33,
              ),
            ),
          ),
          title: Align(
            alignment: AlignmentDirectional(-1, 0),
            child: Text(
              'GPS  and Tracking ',
              style: FlutterFlowTheme.of(context).title1.override(
                    fontFamily: 'Montserrat',
                    color: Color(0xFF1A74E2),
                  ),
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0,
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('web')
                .doc('helpcenter')
                .collection('gps')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Error');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasData) {
                return Column(children: [
                  Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (context, index) {
                            return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SingleChildScrollView(
                                  child: GestureDetector(
                                    onTap: () => FocusScope.of(context)
                                        .requestFocus(_unfocusNode),
                                    child: Align(
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(-1, 0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(30, 20, 0, 0),
                                              child: Text(
                                                "${snapshot.data!.docs[index].get('problem')}",
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyText1
                                                    .override(
                                                      fontFamily: 'Montserrat',
                                                      color: Color(0xFF3FA0EF),
                                                      fontSize: 16,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ));
                          })),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 150, 0, 0),
                    child: Image.asset(
                      'assets/help_car.jpg',
                      width: 400,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                    child: Text(
                      'Contact Us',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Montserrat',
                            color: Color(0xFF9E9E9E),
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                          ),
                    ),
                  )
                ]);
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}