import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:myapp/Database/dataBaseManager.dart';
import 'package:myapp/Models/currentLocation_model.dart';
import 'package:myapp/Models/destination_model.dart';
import 'package:myapp/Screen/qrCode.dart';
import 'package:myapp/Screen/selectVehicle.dart';
import 'package:myapp/Screen/station.screen.dart';
import 'package:myapp/Screen/ParkorCharg.dart';
import 'package:myapp/Screen/timeRemining.dart';
import 'package:myapp/Widget/IconButton.dart';
import 'package:myapp/Widget/alertBox.dart';
import 'package:myapp/Widget/myDrawer.dart';
import 'package:myapp/Widget/seractButton.dart';
import 'package:google_map_polyline_new/google_map_polyline_new.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:myapp/Widget/styles.dart';
import 'package:myapp/variables.dart';

class homePage extends StatefulWidget {
  const homePage({
    super.key,
  });

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final Completer<GoogleMapController> _controller = Completer();

  GoogleMapPolyline _googleMapPolyline =
      new GoogleMapPolyline(apiKey: kGoogleApiKey);

  Map<PolylineId, Polyline> _polylines = <PolylineId, Polyline>{};
  Set<Polyline> polyline = {};
  PolylinePoints polylinePoints = PolylinePoints();

  List<LatLng> routeCoords = [];
  // List of Current location
  List<currentLocation> currentLocations = [];
  // List of Destination location
  List<destination> destinations = [];
  // List of Marker
  List<Marker> _markers = <Marker>[];

  double current_latitude = 0;
  double current_longitude = 0;
  String current_description = '';
  double destination_latitude = 0;
  double destination_longitude = 0;
  String destination_description = '';
  dataBaseManager dbManager = dataBaseManager();
  Uint8List? locationIcon;

