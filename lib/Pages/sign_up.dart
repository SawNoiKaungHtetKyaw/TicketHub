import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ticket_hub/Pages/sign_in.dart';

import '../Constants.dart';
import 'home.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

TextEditingController _controllerUsername = TextEditingController();
TextEditingController _controllerEmail = TextEditingController();
TextEditingController _controllerPassword = TextEditingController();
TextEditingController _controllerRePassword = TextEditingController();

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
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
                      InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignIn())),
                          child: Text(
                            "Sign In",
                            style: Constants.style(
                                Constants.textLight, 18, FontWeight.bold),
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sign Up",
                        style: Constants.style(
                            Constants.textLight, 40, FontWeight.bold),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Please Register",
                        style: Constants.style(
                            Constants.textLight, 14, FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          color: Constants.textLight),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(
                              height: 40,
                            ),
                            _input("Username", _controllerUsername),
                            SizedBox(
                              height: 10,
                            ),
                            _input("Email Or Phone", _controllerEmail),
                            SizedBox(
                              height: 10,
                            ),
                            _input("Password", _controllerPassword),
                            SizedBox(
                              height: 10,
                            ),
                            _input("Re-Password", _controllerRePassword),
                            SizedBox(
                              height: 15,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Constants.primary,
                                    padding: EdgeInsets.all(20),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30))),
                                onPressed: () {},
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                      color: Constants.textLight,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "Company - Ticket Hub",
                  style: Constants.style(Constants.hint, 14, FontWeight.w400),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _input(text, TextEditingController controller) {
    return TextFormField(
        cursorColor: Constants.primary,
        style: TextStyle(color: Constants.textDark, fontSize: 18),
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          labelText: text,
          labelStyle: TextStyle(color: Constants.hint),
          fillColor: Constants.accent,
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Constants.accentDark)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Constants.accentDark)),
        ));
  }
}
