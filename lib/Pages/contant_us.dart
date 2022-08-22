import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../Constants.dart';
import 'home.dart';

class ContantUs extends StatefulWidget {
  const ContantUs({Key? key}) : super(key: key);

  @override
  State<ContantUs> createState() => _ContantUsState();
}

class _ContantUsState extends State<ContantUs> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: size.width,
                height: size.height / 5 * 1.6,
                color: Constants.primary,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Home())),
                          child: Icon(
                            Icons.arrow_back,
                            color: Constants.textLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        "Contant Us",
                        style: TextStyle(
                            color: Constants.textLight,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.facebook,
                                  size: 60,
                                  color: Constants.textLight,
                                ),
                                Icon(
                                  Icons.mail,
                                  size: 60,
                                  color: Constants.textLight,
                                ),
                                Icon(
                                  Icons.phone_in_talk,
                                  size: 50,
                                  color: Constants.primary,
                                  shadows: [
                                    BoxShadow(
                                        offset: Offset(-1, -1),
                                        color: Constants.textLight)
                                  ],
                                )
                              ],
                            ),
                          ),
                          Image.asset(
                            "assets/images/contant_us.png",
                            width: size.width - 80,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Any Question?',
                        style: Constants.style(
                            Constants.textDark, 20, FontWeight.bold),
                      ),
                      _inputbox("Username", "Type your username"),
                      _inputbox("Phone Number", "Type your phone"),
                      _inputbox("Email", "Type your email"),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Any Question?",
                              style: TextStyle(
                                  color: Constants.primary,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextField(
                              style: TextStyle(fontSize: 14),
                              cursorColor: Constants.primary,
                              maxLines: 5,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                hintText: "Text here",
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                        color: Constants.accentDark)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                        BorderSide(color: Constants.primary)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Company - Ticket Hub",
                                    style: Constants.style(
                                        Constants.hint, 14, FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputbox(text, hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(
                color: Constants.primary,
                fontSize: 15,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
            style: TextStyle(fontSize: 14),
            cursorColor: Constants.primary,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              hintText: hint,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Constants.accentDark)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Constants.primary)),
            ),
          ),
        ],
      ),
    );
  }
}
