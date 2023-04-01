import 'package:flutter/material.dart';
import 'package:myapp/Screen/parking.screen.dart';
import 'charging.screen.dart';

class StationScreen extends StatefulWidget {
  const StationScreen({super.key});
  static const routeName = '/station';

  @override
  State<StationScreen> createState() => _StationScreenState();
}

class _StationScreenState extends State<StationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Parking or Charging')),
      body: Column(
        children: [
          Image.asset(
            'assets/EVIE.png',
            height: 280,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'KU Charging Station',
                        style: TextStyle(fontSize: 24),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text('5.0'),
                          SizedBox(width: 10),
                          Icon(Icons.star, color: Colors.blue),
                          Icon(Icons.star, color: Colors.blue),
                          Icon(Icons.star, color: Colors.blue),
                          Icon(Icons.star, color: Colors.blue),
                          Icon(Icons.star, color: Colors.blue),
                          SizedBox(width: 10),
                          Text('4 review'),
                        ],
                      ),
                      const Text('Charging Station'),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {},
                    style:
                        ElevatedButton.styleFrom(shape: const CircleBorder()),
                    child: const Icon(Icons.directions),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: const [
                Expanded(
                  flex: 10,
                  child: Icon(
                    Icons.ev_station_outlined,
                    color: Colors.blue,
                  ),
                ),
                Expanded(flex: 40, child: Text('CHAdeMO')),
                Expanded(flex: 40, child: Text('50 kW')),
                Expanded(flex: 10, child: Text('1/1')),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: const [
                Expanded(
                  flex: 10,
                  child: Icon(
                    Icons.ev_station_outlined,
                    color: Colors.blue,
                  ),
                ),
                Expanded(flex: 40, child: Text('CCS')),
                Expanded(flex: 40, child: Text('50 kW')),
                Expanded(flex: 10, child: Text('1/1')),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.fmd_good_outlined,
                      color: Colors.blue,
                    )),
                Expanded(
                  flex: 9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        '199 Moo 6, Sukhumvit Road, Thung Sukla Subdistrict Sriracha District, Chonburi 30330',
                      ),
                      Text('Made in Kasetsart University')
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context)
                        .pushNamed(ParkingScreen.routeName),
                    style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll<Color>(
                          Colors.lightBlue),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: const [
                          Icon(
                            Icons.fmd_good_outlined,
                            size: 50,
                            color: Colors.black,
                          ),
                          Text(
                            'Parking',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 24),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 5,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context)
                        .pushNamed(ChargingScreen.routeName),
                    style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll<Color>(
                          Colors.lightBlue),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: const [
                          Icon(Icons.ev_station_outlined,
                              size: 50, color: Colors.black),
                          Text(
                            'Charging',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 24),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
