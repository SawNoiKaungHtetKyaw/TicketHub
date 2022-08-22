import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:group_radio_button/group_radio_button.dart';

import '../Constants.dart';
import 'booking_details.dart';

class ChooseSeat extends StatefulWidget {
  String? type;
  ChooseSeat({Key? key, this.type}) : super(key: key);

  @override
  State<ChooseSeat> createState() => _ChooseSeatState(this.type);
}

String seatno = "";
String errorText = "";
bool selected = false;

late TextEditingController _controllerName =
    TextEditingController(text: Constants.name);
late TextEditingController _controllerPhone = TextEditingController();
late TextEditingController _controllerEmail = TextEditingController();
late TextEditingController _controllerNRC = TextEditingController();
var _groupValue = "Male";
List<String> _type = ["Male", "Female", "Other"];

class _ChooseSeatState extends State<ChooseSeat> {
  String? type;
  _ChooseSeatState(this.type);
  final _formKey = GlobalKey<FormState>();
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Constants.normal,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height / 2 * 1,
              decoration: BoxDecoration(
                  color: Constants.primary,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  _appbar(),
                  const SizedBox(
                    height: 25,
                  ),
                  _someInfo(),
                  const SizedBox(
                    height: 30,
                  ),
                  type == "Bus"
                      ? _ChooseSeatBus(size)
                      : (type == "Airplane"
                          ? _ChooseSeatPlane(size)
                          : _ChooseSeatBus(size)),
                ],
              ),
            ),
            Constants.selected ? _buildInformation(size) : Text(""),
          ],
        ),
      )),
    );
  }

  Widget _buildInformation(size) {
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
          color: Constants.primary, borderRadius: BorderRadius.circular(10)),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      Constants.selected = false;
                    });
                  },
                  icon: Icon(Icons.close, color: Constants.textLight))
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Information",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Constants.textLight,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      height: 25,
                      decoration: BoxDecoration(
                          color: Constants.textLight,
                          borderRadius: BorderRadius.circular(12)),
                      child: Center(
                          child: Text(
                        "Seat Number : ${seatno}",
                        style: TextStyle(fontSize: 14),
                      )),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      height: 25,
                      decoration: BoxDecoration(
                          color: Constants.textLight,
                          borderRadius: BorderRadius.circular(12)),
                      child: Center(
                          child: Text("Price : ${Constants.price} Ks",
                              style: TextStyle(fontSize: 14))),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _inputInfo("Input Passanger Name", _controllerName,
                        TextInputType.name, (value) {
                      if (value == null || value.isEmpty) {
                        return "Please fill name";
                      }
                      return null;
                    }),
                    SizedBox(
                      height: 5,
                    ),
                    _inputInfo("Input Passanger Phone", _controllerPhone,
                        TextInputType.phone, (value) {
                      if (value == null || value.isEmpty) {
                        return "Please fill password";
                      } else if (value.length < 10) {
                        return "Phone number must be at least 9 char";
                      }
                      return null;
                    }),
                    SizedBox(
                      height: 5,
                    ),
                    _inputInfo("Input Passanger Email", _controllerEmail,
                        TextInputType.emailAddress, (value) {
                      return null;
                    }),
                    _radioGroup(),
                    _inputInfo("Input Passanger NRC", _controllerNRC,
                        TextInputType.name, (value) {
                      if (value.contains("/")) {
                        return "NRC Wrong";
                      }
                      return null;
                    }),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Constants.textLight,
                              padding: EdgeInsets.all(14),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                Constants.seatNo = seatno;
                                Constants.name = _controllerName.text;
                                Constants.phone = _controllerPhone.text;
                                Constants.email = _controllerEmail.text;
                                Constants.gender = _groupValue;
                                Constants.nrc = _controllerNRC.text;
                                _controllerName.text = "";
                                _controllerPhone.text = "";
                                _controllerEmail.text = "";
                                _controllerNRC.text = "";
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BookingDetails(
                                              seatno: Constants.seatNo,
                                              name: Constants.name,
                                              phone: Constants.phone,
                                              email: Constants.email,
                                              gender: Constants.gender,
                                              nrc: Constants.nrc,
                                            )));
                              });
                            }
                          },
                          child: Text(
                            "Book Now",
                            textAlign: TextAlign.center,
                            style: Constants.style(
                                Constants.primary, 18, FontWeight.bold),
                          )),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _inputInfo(hint, TextEditingController text, keyboard, validate) {
    return TextFormField(
        validator: validate,
        keyboardType: keyboard,
        cursorColor: Constants.primary,
        style: TextStyle(color: Constants.textDark, fontSize: 14),
        controller: text,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          hintText: hint,
          labelStyle: TextStyle(color: Constants.hint),
          fillColor: Constants.accent,
          filled: true,
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Constants.error)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Constants.accentDark)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Constants.accentDark)),
        ));
  }

  Widget _radioGroup() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: RadioGroup<String>.builder(
            activeColor: Constants.textLight,
            direction: Axis.horizontal,
            groupValue: _groupValue,
            horizontalAlignment: MainAxisAlignment.spaceAround,
            onChanged: (value) => setState(() {
              _groupValue = value!;
              print(value);
            }),
            items: _type,
            textStyle: TextStyle(fontSize: 15, color: Constants.textLight),
            itemBuilder: (item) => RadioButtonBuilder(
              item,
            ),
          ),
        ),
        SizedBox(
          width: 3,
        ),
      ],
    );
  }

  Widget _ChooseSeatPlane(size) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: size.width - 60,
      decoration: BoxDecoration(
          color: Constants.secondry,
          borderRadius: new BorderRadius.all(Radius.elliptical(200, 500))),
      child: Container(
        padding: const EdgeInsets.all(10),
        width: size.width - 80,
        decoration: BoxDecoration(
            color: Constants.textLight,
            borderRadius: new BorderRadius.all(Radius.elliptical(200, 500))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Image.asset(
              "assets/images/cabin.png",
              color: Constants.secondry,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _buildRowOfseats("1A", "1B", "1C", "1D", size),
                _buildRowOfseats("2A", "2B", "2C", "2D", size),
                _buildRowOfseats("3A", "3B", "3C", "3D", size),
                _buildRowOfseats("4A", "4B", "4C", "4D", size),
                _buildRowOfseats("5A", "5B", "5C", "5D", size),
                _buildRowOfseats("6A", "6B", "6C", "6D", size),
                _buildRowOfseats("7A", "7B", "7C", "7D", size),
                _buildRowOfseats("8A", "8B", "8C", "8D", size),
                _buildRowOfseats("9A", "9B", "9C", "9D", size),
                _buildRowOfseats("10A", "10B", "10C", "10D", size),
                _buildRowOfseats("11A", "11B", "11C", "11D", size),
                _buildRowOfseats("12A", "12B", "12C", "12D", size),
                _buildRowOfseats("13A", "13B", "13C", "13D", size),
                _buildRowOfseats("14A", "14B", "14C", "14D", size),
                _buildRowOfseats("15A", "15B", "15C", "15D", size),
                _buildRowOfseats("16A", "16B", "16C", "16D", size),
                _buildRowOfseats("17A", "17B", "17C", "17D", size),
              ],
            ),
          ),
          const SizedBox(
            height: 250,
          ),
        ]),
      ),
    );
  }

  Widget _ChooseSeatBus(size) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: size.width - 60,
      decoration: BoxDecoration(
          color: Constants.secondry, borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: const EdgeInsets.all(8),
        width: size.width - 80,
        decoration: BoxDecoration(
            color: Constants.textLight,
            borderRadius: BorderRadius.circular(10)),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          _driver(),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _buildRowOfseats(1, 2, 3, 4, size),
                _buildRowOfseats(5, 6, 7, 8, size),
                _buildRowOfseats(9, 10, 11, 12, size),
                _buildRowOfseats(13, 14, 15, 16, size),
                _buildRowOfseats(17, 18, 19, 20, size),
                _buildRowOfseats(21, 22, 23, 24, size),
                _buildRowOfseats(25, 26, 27, 28, size),
                _buildRowOfseats(29, 30, 31, 32, size),
                _buildRowOfseats(33, 34, 35, 36, size),
                _buildRowOfseats(37, 38, 39, 40, size),
              ],
            ),
          )
        ]),
      ),
    );
  }

  Widget _buildRowOfseats(num1, num2, num3, num4, size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            _eachSeat(num1, size),
            _eachSeat(num2, size),
          ],
        ),
        Row(
          children: [
            _eachSeat(num3, size),
            _eachSeat(num4, size),
          ],
        )
      ],
    );
  }

  //for each Seat
  Widget _eachSeat(seatNo, size) {
    return InkWell(
        onTap: () {
          setState(() {
            seatno = seatNo.toString();
            print(seatno);
            Constants.selected = true;
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Image.asset(
                "assets/images/seat.png",
                width: size.width / 8 * 1,
                color: Constants.soldout.contains(seatNo.toString())
                    ? Constants.error
                    : Constants.accentDark,
              ),
              Text(
                "$seatNo",
                style: TextStyle(
                    color: Constants.soldout.contains(seatNo.toString())
                        ? Constants.textLight
                        : Constants.textDark,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ));
  }

  Widget _driver() {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        color: Constants.accentDark,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(child: Text("Driver")),
    );
  }

  Widget _someInfo() {
    return Column(
      children: [
        Text(
          "Choose your seat",
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
          height: 15,
        ),
        Text(
          "${Constants.date} / ${Constants.time}",
          style: Constants.style(Constants.textLight, 14, FontWeight.w400),
        ),
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
