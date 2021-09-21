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
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
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
                      auth.login(email, password);
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
