import 'package:flutter/material.dart';
import 'package:otp_text_field/style.dart';
import 'package:rider/constants.dart';
import 'package:rider/logic/apis/send_otp.dart';
import 'package:rider/screens/phone_otp/components/background.dart';
import 'package:rider/components/rounded_button.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/otp_field_style.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late Future<SendOtp> sendOtp;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sendOtp = resendOtp();
  }

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
              "Verify Your Phone OTP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.3),
            FutureBuilder(
              future: sendOtp,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  SendOtp data = snapshot.data!;
                  if (data.status!) {
                    return Column(
                      children: [
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
                        ),
                      ],
                    );
                  } else {
                    Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
