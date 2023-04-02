import 'package:flutter/material.dart';
import 'package:myapp/Widget/styles.dart';

class ChargingScreen extends StatefulWidget {
  const ChargingScreen({super.key});
  static const routeName = '/charging';

  @override
  State<ChargingScreen> createState() => _ChargingScreenState();
}

class _ChargingScreenState extends State<ChargingScreen> {
  bool isSelected1 = false;
  bool isSelected2 = false;

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
          "charging",
          style: headerText,
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
                                  // Expanded(
                                  //   flex: 85,
                                  //   child: Image.asset(
                                  //     './assets/images/blackcar.png',
                                  //     fit: BoxFit.fill,
                                  //   ),
                                  // ),
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Expanded(flex: 15, child: Text('04')),
                                  Expanded(flex: 85, child: Container()),
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
                            child: GestureDetector(
                              onTap: () => setState(() {
                                isSelected1 = !isSelected1;
                                isSelected2 = false;
                              }),
                              child: Container(
                                height: 200,
                                decoration: isSelected1
                                    ? const BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.blue,
                                            Colors.white,
                                          ],
                                        ),
                                      )
                                    : const BoxDecoration(),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      flex: 85,
                                      child: Center(
                                        child: Text(
                                          isSelected1
                                              ? 'Selected'
                                              : 'Avaliable',
                                          style: const TextStyle(fontSize: 24),
                                        ),
                                      ),
                                    ),
                                    const Expanded(flex: 15, child: Text('02')),
                                  ],
                                ),
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
                                  // Expanded(
                                  //   flex: 85,
                                  //   child: Image.asset(
                                  //     './assets/images/greencar.png',
                                  //     fit: BoxFit.fill,
                                  //   ),
                                  // ),
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
                            child: GestureDetector(
                              onTap: () => setState(() {
                                isSelected2 = !isSelected2;
                                isSelected1 = false;
                              }),
                              child: Container(
                                height: 200,
                                decoration: const BoxDecoration(
                                  border: Border(
                                    top: BorderSide(),
                                    bottom: BorderSide(),
                                  ),
                                ),
                                child: Container(
                                  decoration: isSelected2
                                      ? const BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.blue,
                                              Colors.white,
                                            ],
                                          ),
                                        )
                                      : const BoxDecoration(),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        flex: 85,
                                        child: Center(
                                          child: Text(
                                            isSelected2
                                                ? 'Selected'
                                                : 'Avaliable',
                                            style:
                                                const TextStyle(fontSize: 24),
                                          ),
                                        ),
                                      ),
                                      const Expanded(
                                          flex: 15, child: Text('03')),
                                    ],
                                  ),
                                ),
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
                                  // Expanded(
                                  //   flex: 85,
                                  //   child: Image.asset(
                                  //     './assets/images/blue-car.png',
                                  //     fit: BoxFit.fill,
                                  //   ),
                                  // ),
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
                      Expanded(flex: 35, child: Container()),
                      Expanded(flex: 20, child: Container()),
                      Expanded(
                        flex: 35,
                        child: Container(
                          color: Colors.blue.withOpacity(0.4),
                          height: 300,
                        ),
                      ),
                      Expanded(flex: 5, child: Container()),
                    ],
                  ),
                ),
                SizedBox(
                  height: 300,
                  child: Row(
                    children: [
                      Expanded(flex: 5, child: Container()),
                      Expanded(flex: 35, child: Container()),
                      Expanded(flex: 20, child: Container()),
                      const Expanded(
                        flex: 35,
                        child: Center(
                          child: RotatedBox(
                            quarterTurns: 1,
                            child: Text(
                              'For Parking',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Expanded(flex: 5, child: Container()),
                    ],
                  ),
                ),
              ],
            ),
            if (isSelected1 || isSelected2) const SizedBox(height: 100),
            if (isSelected1 || isSelected2)
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
