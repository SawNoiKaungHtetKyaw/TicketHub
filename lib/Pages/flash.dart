import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../Constants.dart';
import 'home.dart';

class FlashScreen extends StatefulWidget {
  const FlashScreen({Key? key}) : super(key: key);

  @override
  State<FlashScreen> createState() => _FlashScreenState();
}

class _FlashScreenState extends State<FlashScreen> {
  // Timer? timer;
  // double loading = 0;

  load() async {
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Home()),
          ModalRoute.withName("/"));
    });
  }

  // timing() {
  //   timer = Timer.periodic(Duration(milliseconds: 35), (timer) {
  //     double localLoading = loading + 0.01;
  //     if (localLoading == 1) {
  //       timer.cancel();
  //     }

  //     setState(() {
  //       loading = localLoading;
  //     });
  //   });
  // }

  @override
  void initState() {
    super.initState();
    load();
    // timing();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Constants.primary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: size.height / 3 * 0.8,
          ),
          Image.asset(
            "assets/images/logo.png",
            color: Constants.textLight,
            width: 70,
            height: 70,
            fit: BoxFit.contain,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Welcome!",
            textAlign: TextAlign.center,
            style: Constants.style(Constants.textLight, 24, FontWeight.w400),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Ticket Hub",
            textAlign: TextAlign.center,
            style: Constants.style(Constants.textLight, 24, FontWeight.w600),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Ticket Sale Service",
            textAlign: TextAlign.center,
            style: Constants.style(Constants.textLight, 20, FontWeight.w600),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: LinearProgressIndicator(
              backgroundColor: Constants.textLight,
              color: Colors.redAccent,
              minHeight: 10,
            ),
          )
        ],
      ),
    );
  }
}
