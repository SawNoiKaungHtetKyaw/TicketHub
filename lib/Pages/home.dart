import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:intl/intl.dart';
import 'package:ticket_hub/Pages/sign_in.dart';
import 'package:ticket_hub/Pages/sign_up.dart';

import '../Constants.dart';
import 'about.dart';
import 'calender.dart';
import 'contant_us.dart';
import 'departure_time.dart';
import 'departure_time_airplane.dart';
import 'departure_time_train.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

var _groupValue = "Bus";
List<String> _type = ["Bus", "Airplane", "Train"];
int _stackIndex = 1;
bool selectedFrom = false, selectedTo = false, selectedDate = false;
String errorFrom = "", errorTo = "", errorDate = "";

class _HomeState extends State<Home> {
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
                height: size.height / 5 * 1.6,
                color: Constants.primary,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    _buildAppBar(),
                    _buildWelcomeText(),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height / 5 * 1.3,
                    ),
                    _buildSearchTrip(size)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Constants.primary,
          selectedItemColor: Constants.textLight,
          unselectedItemColor: Constants.secondry,
          selectedIconTheme: IconThemeData(color: Constants.textLight),
          elevation: 100,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.info,
                ),
                label: "About"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.people), label: "Contant Us"),
          ],
          currentIndex: _stackIndex,
          onTap: (index) {
            setState(() {
              _stackIndex = index;
            });
            if (index == 0) {
              setState(() {
                _stackIndex = 1;
              });
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => About()));
            }
            if (index == 2) {
              setState(() {
                _stackIndex = 1;
              });
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ContantUs()));
            }
          }),
    );
  }

  Widget _buildSearchTrip(size) {
    return Container(
      width: size.width - 30,
      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 5),
      decoration: BoxDecoration(
          color: Constants.textLight, borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 5,
          ),
          Text(
            "Serach Trip",
            textAlign: TextAlign.center,
            style: Constants.style(Constants.primary, 18, FontWeight.bold),
          ),
          SizedBox(
            height: 15,
          ),
          _buildSelect(size, "From", Icons.send, true, selectedFrom, errorFrom),
          _buildSelect(
              size, "To", Icons.location_on, false, selectedTo, errorTo),
          _buildDate(size, "Date", Icons.edit_calendar_rounded, errorDate,
              selectedDate),
          _selectType(),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(20),
                  primary: Color.fromARGB(255, 37, 80, 235)),
              onPressed: () {
                //Validate Select To City
                if (Constants.fromCity == "Select City") {
                  print(Constants.fromCity);
                  setState(() {
                    selectedFrom = true;
                    errorFrom =
                        "Please select! Which city do you want to go from?";
                  });
                } else if (Constants.fromCity == Constants.toCity) {
                  setState(() {
                    selectedFrom = true;
                    selectedTo = true;
                    errorFrom = "Not allow same selected city!";
                    errorTo = "Not allow same selected city!";
                  });
                } else {
                  setState(() {
                    selectedFrom = false;
                  });
                }

                //Validate Select To City
                if (Constants.toCity == "Select City") {
                  setState(() {
                    selectedTo = true;
                    errorTo = "Please select! Which city do you want to go to?";
                  });
                } else if (Constants.fromCity == Constants.toCity) {
                  setState(() {
                    selectedTo = true;
                    errorTo = "Not allow same selected city!";
                  });
                } else {
                  setState(() {
                    selectedTo = false;
                  });
                }

                final DateTime now = DateTime.now();

                if (Constants.date == "Select Date") {
                  setState(() {
                    selectedDate = true;
                    errorDate = "Please select date!";
                  });
                } else if (Constants.selectedDay!.day < now.day &&
                    Constants.selectedDay!.month <= now.month) {
                  setState(() {
                    selectedDate = true;
                    errorDate = "Select Date is Less than Date of now!";
                  });
                } else {
                  setState(() {
                    selectedDate = false;
                  });
                }

                if (selectedFrom == false &&
                    selectedTo == false &&
                    selectedDate == false) {
                  if (Constants.type == "Bus") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DepartureTime()));
                  } else if (Constants.type == "Airplane") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DepartureTimeAirplane()));
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DepartureTimeTrain()));
                  }
                }
              },
              child: Text(
                "Search Now",
                style: TextStyle(color: Constants.textLight, fontSize: 20),
              )),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  Widget _selectType() {
    return Container(
      height: 80,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Constants.accent, borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Type",
            style: TextStyle(color: Constants.hint, fontSize: 16),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              RadioGroup<String>.builder(
                activeColor: Constants.primary,
                direction: Axis.horizontal,
                groupValue: _groupValue,
                horizontalAlignment: MainAxisAlignment.spaceAround,
                onChanged: (value) => setState(() {
                  _groupValue = value!;
                  Constants.type = value;
                }),
                items: _type,
                textStyle: TextStyle(fontSize: 15, color: Constants.textDark),
                itemBuilder: (item) => RadioButtonBuilder(
                  item,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDate(size, fromto, icon, text, selected) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 80,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Constants.accent, borderRadius: BorderRadius.circular(5)),
          child: Row(
            children: [
              Container(
                width: 65,
                height: 70,
                decoration: BoxDecoration(
                    color: Constants.textLight,
                    border: Border.all(color: Constants.secondry),
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      color: Constants.primary,
                      size: 35,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    fromto,
                    style: TextStyle(color: Constants.hint, fontSize: 16),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CalenderPage())),
                    child: Container(
                      width: size.width / 3.5 * 2.15,
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      decoration: BoxDecoration(
                        color: Constants.textLight,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                Constants.date,
                                style: TextStyle(
                                    color: Constants.textDark, fontSize: 13),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CalenderPage())),
                                child: Icon(
                                  Icons.arrow_forward,
                                  size: 18,
                                  color: Constants.primary,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          selected
              ? Text(
                  text,
                  style:
                      Constants.style(Constants.error, 12, FontWeight.normal),
                )
              : Text('')
        ])
      ],
    );
  }

  Widget _buildSelect(size, fromto, icon, check, selected, text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 80,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Constants.accent, borderRadius: BorderRadius.circular(5)),
          child: Row(
            children: [
              Container(
                width: 65,
                height: 70,
                decoration: BoxDecoration(
                    color: Constants.textLight,
                    border: Border.all(color: Constants.secondry),
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      color: Constants.primary,
                      size: 35,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    fromto,
                    style: TextStyle(color: Constants.hint, fontSize: 16),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  _dropDownBtn(size, check),
                ],
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            selected
                ? Text(
                    text,
                    style:
                        Constants.style(Constants.error, 12, FontWeight.normal),
                  )
                : Text('')
          ],
        )
      ],
    );
  }

  Widget _dropDownBtn(size, check) {
    return Container(
      width: size.width / 3.5 * 2.15,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Constants.textLight,
        borderRadius: const BorderRadius.all(
            Radius.circular(5) //         <--- border radius here
            ),
      ),
      child: Center(
        child: DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton<String>(
              isDense: true,
              value: check ? Constants.fromCity : Constants.toCity,
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
                  check
                      ? Constants.fromCity = newValue!
                      : Constants.toCity = newValue!;
                });
              },
              items: Constants.cities
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

  //Welcom Text
  Widget _buildWelcomeText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AnimatedTextKit(
          totalRepeatCount: 1,
          repeatForever: false,
          animatedTexts: [
            TyperAnimatedText("Welcome!\nTicket Hub\nTicket Sale Service",
                speed: const Duration(milliseconds: 100),
                textAlign: TextAlign.start,
                textStyle:
                    Constants.style(Constants.textLight, 20, FontWeight.bold))
          ],
        ),
        Row(
          children: [
            Image.asset(
              "assets/images/homebg.png",
              width: 130,
            ),
            SizedBox(
              width: 10,
            )
          ],
        )
      ],
    );
  }

  //For App Bar
  Widget _buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          "assets/images/logo.png",
          color: Constants.textLight,
          width: 80,
          height: 80,
        ),
        Row(
          children: [
            InkWell(
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SignIn())),
                child: _buildSigninSignup("SignIn")),
            InkWell(
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SignUp())),
                child: _buildSigninSignup("SignUp")),
          ],
        )
      ],
    );
  }

  //For the SignIn & SignUp Buttons
  Widget _buildSigninSignup(text) {
    return Container(
      width: 60,
      height: 25,
      decoration: BoxDecoration(
        border: Border.all(color: Constants.textLight),
      ),
      child: Center(
          child: Text(
        text,
        style: TextStyle(color: Constants.textLight, fontSize: 14),
      )),
    );
  }
}
