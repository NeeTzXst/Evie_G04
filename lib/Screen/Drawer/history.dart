// ignore_for_file: camel_case_types, prefer_const_constructors, sized_box_for_whitespace
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/Widget/styles.dart';

class history extends StatefulWidget {
  const history({super.key});

  @override
  State<history> createState() => _historyState();
}

class _historyState extends State<history> {
  String get userUID => FirebaseAuth.instance.currentUser!.uid;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            size: 40,
            color: Color.fromRGBO(26, 116, 226, 1),
          ),
        ),
        title: Text(
          "History",
          style: headerText,
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('app')
            .doc('member')
            .collection('ID')
            .doc(userUID)
            .collection("History")
            .orderBy("Time", descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData) {
            return Column(
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(color: Colors.black, width: 0.1),
                      ),
                      elevation: 7,
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search',
                          hintStyle: BlueDisplay,
                          prefixIcon: Icon(Icons.search,
                              color: Color.fromRGBO(26, 116, 226, 1)),
                        ),
                      ),
                    ))
              ],
            );
          }
          if (snapshot.hasData) {
            return Column(
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(color: Colors.black, width: 0.1),
                      ),
                      elevation: 7,
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search',
                          hintStyle: BlueDisplay,
                          prefixIcon: Icon(Icons.search,
                              color: Color.fromRGBO(26, 116, 226, 1)),
                        ),
                        onSubmitted: (value) {
                          setState(() {});
                        },
                      ),
                    )),
                Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index) {
                          if (searchController.text.isNotEmpty) {
                            if (!snapshot.data!.docs[index]
                                .get('Station Name')
                                .toLowerCase()
                                .contains(
                                    searchController.text.toLowerCase())) {
                              return SizedBox.shrink();
                            }
                          }
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 9),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    side: BorderSide(
                                        color: Colors.black, width: 0.01),
                                  ),
                                  color: Color.fromRGBO(196, 236, 255, 0.839),
                                  elevation: 7,
                                  child: Container(
                                    height: 100,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 350,
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 6),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  child: Image.network(
                                                    'https://cdn.discordapp.com/attachments/1056191443657572372/1092753236580126770/image.png',
                                                    width: 110,
                                                    height: 75,
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 6, top: 8),
                                                    child: Text(
                                                      "${snapshot.data!.docs[index].get('Station Name')}",
                                                      style: StationFull,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      left: 6,
                                                    ),
                                                    child: Text(
                                                      "${snapshot.data!.docs[index].get('Price')} Baht.",
                                                      style: itemDrawerText,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      left: 6,
                                                    ),
                                                    child: Text(
                                                      "${snapshot.data!.docs[index].get('Car')}",
                                                      style: VehicleName,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }))
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
