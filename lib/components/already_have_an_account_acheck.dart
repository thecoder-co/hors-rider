import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rider/constants.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool? login;
  final Function? press;
  const AlreadyHaveAnAccountCheck({
    Key? key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login! ? "Don’t have an Account ? " : "Already have an Account ? ",
          style: GoogleFonts.getFont(
            'Overlock',
            textStyle: TextStyle(color: kPrimaryColor),
          ),
        ),
        InkWell(
          onTap: () {
            press!();
          },
          child: Text(
            login! ? "Sign Up" : "Sign In",
            style: GoogleFonts.getFont(
              'Overlock',
              textStyle: TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
      ],
    );
  }
}
