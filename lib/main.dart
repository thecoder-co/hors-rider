import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rider/logic/providers/app_bar_provider.dart';
import 'package:rider/logic/providers/auth.dart';
import 'package:rider/logic/providers/user_provider.dart';
import 'package:rider/util/shared_preference.dart';
import 'package:rider/screens/login/login_screen.dart';
import 'package:rider/screens/signup/signup_screen.dart';
import 'package:rider/screens/client/home.dart';
import 'package:rider/screens/otp/otp.dart';

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
    Future<bool> isLoggedin() => UserPreferences().isLoggedIn();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
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
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.data == false) {
                    return LoginScreen();
                  } else {
                    UserPreferences().removeUser();
                  }
                  return Client();
              }
            }),
        routes: <String, WidgetBuilder>{
          //All available pages
          '/home': (BuildContext context) => ChangeNotifierProvider<AppIndex>(
                create: (context) => AppIndex(),
                child: Client(),
              ),
          '/login': (BuildContext context) => LoginScreen(),
          '/signup': (BuildContext context) => SignUpScreen(),
          '/otp': (BuildContext context) => OTP(),
        },
      ),
    );
  }
}
