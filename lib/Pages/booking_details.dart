import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../Constants.dart';
import 'get_ticket.dart';

class BookingDetails extends StatefulWidget {
  String? seatno, name, phone, email, gender, nrc;
  BookingDetails(
      {Key? key,
      this.seatno,
      this.name,
      this.phone,
      this.email,
      this.gender,
      this.nrc})
      : super(key: key);

  @override
  State<BookingDetails> createState() => _BookingDetailsState(
      this.seatno, this.name, this.phone, this.email, this.gender, this.nrc);
}

class _BookingDetailsState extends State<BookingDetails> {
  String? seatno, name, phone, email, gender, nrc;
  _BookingDetailsState(
      this.seatno, this.name, this.phone, this.email, this.gender, this.nrc);

  Timer? timer;
  int second = 60, minute = 19;
  String digitSecond = "00", digitMinute = "20";
  bool started = true;

  @override
  void dispose() {
    super.dispose();
  }

  void start() {
    if (started) {
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        int localSecond = second - 1;
        int localMinute = minute;

        if (localSecond == 0) {
          if (localMinute > 0) {
            localMinute--;
            localSecond = 60;
          } else {
            localMinute = 0;
          }
          if (localMinute == 0 && localSecond == 0) {
            timer.cancel();
          }
        }

        setState(() {
          second = localSecond;
          minute = localMinute;

          digitSecond = (second == 60)
              ? "00"
              : (second >= 10)
                  ? "$second"
                  : "0$second";
          digitMinute = (minute >= 10) ? "$minute" : "0$minute";
        });
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    start();
  }

  int selected = 0;
  bool show = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Constants.normal,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(children: [
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
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _appbar(),
                    const SizedBox(
                      height: 25,
                    ),
                    _someInfo(),
                    const SizedBox(
                      height: 20,
                    ),
                    _buildSelectPayment(size),
                    const SizedBox(
                      height: 10,
                    ),
                    selected == 1 ? _buildKpayPayment() : Container(),
                    selected == 2 ? _buildWavePayment() : Container(),
                    const SizedBox(
                      height: 10,
                    ),
                    _buildBookingInfo(),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  Constants.soldout.add(seatno);
                                  print(Constants.soldout);
                                });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GetTicket()));
                              },
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(10),
                                  primary: Constants.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              child: Text(
                                "Comfirm",
                                style: TextStyle(
                                    color: Constants.textLight, fontSize: 16),
                              )),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(10),
                                  primary: Constants.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                    color: Constants.textLight, fontSize: 16),
                              )),
                        )
                      ],
                    )
                  ],
                ))
          ]),
        ),
      ),
    );
  }

  Widget _buildKpayPayment() {
    return Container(
      padding: EdgeInsets.all(10),
      color: Constants.primary,
      child: Column(
        children: [
          Text("Use KBZPay Scan to pay me",
              style: Constants.style(Constants.textLight, 18, FontWeight.bold)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Image.asset(
              "assets/images/scan.jpg",
              scale: 3,
            ),
          ),
          Text("Saw Noi Kaung Htet Kyaw(*******0473)",
              style: Constants.style(Constants.textLight, 14, FontWeight.bold))
        ],
      ),
    );
  }

  Widget _buildWavePayment() {
    return Container(
      padding: EdgeInsets.all(10),
      color: Constants.primary,
      child: Column(
        children: [
          Text("Let your sender scan this QR code\nto send money to you",
              textAlign: TextAlign.center,
              style: Constants.style(Constants.textLight, 16, FontWeight.w500)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Image.asset(
              "assets/images/scan.jpg",
              scale: 3,
            ),
          ),
          Text("My number",
              textAlign: TextAlign.center,
              style: Constants.style(Constants.textLight, 14, FontWeight.w500)),
          Text("9962030473",
              textAlign: TextAlign.center,
              style: Constants.style(Constants.textLight, 18, FontWeight.bold))
        ],
      ),
    );
  }

  Widget _buildBookingInfo() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Constants.textLight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [Text("Booking ID : ${Constants.bookingID}")],
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Passanger Information",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 8,
          ),
          info("Name", Constants.name),
          info("Phone", Constants.phone),
          info("Email", Constants.email),
          info("Gender", Constants.gender),
          info("NRC", Constants.nrc),
          SizedBox(
            height: 8,
          ),
          Container(
            height: 1,
            color: Constants.accentDark,
          ),
          SizedBox(
            height: 2,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _datetimeInfo("Date", Constants.date),
                _datetimeInfo("Time", Constants.time),
                _datetimeInfo("Seat No.", Constants.seatNo),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Price : ${Constants.price} Ks',
                  style:
                      Constants.style(Constants.textDark, 18, FontWeight.bold),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget info(text, value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      child: Text(
        "$text : $value",
        textAlign: TextAlign.start,
        style: TextStyle(color: Constants.textDark),
      ),
    );
  }

  Widget _datetimeInfo(text, value) {
    return Column(
      children: [
        Text(
          text,
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Constants.textDark),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          value,
          style: TextStyle(fontSize: 14, color: Constants.hint),
        ),
      ],
    );
  }

  Widget _buildSelectPayment(size) {
    return Container(
      height: 70,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Constants.accent, borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Constants.textLight,
                ),
                child: Image.asset(
                  Constants.paymentImage[selected],
                  fit: BoxFit.contain,
                )),
          ),
          SizedBox(
            width: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: _dropDownBtn(size),
          )
        ],
      ),
    );
  }

  Widget _dropDownBtn(size) {
    return Container(
      width: size.width / 3.5 * 2.6,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Constants.textLight,
      ),
      child: Center(
        child: DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton<String>(
              isDense: true,
              value: Constants.paymentType,
              style: TextStyle(fontSize: 13, color: Constants.textDark),
              icon: Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: Constants.primary,
                    ),
                  ],
                ),
              ),
              onChanged: (newValue) {
                setState(() {
                  Constants.paymentType = newValue!;
                  if (Constants.paymentType == "Kbzpay") {
                    selected = 1;
                  } else if (Constants.paymentType == "Wave Pay") {
                    selected = 2;
                  } else {
                    selected = 0;
                  }
                });
              },
              items: Constants.payment
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _someInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Booking Details",
          textAlign: TextAlign.center,
          style: Constants.style(Constants.textLight, 16, FontWeight.w400),
        ),
        SizedBox(
          height: 15,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            Constants.fromCity,
            style: Constants.style(Constants.textLight, 22, FontWeight.bold),
          ),
          Icon(
            Icons.repeat,
            color: Constants.textLight,
            size: 35,
          ),
          Text(
            Constants.toCity,
            style: Constants.style(Constants.textLight, 22, FontWeight.bold),
          )
        ]),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 40,
          decoration: BoxDecoration(
              color: Constants.textLight,
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Text(
              "Booking Remaining Time : 00:$digitMinute:$digitSecond ",
              textAlign: TextAlign.center,
              style: Constants.style(Constants.textDark, 18, FontWeight.bold),
            ),
          ),
        )
      ],
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
