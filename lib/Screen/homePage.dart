import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myapp/Database/dataBaseManager.dart';
import 'package:myapp/Models/currentLocation_model.dart';
import 'package:myapp/Models/destination_model.dart';
import 'package:myapp/Screen/Drawer/myCar.dart';
import 'package:myapp/Screen/timeRemining.dart';
import 'package:myapp/Widget/IconButton.dart';
import 'package:myapp/Widget/myDrawer.dart';
import 'package:myapp/Widget/seractButton.dart';
import 'package:google_map_polyline_new/google_map_polyline_new.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
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
  final List<Marker> _markers = <Marker>[];

  dataBaseManager dbManager = dataBaseManager();

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
        width: 4,
        onTap: () {});

    setState(() {
      _polylines[id] = polyline;
    });
  }

  Future<void> _getPolylinesWithLocation() async {
    log(" _getPolylinesWithLocation");
    log('destination : $destinations');
    log('currentLocations : $currentLocations');
    if (currentLocations.isNotEmpty &&
        currentLocations[0].latitude != null &&
        currentLocations[0].longitude != null &&
        destinations.isNotEmpty &&
        destinations[0].latitude != null &&
        destinations[0].longitude != null) {
      log("not empty ");
      List<LatLng>? _coordinates =
          await _googleMapPolyline.getCoordinatesWithLocation(
        origin: LatLng(
          currentLocations[0].latitude!,
          currentLocations[0].longitude!,
        ),
        destination: LatLng(
          destinations[0].latitude!,
          destinations[0].longitude!,
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
      log('Currenta location description: $description');
      await dbManager.saveCurrentLocation(userLocation);

      await fetchCurrentLocation();
    } catch (error) {
      log('Error getting description: $error');
    }
    return position;
  }

  // Fetch Usr current latitude longitude from Firebase
  Future<void> fetchCurrentLocation() async {
    log("Fetching Current location...");
    CollectionReference location =
        FirebaseFirestore.instance.collection('Test');
    DocumentSnapshot<Map<String, dynamic>> snapshot = await location
        .doc('CurrentLocation')
        .get() as DocumentSnapshot<Map<String, dynamic>>;
    currentLocation current = currentLocation.fromJson(snapshot.data()!);
    currentLocations = [current];
    log("currentLocation : ${currentLocations}");
  }

  // Fetch Destination Location, latitude ,longitude from Firebase
  Future<void> fetchDestinationtLocation() async {
    log("Fetching Destination location...");
    CollectionReference location =
        FirebaseFirestore.instance.collection('Test');
    DocumentSnapshot<Map<String, dynamic>> snapshot = await location
        .doc('Destination')
        .get() as DocumentSnapshot<Map<String, dynamic>>;
    destination destinationLocation = destination.fromJson(snapshot.data()!);
    destinations = [destinationLocation];
    log('destination : ${destinations}');
  }

  //Set Destination Maker
  Future<void> markDestination() async {
    if (destinations.isNotEmpty &&
        destinations[0].latitude != null &&
        destinations[0].longitude != null) {
      log("destination is not empty");
      Marker destinationMarker = await Marker(
        markerId: MarkerId("2"),
        position: LatLng(
          destinations[0].latitude!,
          destinations[0].longitude!,
        ),
        infoWindow:
            InfoWindow(title: destinations[0].description ?? "Destination"),
      );
      setState(
        () {
          // Add the destination marker
          log("Add the destination marker");
          _markers.add(destinationMarker);
        },
      );
    } else {
      log("Destibation is null");
    }
  }

  Future<void> marker() async {
    log("Marker");

    try {
      await fetchDestinationtLocation();
      ;
      log("destination $destinations");
      await markDestination();
      await _getPolylinesWithLocation();
    } catch (error) {
      log('Error in marker: $error');
    }
  }

  // Load Current Location and Mark on Map
  Future<void> loadData() async {
    log("loadData");
    getUserCurrentLocation().then(
      (value) async {
        // Mark User current location

        _markers.add(
          await Marker(
            markerId: MarkerId("1"),
            position: LatLng(
              currentLocations[0].latitude!,
              currentLocations[0].longitude!,
            ),
            infoWindow: InfoWindow(title: "My current location"),
          ),
        );

        // Set camera postion to zoom in your location
        CameraPosition cameraPosition = CameraPosition(
          zoom: 18,
          target: LatLng(
            currentLocations[0].latitude!,
            currentLocations[0].longitude!,
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
        body: Stack(
          children: [
            // Google Maps
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
            // Button
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
                        onPressed: () => scaffoldKey.currentState?.openDrawer(),
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
                              MaterialPageRoute(builder: (_) => myCar()),
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
                                builder: (_) => timeRemining(),
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
                ],
              ),
            )
          ],
        ));
  }
}
