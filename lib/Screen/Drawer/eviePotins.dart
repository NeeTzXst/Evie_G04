import 'package:flutter/material.dart';
import 'package:myapp/Widget/styles.dart';

import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';
import '../homePage.dart';

class eviePoints extends StatefulWidget {
  const eviePoints({super.key});

  @override
  State<eviePoints> createState() => _eviePointsState();
}

class _eviePointsState extends State<eviePoints> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  double _currentSliderValue = 50;

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
            onTap: () async {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => homePage()));
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
            'Evie Points',
            style: FlutterFlowTheme.of(context).title1.override(
                  fontFamily: 'Montserrat',
                  color: Color(0xFF1A74E2),
                ),
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Align(
            alignment: AlignmentDirectional(0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 340,
                  height: 220,
                  decoration: BoxDecoration(
                    color: Color(0xFF3FA0EF),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(-1, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 20, 0, 0),
                          child: Text(
                            'Memberships',
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Montserrat',
                                      color: Colors.white,
                                      fontSize: 26,
                                      fontWeight: FontWeight.normal,
                                    ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                        child: SliderTheme(
                          data: SliderThemeData(
                            thumbColor: Color(0x0050b5),
                            activeTrackColor: Color(0x0050b5),
                            inactiveTrackColor: Colors.white,
                          ),
                          child: Slider(
                            activeColor: Color(0xFF0050B5),
                            inactiveColor:
                                FlutterFlowTheme.of(context).primaryBtnText,
                            min: 0,
                            max: 1000,
                            value: _currentSliderValue,
                            onChanged: (double value) {
                              // value = double.parse(value.toStringAsFixed(4));
                              setState(() {
                                _currentSliderValue = value;
                              });
                            },
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-1, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                          child: Text(
                            '100 Evie Points : ',
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Montserrat',
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                    ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-1, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 40, 0, 0),
                          child: Text(
                            '50 points will expired in 31 jan 2023',
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Montserrat',
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 460,
                  height: 459,
                  decoration: BoxDecoration(
                    color: Color(0x7F6BCFFF),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(-1, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(25, 10, 0, 0),
                          child: Text(
                            'You have',
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xFF4C4C4C),
                                      fontSize: 26,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(25, 0, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              '200',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Montserrat',
                                    color: Color(0xFF4C4C4C),
                                    fontSize: 36,
                                  ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                              child: Text(
                                'Evie Points',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xFF4C4C4C),
                                      fontSize: 20,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-1, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(25, 10, 0, 0),
                          child: TextButton(
                            onPressed: () {
                              print("What is pressed..");
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor:
                                          Color.fromARGB(255, 107, 207, 255),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      title: Center(
                                        child: Text(
                                          'What is Evie points ?',
                                          style: FlutterFlowTheme.of(context)
                                              .title1
                                              .override(
                                                  fontFamily: 'Montserrat'),
                                        ),
                                      ),
                                      content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                                "Evie points is the points that"),
                                            Text("you can use to exchange for"),
                                            Text(
                                                "rewards and discounts for services")
                                          ]),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'OK',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText2
                                                .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0)),
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: Text(
                              'What is Evie points ?',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Montserrat',
                                    color: Color(0xFF1A74E2),
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-1, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(25, 0, 0, 0),
                          child: TextButton(
                            onPressed: () {
                              print("How it pressed..");
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor:
                                          Color.fromARGB(255, 107, 207, 255),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      title: Center(
                                        child: Text(
                                          'How it works ?',
                                          style: FlutterFlowTheme.of(context)
                                              .title1
                                              .override(
                                                  fontFamily: 'Montserrat'),
                                        ),
                                      ),
                                      content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                                "Evie points will lets you use"),
                                            Text(
                                                " and earn points  for every 30 kwh"),
                                            Text(
                                                " recharged, you will receive "),
                                            Text("200 evie points. ")
                                          ]),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'OK',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText2
                                                .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0)),
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: Text(
                              'How it works ?',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Montserrat',
                                    color: Color(0xFF1A74E2),
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-1, 0),
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(25, 20, 0, 10),
                          child: Text(
                            'Rewards for you',
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Montserrat',
                                      fontSize: 24,
                                      fontWeight: FontWeight.normal,
                                    ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                        child: GestureDetector(
                          onTap: () {
                            // Perform the desired action when the card is tapped.
                            print("reward card pressed..");
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor:
                                        Color.fromARGB(255, 107, 207, 255),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    title: Center(
                                      child: Text(
                                        'Rewards',
                                        style: FlutterFlowTheme.of(context)
                                            .title1
                                            .override(fontFamily: 'Montserrat'),
                                      ),
                                    ),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Column(
                                            children: [
                                              ListTile(
                                                title: Text(
                                                  '25% off Charging prices',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF001D42),
                                                    fontFamily: 'Montserrat',
                                                  ),
                                                ),
                                                subtitle: Text(
                                                  '\n1200 Evie Points',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    // fontWeight: FontWeight.bold,
                                                    color: Color(0xFF001D42),
                                                    fontFamily: 'Montserrat',
                                                  ),
                                                ),
                                                leading: Icon(
                                                  Icons.discount_outlined,
                                                  size: 60,
                                                  color: Color(0xFF3FA0EF),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          '\nYou want to exchange this reward',
                                          style: TextStyle(
                                            fontSize: 16,
                                            // fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontFamily: 'Montserrat',
                                          ),
                                        ),
                                        Text(
                                          'by using 1200 Evie points',
                                          style: TextStyle(
                                            fontSize: 20,
                                            // fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontFamily: 'Montserrat',
                                          ),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20, 0, 20, 20),
                                        child: FFButtonWidget(
                                          onPressed: () {
                                            print('Redeem pressed ...');
                                            Navigator.of(context).pop();
                                          },
                                          text: 'Redeem',
                                          options: FFButtonOptions(
                                            width: 330,
                                            height: 55,
                                            color: Color.fromARGB(
                                                255, 26, 116, 226),
                                            textStyle: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 1,
                                            ),
                                            borderRadius: 10, decoration: BoxDecoration(), 
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                });
                          },
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                            child: SizedBox(
                              height: 120,
                              width: 600,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text(
                                        '25% off Charging prices',
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF001D42),
                                          fontFamily: 'Montserrat',
                                        ),
                                      ),
                                      subtitle: Text(
                                        '\n1200 Evie Points',
                                        style: TextStyle(
                                          fontSize: 18,
                                          // fontWeight: FontWeight.bold,
                                          color: Color(0xFF001D42),
                                          fontFamily: 'Montserrat',
                                        ),
                                      ),
                                      leading: Icon(
                                        Icons.discount_outlined,
                                        size: 80,
                                        color: Color(0xFF3FA0EF),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