  String get userUID {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return 'No user';
    } else {
      return user.uid;
    }
  }

  // Stream<QuerySnapshot> _locationsStream = FirebaseFirestore.instance
  //     .collection("web")
  //     .doc('owner')
  //     .collection('charging Station')
  //     .snapshots();

  Future<QuerySnapshot> _locationsFuture = FirebaseFirestore.instance
      .collection("web")
      .doc('owner')
      .collection('charging Station')
      .get();

  Future<void> getUserBookinfo(BuildContext context) async {
    log('user ID :' + userUID);
    log('GET USER BOOKING INFO');
    final userRef = FirebaseFirestore.instance
        .collection('/app/member/ID/$userUID/Booking');
    final userBookings = await userRef.get();
    if (userBookings.docs.isEmpty) {
      // Show Dialog
      log('YOU ARE NOT BOOKING');
    } else {
      log('YOU BOOKING');
      for (var booking in userBookings.docs) {
        log('YOUR BOOKING ID : ' + booking.id);
        // Get the data of the document as a Map
        final bookingData = booking.data();
        // Access specific fields in the booking data
        if (bookingData.isNotEmpty) {
          log('Booking is not emtpy');
          final bookingID = bookingData['Booking ID'];
          final bookingStation = bookingData['Station ID'];
          final bookingStationName = bookingData['Station Name'];
          final bookingDuration = bookingData['Duration'];
          final bookingSpotslot = bookingData['Spotslot'];
          final bookingTpye = bookingData['Type'];
          final bookingDate = bookingData['Date'];
          final bookingStartTime = bookingData['Start'];
          final bookingEndTime = bookingData['end'];
          final bookingCar = bookingData['Car'];
          final bookingSpotID = bookingData['Spot ID'];
          log('Booking BookingID: $bookingID');
          log('Booking Station: $bookingStation');
          log('Booking Station Name: $bookingStationName');
          log('Booking Duration: $bookingDuration');
          log('Booking Spot slot: $bookingSpotslot');
          log('Booking Tpye: $bookingTpye');
          log('Booking Date: $bookingDate');
          log('Booking Start Time: $bookingStartTime');
          log('Booking End time: $bookingEndTime');
          log('Booking SpotID: $bookingSpotID');
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => qrCode(
              bookingId: bookingID,
              duration: bookingDuration,
              stationID: bookingStation,
              type: bookingTpye,
              spotSlot: bookingSpotslot,
              StationName: bookingStationName,
              date: bookingDate,
              start: bookingStartTime,
              end: bookingEndTime,
              userBookID: booking.id,
              selectedCar: bookingCar,
              spotID: bookingSpotID,
            ),
          ));
        }
      }
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    if (!_controller.isCompleted) {
      _controller.complete(controller);
    }
  }

  static const CameraPosition _current = CameraPosition(
    target: LatLng(13.111263237518639, 100.92051342537894),
    zoom: 14,
  );

  Future<void> _addPolyline(List<LatLng>? _coordinates) async {
    log(" _addPolyline");
    if (_coordinates == null || _coordinates.isEmpty) {
      return;
    }
    PolylineId id = PolylineId("1");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.blueAccent,
        points: _coordinates,
        width: 5,
        onTap: () {});

    setState(() {
      _polylines[id] = polyline;
    });
  }

  Future<void> _getPolylinesWithLocation() async {
    log(" _getPolylinesWithLocation");

    List<LatLng>? _coordinates =
        await _googleMapPolyline.getCoordinatesWithLocation(
      origin: LatLng(
        current_latitude,
        current_longitude,
      ),
      destination: LatLng(
        destination_latitude,
        destination_longitude,
      ),
      mode: RouteMode.driving,
    );

    setState(() {
      _polylines.clear();
    });

    if (_coordinates != null && _coordinates.isNotEmpty) {
      await _addPolyline(_coordinates);
    }
  }

  // Function to get User Current Location
  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission().then((value) {}).onError(
      (error, stackTrace) {
        log("Error");
      },
    );
    Position position = await Geolocator.getCurrentPosition();
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      Placemark place = placemarks[0];
      String description =
          '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

      currentLocation userLocation = currentLocation(
        description: description,
        latitude: position.latitude,
        longitude: position.longitude,
      );
      await dbManager.saveCurrentLocation(userLocation);
    } catch (error) {
      log('Error getting description: $error');
    }
    return position;
  }

  //Set Destination Maker
  Future<void> markDestination() async {
    log('markDestination');
    Map<String, dynamic>? destinationLocation =
        await dbManager.fetchDestinationLocation();
    if (destinationLocation != null) {
      log('fetchDestinationLocation complete ');
      destination_latitude = destinationLocation['destination_latitude'] ?? 0.0;
      destination_longitude =
          destinationLocation['destination_longitude'] ?? 0.0;
      destination_description = destinationLocation['description'] ?? '';
      log('mark Destination_Latitude: $destination_latitude, Destination_Longitude: $destination_longitude, Destination_escription: $destination_description');
    } else {
      log('Destination location is null');
    }

    Marker destinationMarker = await Marker(
      markerId: MarkerId("2"),
      position: LatLng(
        destination_latitude,
        destination_longitude,
      ),
      infoWindow: InfoWindow(title: destination_description),
    );
    setState(
      () {
        // Add the destination marker
        _markers.add(destinationMarker);
      },
    );
  }

  Future<void> marker() async {
    log("Marker");

    try {
      await markDestination();
      //await _getPolylinesWithLocation();
    } catch (error) {
      log('Error in marker: $error');
    }
  }

  Future<Uint8List> getBytesFromAssests(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<List<QueryDocumentSnapshot<Object?>>> _locationMarkers(
      List<QueryDocumentSnapshot> locations) async {
    final Uint8List redIcon =
        await getBytesFromAssests('assets/pin_locate_red.png', 90);
    final Uint8List greenIcon =
        await getBytesFromAssests('assets/pin_locate_green.png', 90);
    if (mounted) {
      setState(
        () {
          for (int i = 0; i < locations.length; i++) {
            String docId = locations[i].id;
            String availableStr = locations[i]['avaliable'];
            bool isAvailable = availableStr == "true";
            Uint8List iconData = isAvailable ? greenIcon : redIcon;
            _markers.add(
              Marker(
                markerId: MarkerId(locations[i]['charging_station']),
                position: LatLng(
                  locations[i]['latitude'].toDouble(),
                  locations[i]['longitude'].toDouble(),
                ),
                icon: BitmapDescriptor.fromBytes(iconData),
                onTap: () {
                  if (isAvailable) {
                    log('Select pump ${docId}');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => parkOrcharging(
                          id: docId,
                        ),
                      ),
                    );
                  } else {
                    alertBox.showFullStationBox(
                        context, 'Charging Station Full!');
                  }
                },
              ),
            );
          }
        },
      );
    }
    return locations;
  }

  // Load Current Location and Mark on Map
  Future<void> loadData() async {
    log("loadData");
    getUserCurrentLocation().then(
      (value) async {
        // Mark User current location
        Map<String, dynamic>? currentLocation =
            await dbManager.fetchCurrentLocation();
        if (currentLocation != null) {
          log('fetchCurrentLocation complete ');
          current_latitude = currentLocation['current_latitude'];
          current_longitude = currentLocation['current_longitude'];
          current_description = currentLocation['description'];

          log('load Current_Latitude: $current_latitude, Current_Longitude: $current_longitude, Current_Description: $current_description');
        } else {
          log('Current location is null');
        }

        _markers.add(
          await Marker(
            markerId: MarkerId("1"),
            position: LatLng(
              current_latitude,
              current_longitude,
            ),
            infoWindow: InfoWindow(title: current_description),
          ),
        );

        // Set camera postion to zoom in your location
        CameraPosition cameraPosition = CameraPosition(
          zoom: 18,
          target: LatLng(
            current_latitude,
            current_longitude,
          ),
        );
        // move camera to new position
        _controller.future.then((controller) {
          controller
              .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
        });

        await marker();

        // update widget state
        setState(() {});
      },
    );
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);

    double screenHeight = mediaQueryData.size.height;

    return Scaffold(
      key: scaffoldKey,
      drawer: SafeArea(
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          child: myDrawer(),
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: _locationsFuture,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            log(snapshot.hasError.toString());
          }
          if (snapshot.hasData) {
            final locations = snapshot.data!.docs;
            _locationMarkers(locations);
            return Stack(
              children: [
                GoogleMap(
                  myLocationButtonEnabled: false,
                  myLocationEnabled: true,
                  compassEnabled: false,
                  markers: Set<Marker>.of(_markers),
                  polylines: Set<Polyline>.of(_polylines.values),
                  mapType: MapType.normal,
                  initialCameraPosition: _current,
                  onMapCreated: _onMapCreated,
                ),
                SafeArea(
                  child: Column(
                    children: [
                      // Drawer and select car button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //Drawer
                          IconButton(
                            icon: Icon(
                              Icons.menu,
                              color: Colors.blue,
                              size: 45,
                            ),
                            onPressed: () =>
                                scaffoldKey.currentState?.openDrawer(),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          ),
                          //select car button
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15)
                                .add(EdgeInsets.only(top: 15)),
                            child: GestureDetector(
                              onTap: () {
                                print("Car");
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => selectVehicle()),
                                );
                              },
                              child: iconButton(
                                width: 45,
                                height: 45,
                                name: Icons.directions_car_outlined,
                                size: 35,
                                backColor: Colors.white,
                                iconColor: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Search button
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        child: searchButton(),
                      ),
                      // Time remining button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: GestureDetector(
                              onTap: () {
                                print("Time");
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => timeRemining(),
                                  ),
                                );
                              },
                              child: iconButton(
                                width: 45,
                                height: 45,
                                name: Icons.notifications_none,
                                size: 35,
                                backColor: Colors.white,
                                iconColor: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Current location button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            child: GestureDetector(
                              onTap: () {
                                loadData();
                              },
                              child: iconButton(
                                width: 45,
                                height: 45,
                                name: Icons.explore_outlined,
                                size: 35,
                                backColor: Colors.white,
                                iconColor: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight / 2.6,
                      ),
                      // Go to current QRcode
                      GestureDetector(
                        onTap: () {
                          getUserBookinfo(context);
                        },
                        child: Container(
                          width: 330,
                          height: 115,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: primaryColor,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 130,
                                height: 110,
                                child: Icon(
                                  Icons.qr_code_scanner,
                                  color: Colors.white,
                                  size: 90,
                                ),
                              ),
                              Container(
                                width: 195,
                                height: 110,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'QRcode ',
                                      style: Qrcodes,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'See your booking now',
                                      style: Qrcodes,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          }
          return Text('Error have not control');
        },
      ),
    );
  }
}
