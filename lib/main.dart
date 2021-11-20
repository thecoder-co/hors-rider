import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rider/opening_page.dart';
import 'package:rider/util/shared_preference.dart';
import 'package:rider/screens/login/login_screen.dart';
import 'package:rider/screens/signup/signup_screen.dart';
import 'package:rider/screens/client/home.dart';
import 'package:rider/screens/phone_otp/otp.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
          future: UserPreferences().isLoggedIn(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              default:
                if (snapshot.hasError) {
                  return Text(
                    'Error: ${snapshot.error}',
                    style: GoogleFonts.getFont('Overlock'),
                  );
                } else if (snapshot.data == false) {
                  return OpeningPage();
                }
                return Client();
            }
          }),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => Client(),
        '/login': (BuildContext context) => LoginScreen(),
        '/signup': (BuildContext context) => SignUpScreen(),
        '/phoneOtp': (BuildContext context) => OTP(),
      },
    );
  }
}
