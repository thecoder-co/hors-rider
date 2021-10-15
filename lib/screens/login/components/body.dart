import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rider/constants.dart';

import 'package:rider/domain/user.dart';
import 'package:rider/logic/apis/forgot_password.dart';
import 'package:rider/logic/apis/verification_status.dart';
import 'package:rider/logic/providers/auth.dart';
import 'package:rider/logic/providers/user_provider.dart';
import 'package:rider/screens/login/components/background.dart';
import 'package:rider/components/already_have_an_account_acheck.dart';
import 'package:rider/components/rounded_button.dart';
import 'package:rider/components/rounded_input_field.dart';
import 'package:rider/components/rounded_password_field.dart';
import 'package:rider/screens/login/components/forgot_password_otp.dart';
import 'package:rider/util/validators.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    String email = '';
    String password = '';
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            Image.asset(
              "assets/images/hors_logo.png",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {
                email = value;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                password = value;
              },
            ),
            RoundedButton(
              text: "LOGIN",
              press: () async {
                String? val = validateEmail(email);
                if (val == null) {
                  final Future<Map<String, dynamic>> successfulMessage =
                      AuthProvider().login(email, password);
                  successfulMessage.then((response) {
                    print(response);
                    if (response['status']) {
                      User user = response['user'];
                      UserProvider().setUser(user);
                      Navigator.pushReplacementNamed(context, '/home');
                      final Future<VerificationStatus> verified =
                          checkVerified();
                      verified.then((value) {
                        if (value.data!.phoneVerificationStatus == 0) {
                          if (value.data!.emailVerificationStatus == 0) {
                            Navigator.pushReplacementNamed(
                                context, '/phoneOtp');
                          } else {
                            //email otp
                          }
                        } else {}
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${response['message']}'),
                        ),
                      );
                      print('${response['message']}');
                    }
                  });
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('$val')));
                }
                //Navigator.pushReplacementNamed(context, '/home');
              },
            ),
            SizedBox(height: size.height * 0.03),
            TextButton(
              onPressed: () async {
                String? val = validateEmail(email);
                if (val == null) {
                  Future<ForgotPassword> forgotPasswordDetails =
                      forgotPassword(email: email);
                  forgotPasswordDetails.then((ForgotPassword value) {
                    if (value.status!) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ForgotPasswordOtp(
                            email: email,
                            token: value.data!.token,
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Unable to send OTP'),
                        ),
                      );
                    }
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$val'),
                    ),
                  );
                }
                //Navigator.pushReplacementNamed(context, '/home');
              },
              child: Text('Forgot Password'),
              style: ButtonStyle(
                  textStyle: MaterialStateProperty.all<TextStyle>(
                GoogleFonts.getFont(
                  'Overlock',
                  textStyle: TextStyle(color: kPrimaryColor),
                ),
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Divider(),
            ),
            AlreadyHaveAnAccountCheck(
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
