import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rider/constants.dart';

import 'package:rider/domain/user.dart';
import 'package:rider/logic/apis/forgot_password.dart';
import 'package:rider/logic/apis/reset_password.dart';
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

class ResetPasswordPage extends StatefulWidget {
  final String? email;
  final String? token;
  const ResetPasswordPage({Key? key, required this.email, required this.token})
      : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  @override
  Widget build(BuildContext context) {
    String confirmationPassword = '';
    String password = '';
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "RESET PASSWORD",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),
              Image.asset(
                "assets/images/hors_logo.png",
                height: size.height * 0.35,
              ),
              SizedBox(height: size.height * 0.03),
              RoundedPasswordField(
                onChanged: (value) {
                  confirmationPassword = value;
                },
              ),
              RoundedPasswordField(
                onChanged: (value) {
                  password = value;
                },
              ),
              RoundedButton(
                text: "RESET",
                press: () async {
                  if (password == confirmationPassword) {
                    Future<ResetPassword> reset = resetPassword(
                      email: widget.email,
                      token: widget.token,
                      password: password,
                    );
                    reset.then((ResetPassword value) {
                      if (value.status!) {
                        final Future<Map<String, dynamic>> successfulMessage =
                            AuthProvider().login(widget.email!, password);
                        successfulMessage.then((response) {
                          if (response['status']) {
                            User user = response['user'];
                            UserProvider().setUser(user);
                            Navigator.pushReplacementNamed(context, '/home');
                            /*final Future<VerificationStatus> verified =
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
                        });*/
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
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Unable to reset passwords'),
                          ),
                        );
                      }
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Passwords do not match'),
                      ),
                    );
                  }
                  //Navigator.pushReplacementNamed(context, '/home');
                },
              ),
              SizedBox(height: size.height * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}
