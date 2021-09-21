import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rider/domain/user.dart';
import 'package:rider/logic/providers/auth.dart';
import 'package:rider/logic/providers/user_provider.dart';
import 'package:rider/screens/login/components/background.dart';
import 'package:rider/components/already_have_an_account_acheck.dart';
import 'package:rider/components/rounded_button.dart';
import 'package:rider/components/rounded_input_field.dart';
import 'package:rider/components/rounded_password_field.dart';
import 'package:rider/util/validators.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    Size size = MediaQuery.of(context).size;
    String? surname = '';
    String? firstName = '';
    String? email = '';
    String? phoneNumber = '';
    String? address = '';
    String? deviceName = '';
    String? password = '';
    String? passwordConfirmation = '';
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            Image.asset(
              "assets/images/hors_logo.png",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              hintText: "Firstname",
              onChanged: (value) {
                firstName = value;
              },
            ),
            RoundedInputField(
              hintText: "Surname",
              onChanged: (value) {
                surname = value;
              },
            ),
            RoundedInputField(
              hintText: "Email",
              icon: Icons.email,
              onChanged: (value) {
                email = value;
              },
            ),
            RoundedInputField(
              hintText: "Phone Number",
              icon: Icons.phone,
              onChanged: (value) {
                phoneNumber = value;
              },
            ),
            RoundedInputField(
              hintText: "Address",
              icon: Icons.map,
              onChanged: (value) {
                address = value;
              },
            ),
            RoundedPasswordField(
              text: 'Password',
              onChanged: (value) {
                password = value;
              },
            ),
            RoundedPasswordField(
              text: 'Password Confirmation',
              onChanged: (value) {
                passwordConfirmation = value;
              },
            ),
            RoundedButton(
              text: "SIGNUP",
              press: () async {
                String? val = validateEmail(email!);
                if (val == null) {
                  final Future<Map<String, dynamic>> successfulMessage =
                      auth.register(
                    address: address,
                    email: email,
                    firstName: firstName,
                    password: password,
                    passwordConfirmation: passwordConfirmation,
                    phoneNumber: phoneNumber,
                    surname: surname,
                  );
                  successfulMessage.then((response) {
                    if (response['status']) {
                      User user = response['user'];
                      Provider.of<UserProvider>(context, listen: false)
                          .setUser(user);
                      Navigator.pushReplacementNamed(context, '/home');
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
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/login', (Route<dynamic> route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
