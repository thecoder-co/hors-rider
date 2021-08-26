import 'package:flutter/material.dart';
import 'package:rider/screens/Login/login_screen.dart';
import 'package:rider/screens/Signup/signup_screen.dart';
import 'package:rider/screens/Welcome/components/background.dart';
import 'package:rider/components/rounded_button.dart';
import 'package:rider/constants.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "WELCOME",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.05),
            SvgPicture.asset(
              "assets/icons/chat.svg",
              height: size.height * 0.45,
            ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "LOGIN",
              press: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/login', (Route<dynamic> route) => false);
              },
            ),
            RoundedButton(
              text: "SIGN UP",
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/signup', (Route<dynamic> route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
