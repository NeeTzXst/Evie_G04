import 'package:flutter/material.dart';

import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';
import '../AddCreditCard.dart';
import '../homePage.dart';

class myPayment extends StatefulWidget {
  const myPayment({super.key});

  @override
  State<myPayment> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<myPayment> {
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
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
            'My Payment Method',
            style: TextStyle(
              fontFamily: 'Montserrat',
              color: Color(0xFF1A74E2),
            ),
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(32, 0, 0, 32),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FFButtonWidget(
                  onPressed: () {
                    print("Add Card pressed ...");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddCreditCardWidget()));
                  },
                  text: 'Add Credit Card\n',
                  options: FFButtonOptions(
                      width: 330,
                      height: 55,
                      color: Color.fromARGB(216, 107, 208, 255),
                      textStyle:
                          FlutterFlowTheme.of(context).subtitle2.override(
                                fontFamily: 'Montserrat',
                                color: Color(0xFF1A74E2),
                                fontSize: 20,
                              ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: 10,
                      decoration: BoxDecoration()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
