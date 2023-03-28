import 'package:flutter/material.dart';

class ParkingScreen extends StatefulWidget {
  const ParkingScreen({super.key});
  static const routeName = '/parking';

  @override
  State<ParkingScreen> createState() => _ParkingScreenState();
}

class _ParkingScreenState extends State<ParkingScreen> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parking'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 50),
        child: Column(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 100,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Container(
                              height: 200,
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(),
                                  bottom: BorderSide(),
                                  right: BorderSide(),
                                ),
                              ),
                              child: Container(),
                            ),
                          ),
                          Expanded(
                            flex: 35,
                            child: Container(
                              height: 200,
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(),
                                  bottom: BorderSide(),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                    flex: 85,
                                    child: Image.asset(
                                      './assets/images/blackcar.png',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  const Expanded(flex: 15, child: Text('01')),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 20,
                            child: Container(
                              height: 200,
                            ),
                          ),
                          Expanded(
                            flex: 35,
                            child: Container(
                              height: 200,
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(),
                                  bottom: BorderSide(),
                                ),
                              ),
                              child: GestureDetector(
                                onTap: () =>
                                    setState(() => isSelected = !isSelected),
                                child: Container(
                                  decoration: isSelected
                                      ? const BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.white,
                                              Colors.blue,
                                            ],
                                          ),
                                        )
                                      : const BoxDecoration(),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Expanded(
                                          flex: 15, child: Text('04')),
                                      Expanded(
                                        flex: 85,
                                        child: Center(
                                          child: Text(
                                            isSelected
                                                ? 'Selected'
                                                : 'Avaliable',
                                            style:
                                                const TextStyle(fontSize: 24),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Container(
                              height: 200,
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(),
                                  bottom: BorderSide(),
                                  left: BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Container(
                              height: 200,
                              decoration: const BoxDecoration(
                                border: Border(
                                  right: BorderSide(),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 35,
                            child: SizedBox(
                              height: 200,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                    flex: 85,
                                    child: Container(),
                                  ),
                                  const Expanded(flex: 15, child: Text('02')),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 20,
                            child: Container(
                              height: 200,
                            ),
                          ),
                          Expanded(
                            flex: 35,
                            child: SizedBox(
                              height: 200,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Expanded(flex: 15, child: Text('05')),
                                  Expanded(
                                    flex: 85,
                                    child: Image.asset(
                                      './assets/images/greencar.png',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Container(
                              height: 200,
                              decoration: const BoxDecoration(
                                border: Border(
                                  left: BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Container(
                              height: 200,
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(),
                                  bottom: BorderSide(),
                                  right: BorderSide(),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 35,
                            child: Container(
                              height: 200,
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(),
                                  bottom: BorderSide(),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                    flex: 85,
                                    child: Container(),
                                  ),
                                  const Expanded(flex: 15, child: Text('03')),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 20,
                            child: Container(
                              height: 200,
                            ),
                          ),
                          Expanded(
                            flex: 35,
                            child: Container(
                              height: 200,
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(),
                                  bottom: BorderSide(),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Expanded(flex: 15, child: Text('06')),
                                  Expanded(
                                    flex: 85,
                                    child: Image.asset(
                                      './assets/images/blue-car.png',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Container(
                              height: 200,
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(),
                                  bottom: BorderSide(),
                                  left: BorderSide(),
                                ),
                              ),
                              child: Container(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 300,
                  child: Row(
                    children: [
                      Expanded(flex: 5, child: Container()),
                      Expanded(
                        flex: 35,
                        child: Container(
                          color: Colors.blue.withOpacity(0.4),
                          height: 300,
                        ),
                      ),
                      Expanded(flex: 20, child: Container()),
                      Expanded(flex: 35, child: Container()),
                      Expanded(flex: 5, child: Container()),
                    ],
                  ),
                ),
                SizedBox(
                  height: 300,
                  child: Row(
                    children: [
                      Expanded(flex: 5, child: Container()),
                      const Expanded(
                        flex: 35,
                        child: Center(
                          child: RotatedBox(
                            quarterTurns: 3,
                            child: Text(
                              'For Charging',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Expanded(flex: 20, child: Container()),
                      Expanded(flex: 35, child: Container()),
                      Expanded(flex: 5, child: Container()),
                    ],
                  ),
                ),
              ],
            ),
            if (isSelected) const SizedBox(height: 100),
            if (isSelected)
              Container(
                padding: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[100],
                  ),
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.blue[400],
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
