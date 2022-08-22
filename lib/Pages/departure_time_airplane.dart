import 'dart:async';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

import '../Constants.dart';
import 'choose_seat.dart';

class DepartureTimeAirplane extends StatefulWidget {
  const DepartureTimeAirplane({Key? key}) : super(key: key);

  @override
  State<DepartureTimeAirplane> createState() => _DepartureTimeAirplaneState();
}

class _DepartureTimeAirplaneState extends State<DepartureTimeAirplane> {
  Timer? timer;
  int positionL = 0;
  late int positionT;

  void start() {
    timer = Timer.periodic(const Duration(milliseconds: 20), (timer) {
      String positionStr = (MediaQuery.of(context).size.width - 130).toString();
      String positionStrT = (MediaQuery.of(context).size.width / 3).toString();
      String positionStrTop =
          (MediaQuery.of(context).size.height / 6.4).toString();
      int num = int.parse(positionStr.split('.')[0]);
      int numT = int.parse(positionStrT.split('.')[0]);
      int numTop = int.parse(positionStrTop.split('.')[0]);

      if (positionL != num) {
        if (mounted) {
          setState(() {
            positionL++;
            positionT--;
          });
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    start();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    String positionStr = (MediaQuery.of(context).size.height / 6.4).toString();
    positionT = int.parse(positionStr.split('.')[0]);
    return Scaffold(
      backgroundColor: Constants.normal,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height / 5 * 1.6,
              decoration: BoxDecoration(
                  color: Constants.primary,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  _appbar(),
                  _showdirection(size),
                  SizedBox(
                    height: 25,
                  ),
                  _buildDepartureTime(size),
                  SizedBox(
                    height: 8,
                  ),
                  _buildLineCard(size),
                ],
              ),
            ),
            SizedBox(
              height: size.height / 8 * 1.1,
            ),
            AnimatedPositioned(
              left: positionL + 40,
              top: double.parse(positionT.toString()),
              duration: Duration(milliseconds: 400),
              child: Image.asset(
                "assets/images/plane.png",
                height: size.width / 19,
                color: Constants.textLight,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: size.height / 8 * 1.5,
                  ),
                  Container(
                    height: 3,
                    color: Constants.textLight,
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget _buildLineCard(size) {
    return Container(
      height: size.height / 5 * 3,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: Constants.planeLines.length,
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 130,
                        child: Column(
                          children: [
                            Image.asset(
                              Constants.planeLines[index][0],
                              width: 100,
                              height: 50,
                            ),
                            Text(
                              Constants.planeLines[index][1],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "${Constants.time} - Standard Class",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "From : ${Constants.fromCity}\nTo : ${Constants.toCity}\nDate : ${Constants.date}\nDuration : (Time) Hours",
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: 5),
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "1seat x ${Constants.price} Ks",
                            style: TextStyle(
                                color: Constants.textDark,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            onTap: () {
                              Constants.busLineName =
                                  Constants.planeLines[index][1];
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChooseSeat(type: "Airplane",)));
                            },
                            child: Container(
                              width: 70,
                              height: 25,
                              margin: EdgeInsets.only(top: 5),
                              decoration: BoxDecoration(
                                  color: Constants.primary,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Center(
                                child: Icon(
                                  Icons.arrow_forward,
                                  size: 25,
                                  color: Constants.textLight,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDepartureTime(size) {
    return Container(
      width: size.width - 20,
      height: 50,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey,
        )
      ], color: Constants.textLight, borderRadius: BorderRadius.circular(10)),
      child: Center(
          child: Text(
        "Departure Times",
        style: TextStyle(
            color: Constants.primary,
            fontSize: 20,
            fontWeight: FontWeight.bold),
      )),
    );
  }

  Widget _showdirection(size) {
    return Container(
      width: size.width - 20,
      height: size.height / 5 * 1,
      padding: EdgeInsets.all(10),
      child: Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Constants.textLight),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      Constants.fromCity,
                      style: TextStyle(
                          color: Constants.textLight,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Constants.textLight),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      Constants.toCity,
                      style: TextStyle(
                          color: Constants.textLight,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ]),
    );
  }

  Widget _appbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.arrow_back,
                color: Constants.textLight,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Back",
              style: TextStyle(
                  color: Constants.textLight,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
        Row(
          children: [
            InkWell(
              onTap: () {},
              child: Icon(
                Icons.menu_open,
                size: 30,
                color: Constants.textLight,
              ),
            )
          ],
        )
      ],
    );
  }
}
