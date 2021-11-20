import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timer_button/timer_button.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/style.dart';
import 'package:rider/constants.dart';
import 'package:rider/logic/apis/send_otp.dart';
import 'package:rider/logic/apis/verify_phone_otp.dart';
import 'package:rider/screens/phone_otp/components/background.dart';
import 'package:rider/components/rounded_button.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:rider/screens/phone_otp/otp.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late Future<SendOtp> sendOtp;
  @override
  void initState() {
    super.initState();
    sendOtp = resendOtp();
  }

  String? otp;
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            "Verify Your Phone OTP",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          FutureBuilder(
            future: sendOtp,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return SizedBox();
            },
          ),
          OTPTextField(
            onChanged: (value) {},
            obscureText: false,
            length: 4,
            width: MediaQuery.of(context).size.width * 0.9,
            fieldWidth: 35,
            style: TextStyle(fontSize: 17),
            textFieldAlignment: MainAxisAlignment.spaceAround,
            otpFieldStyle: OtpFieldStyle(
              backgroundColor: kPrimaryLightColor,
              borderColor: Colors.white,
            ),
            outlineBorderRadius: 10,
            fieldStyle: FieldStyle.box,
            onCompleted: (pin) {
              otp = pin;
            },
          ),
          //SizedBox(height: size.height * 0.2),
          RoundedButton(
            text: "VERIFY",
            press: () {
              if (otp != null) {
                verifyPhoneOtp(otp: otp);
              } else {
                Get.showSnackbar(
                  GetBar(
                    snackStyle: SnackStyle.GROUNDED,
                    message: 'Input the otp',
                    duration: Duration(milliseconds: 2000),
                  ),
                );
              }
            },
          ),
          TimerButton(
            label: "Send OTP Again",
            timeOutInSeconds: 120,
            buttonType: ButtonType.FlatButton,
            onPressed: () {
              resendOtp();
            },
            disabledColor: Colors.transparent,
            color: Colors.transparent,
            disabledTextStyle: GoogleFonts.getFont(
              'Overlock',
              textStyle: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            activeTextStyle: GoogleFonts.getFont(
              'Overlock',
              textStyle: TextStyle(
                color: kDarkGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
