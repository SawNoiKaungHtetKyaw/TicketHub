import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

import '../Constants.dart';
import 'home.dart';

class GetTicket extends StatefulWidget {
  const GetTicket({Key? key}) : super(key: key);

  @override
  State<GetTicket> createState() => _GetTicketState();
}

class _GetTicketState extends State<GetTicket> {
  Uint8List? bytes;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // loadImage();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Constants.normal,
      appBar: AppBar(
        backgroundColor: Constants.primary,
        title: Text(
          "Back",
          style: TextStyle(color: Constants.textLight),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.menu_open, color: Constants.textLight))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              _getTravelTicket(size),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _eachBtn("Send Email", () {}),
                  _eachBtn("Get Photo", () async {
                    final controller = ScreenshotController();
                    final bytes = await controller.captureFromWidget(Material(
                      child: _getTravelTicket(size),
                    ));
                    setState(() {
                      this.bytes = bytes;
                    });
                    // saveImage(bytes);
                    final appStorage = await getApplicationDocumentsDirectory();

                    final file = File("${appStorage.path}/image.png");
                    file.writeAsBytes(bytes);

                    controller.capture(pixelRatio: 1.5).then((image) {
                      GallerySaver.saveImage(
                        "${appStorage.path}/image.png",
                        albumName: 'myNewAlbum',
                      ).then((success) {
                        print("successful");
                      });
                    }).catchError((err) {
                      print(err);
                    });
                    Get.snackbar("TicketHub ticket", "Save ticket Successful");
                    print("get ticket successful");
                  }),
                  _eachBtn("Print Ticket", () {}),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _eachBtn("Done", () {
                    setState(() {
                      Constants.fromCity = "Select City";
                      Constants.toCity = "Select City";
                      Constants.date = "Select Date";
                      Constants.time = "08:00 AM";
                      Constants.busLineName = "";
                      Constants.busLineImage = "";
                      Constants.seatNo = "";
                      Constants.price = "25000";
                      Constants.bookingID = "10000001";
                      Constants.arrival = "4:00 PM";
                      Constants.duration = "8 Hours";

                      //Passenger Info
                      Constants.name = "";
                      Constants.phone = "";
                      Constants.email = "";
                      Constants.gender = "";
                      Constants.nrc = "";

                      Constants.paymentType = "Select Payment";
                      Constants.selected = false;
                    });

                    print(Constants.name);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future loadImage() async {
    final appStorage = await getApplicationDocumentsDirectory();

    final file = File("${appStorage.path}/image.png");
    if (file.existsSync()) {
      final bytes = await file.readAsBytes();
      setState(() {
        this.bytes = bytes;
      });
    }
  }

  Future saveImage(Uint8List bytes) async {
    final appStorage = await getApplicationDocumentsDirectory();

    final file = File("${appStorage.path}/image.png");
    file.writeAsBytes(bytes);
  }

  Widget _getTravelTicket(size) {
    return Container(
      width: size.width - 20,
      color: Constants.textLight,
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            "Travel Ticket",
            style: Constants.style(Constants.textDark, 18, FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                "assets/images/logo.png",
                width: 80,
                height: 80,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Ticket Hub",
                    textAlign: TextAlign.end,
                    style: Constants.style(
                        Constants.textDark, 16, FontWeight.w500),
                  ),
                  Text(
                    "Ticket Sale Service",
                    textAlign: TextAlign.end,
                    style: Constants.style(
                        Constants.textDark, 15, FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
          Container(
            height: 1,
            color: Constants.hint,
          ),

          // Line Info--------------------------------------------------------
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Text(
                  "Line Information",
                  style:
                      Constants.style(Constants.textDark, 16, FontWeight.bold),
                )
              ],
            ),
          ),
          _eachInfo("Bus Line No.", Constants.busNo),
          _eachInfo("Bus Line Name", Constants.busLineName),
          _eachInfo("From-To", "${Constants.fromCity}-${Constants.toCity}"),
          _eachInfo("Date", Constants.date),
          _eachInfo("Departure Time", Constants.time),
          _eachInfo("Arrival", Constants.arrival),
          _eachInfo("Duration", Constants.duration),

          //passenger Info----------------------------------------------------
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Text(
                  "Line Information",
                  style:
                      Constants.style(Constants.textDark, 16, FontWeight.bold),
                )
              ],
            ),
          ),
          _eachInfo("Booking ID", Constants.bookingID),
          _eachInfo("Name", Constants.name),
          _eachInfo("Phone", Constants.phone),
          _eachInfo("Email", Constants.email),
          _eachInfo("Gender", Constants.gender),
          _eachInfo("NRC", Constants.nrc),
          _eachInfo("SeatNo", Constants.seatNo),
          _eachInfo("Price", "${Constants.price} Ks")
        ],
      ),
    );
  }

  Widget _eachBtn(text, _onPressed) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Constants.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          onPressed: _onPressed,
          child: Text(
            text,
            style: Constants.style(Constants.textLight, 14, FontWeight.w700),
          ),
        ),
      ),
    );
  }

  Widget _eachInfo(text, value) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(text), Text(value)],
      ),
    );
  }
}
