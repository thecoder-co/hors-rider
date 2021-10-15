import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:rider/components/rounded_button.dart';
import 'package:rider/constants.dart';
import 'package:rider/logic/apis/verify_otp_for_password_reset.dart';
import 'package:rider/screens/login/components/background.dart';
import 'package:rider/screens/login/components/reset_password.dart';

class ForgotPasswordOtp extends StatefulWidget {
  final String? email;
  final String? token;
  ForgotPasswordOtp({
    Key? key,
    required this.email,
    required this.token,
  }) : super(key: key);

  @override
  _ForgotPasswordOtpState createState() => _ForgotPasswordOtpState();
}

class _ForgotPasswordOtpState extends State<ForgotPasswordOtp> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
          child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.03),
            Text(
              "Verify the OTP sent to your email",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.3),
            OTPTextField(
              onChanged: (value) {},
              obscureText: false,
              length: 6,
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
                Future<VerifyOtp> otpStatus =
                    verifyOtpForPasswordReset(otp: pin, email: widget.email);
                otpStatus.then((VerifyOtp value) {
                  if (value.status!) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ResetPasswordPage(
                          email: widget.email,
                          token: widget.token,
                        ),
                      ),
                    );
                  } else {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Unable to verify OTP'),
                      ),
                    );
                  }
                });
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
            ),
          ],
        ),
      )),
    );
  }
}
