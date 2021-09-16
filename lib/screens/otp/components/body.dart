import 'package:flutter/material.dart';
import 'package:otp_text_field/style.dart';
import 'package:rider/constants.dart';
import 'package:rider/screens/otp/otp.dart';
import 'package:rider/screens/otp/components/background.dart';
import 'package:rider/components/rounded_button.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/otp_field_style.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: size.height * 0.03),
            Text(
              "Verify Your OTP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.3),
            OTPTextField(
              obscureText: true,
              length: 4,
              width: MediaQuery.of(context).size.width * 0.9,
              fieldWidth: 60,
              style: TextStyle(fontSize: 17),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              otpFieldStyle: OtpFieldStyle(
                backgroundColor: kPrimaryLightColor,
                borderColor: Colors.white,
              ),
              outlineBorderRadius: 0,
              fieldStyle: FieldStyle.box,
              onCompleted: (pin) {
                print("Completed: " + pin);
              },
            ),
            SizedBox(height: size.height * 0.2),
            RoundedButton(
              text: "VERIFY",
              press: () {},
            ),
            SizedBox(height: size.height * 0.03),
            FlatButton(
              onPressed: () {},
              child: Text('resend otp... 0:59'),
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
