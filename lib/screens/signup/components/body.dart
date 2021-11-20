import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rider/components/text_field_container.dart';
import 'package:rider/constants.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';

import 'package:rider/domain/user.dart';
import 'package:rider/logic/providers/auth.dart';
import 'package:rider/logic/providers/user_provider.dart';
import 'package:rider/screens/client/components/profile_components/webviews.dart';
import 'package:rider/screens/login/components/background.dart';
import 'package:rider/components/already_have_an_account_acheck.dart';
import 'package:rider/components/rounded_button.dart';
import 'package:rider/components/rounded_input_field.dart';
import 'package:rider/components/rounded_password_field.dart';
import 'package:rider/util/app_url.dart';
import 'package:rider/util/validators.dart';
import 'package:get/get.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String? surname = '';
  String? firstName = '';
  String? email = '';
  String? phone = '';
  String? address;
  String? password = '';
  String? passwordConfirmation = '';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.05),
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
                phone = value;
              },
            ),
            InkWell(
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlacePicker(
                      apiKey: kgoogleApiKey,
                      initialPosition: LatLng(0, 0),
                      onPlacePicked: (result) {
                        setState(() {
                          address = result.formattedAddress!;
                        });
                        Navigator.pop(context);
                      },
                      useCurrentLocation: true,
                    ),
                  ),
                );
              },
              child: TextFieldContainer(
                child: Container(
                  height: 50,
                  child: Row(
                    children: [
                      Icon(
                        Icons.map_rounded,
                        color: kPrimaryColor,
                      ),
                      SizedBox(
                        width: 13,
                      ),
                      Expanded(
                        child: Text(
                          address ?? 'Address',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
                Get.defaultDialog(
                  title: 'Register',
                  radius: 10,
                  actions: [
                    TextButton(
                      child: Text('Register'),
                      onPressed: () {
                        String? val = validateEmail(email!);
                        Get.back();
                        if (val == null) {
                          final Future<Map<String, dynamic>> successfulMessage =
                              AuthProvider().register(
                            address: address!,
                            email: email,
                            firstName: firstName,
                            password: password,
                            passwordConfirmation: passwordConfirmation,
                            phone: phone,
                            surname: surname,
                          );
                          successfulMessage.then((response) {
                            if (response['status']) {
                              User user = response['user'];
                              UserProvider().setUser(user);
                              Get.offNamed('/home');
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${response['message']}'),
                                ),
                              );
                            }
                          });
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text('$val')));
                        }
                      },
                    ),
                    TextButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Get.back();
                      },
                    )
                  ],
                  content: Column(
                    children: [
                      Text(
                        'By registering, you accept our terms, conditions and privacy policy.',
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: InkWell(
                          onTap: () => Get.to(
                            WebViews(
                              name: 'Terms And Conditions',
                              url: AppUrl.baseURL + '/terms-and-conditions',
                            ),
                            fullscreenDialog: true,
                          ),
                          child: Container(
                            height: 50,
                            child: Row(
                              children: [
                                Text(
                                  'Terms and Conditions',
                                  style: TextStyle(color: kPrimaryDarkColor),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 10,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: InkWell(
                          onTap: () => Get.to(
                            WebViews(
                              name: 'Privacy Policy',
                              url: AppUrl.baseURL + '/privacy-policy',
                            ),
                            fullscreenDialog: true,
                          ),
                          child: Container(
                            height: 50,
                            child: Row(
                              children: [
                                Text(
                                  'Privacy Policy',
                                  style: TextStyle(color: kPrimaryDarkColor),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 10,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );

                //Navigator.pushReplacementNamed(context, '/home');
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Get.toNamed('/login');
              },
            ),
            SizedBox(height: size.height * 0.05),
          ],
        ),
      ),
    );
  }
}
