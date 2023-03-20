import 'package:flutter/material.dart';
import 'package:myapp/Widget/styles.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'profile.dart';

class editprofile extends StatefulWidget {
  const editprofile({super.key});

  @override
  State<editprofile> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<editprofile> {
  File? _image;

  @override
  Future<void> getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      print('No image selected.');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => profile(),
                ),
              );
            },
            child: Icon(
              Icons.arrow_back,
              size: 40,
              color: Color.fromRGBO(26, 116, 226, 1),
            ),
          ),
          title: Text(
            "Edit Profile",
            style: headerText,
          ),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              height: 250,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: <Widget>[
                      Stack(children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          minRadius: 60.0,
                          child: CircleAvatar(
                            radius: 90.0,
                            backgroundImage: _image != null
                                ? FileImage(_image!)
                                : NetworkImage(
                                        'https://serving.photos.photobox.com/853892988c364763c7aad97da7e68041ca985eb1b1ba353fdbb4d95a917073bf11ccdaf4.jpg')
                                    as ImageProvider<Object>,
                          ),
                        ),
                        Positioned(
                          bottom: 1,
                          right: 1,
                          child: Container(
                            // ignore: sort_child_properties_last
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: InkWell(
                                onTap: () {
                                  getImage(ImageSource.gallery);
                                },
                                child: Icon(Icons.add_a_photo,
                                    color: Colors.black),
                              ),
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 3,
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  50,
                                ),
                              ),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ]),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 23),
              child: Text("Full name", style: hintText),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                  width: 350,
                  height: 52,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Color.fromARGB(255, 107, 207, 255),
                  ),
                  padding: const EdgeInsets.only(left: 13),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextField(
                              decoration: InputDecoration.collapsed(
                                  hintText: "Ponthep Ah ha!!!"),
                              style: TextDisplay),
                        )
                      ])),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 23),
              child: Text("Nickname", style: hintText),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                  width: 350,
                  height: 52,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Color.fromARGB(255, 107, 207, 255),
                  ),
                  padding: const EdgeInsets.only(left: 13),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextField(
                              decoration: InputDecoration.collapsed(
                                  hintText: "PengLnwMoo"),
                              style: TextDisplay),
                        )
                      ])),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 23),
              child: Text("Phone Number", style: hintText),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                  width: 350,
                  height: 52,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Color.fromARGB(255, 107, 207, 255),
                  ),
                  padding: const EdgeInsets.only(left: 13),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextField(
                              decoration: InputDecoration.collapsed(
                                  hintText: "0932596161"),
                              style: TextDisplay),
                        )
                      ])),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 23),
              child: Text("Email", style: hintText),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                  width: 350,
                  height: 52,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Color.fromARGB(255, 107, 207, 255),
                  ),
                  padding: const EdgeInsets.only(left: 13),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextField(
                            decoration: InputDecoration.collapsed(
                                hintText: "PengLnwMoo555@gmail.com"),
                            style: TextDisplay,
                          ),
                        )
                      ])),
            ),
            SizedBox(
              height: 40,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                  width: 150,
                  height: 52,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: Color.fromRGBO(26, 116, 226, 1)),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: <Widget>[
                        TextButton(
                          child: Text("Save", style: itemWhiteDrawerText),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => profile()));
                          },
                        )
                      ])),
            ),
          ],
        ));
  }
}
