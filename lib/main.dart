import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rider/loading.dart' as load;
import 'package:rider/logic/auth_state.dart';
import 'package:rider/screens/login/login_screen.dart';
import 'package:rider/screens/signup/signup_screen.dart';
import 'package:rider/screens/client/home.dart';
import 'package:authentication_provider/authentication_controller.dart';
import 'package:authentication_provider/authentication_state.dart' as AuthState;
import 'package:authentication_provider/authentication_provider.dart';
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
  late AuthenticationController controller;

  @override
  void initState() {
    super.initState();
    controller = AuthenticationController<AuthModel>(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthenticationProvider(
          controller: controller,
          builder: (context) {
            var state = AuthenticationProvider.of<AuthModel>(context)?.state;
            if (state is AuthState.Loading) {
              return load.Loading();
            } else if (state is AuthState.Unauthenticated) {
              return LoginScreen();
            } else if (state is AuthState.Authenticated<AuthModel>) {
              return Client();
            }
            Future.delayed(Duration(seconds: 1), () {
              controller.initialize();
            });
            return Scaffold(
              appBar: AppBar(
                title: const Text('Uninitialized'),
              ),
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }),
      routes: <String, WidgetBuilder>{
        //All available pages
        '/home': (BuildContext context) => Client(),
        '/login': (BuildContext context) => LoginScreen(),
        '/signup': (BuildContext context) =>
            SignUpScreen(authController: controller),
        '/otp': (BuildContext context) => OTP(),
      },
    );
  }
}
