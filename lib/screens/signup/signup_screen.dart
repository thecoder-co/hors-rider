import 'package:authentication_provider/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:rider/screens/signup/components/body.dart';

class SignUpScreen extends StatelessWidget {
  final AuthenticationController? authController;

  SignUpScreen({
    this.authController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
