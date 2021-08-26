import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rider/loading.dart';
import 'package:rider/logic/auth_state.dart';
import 'package:rider/screens/Login/login_screen.dart';
import 'package:rider/screens/Signup/signup_screen.dart';
import 'package:rider/screens/Welcome/welcome_screen.dart';
import 'package:rider/screens/logged_in/home.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      routes: <String, WidgetBuilder>{
        //All available pages
        '/home': (BuildContext context) => HomeScreen(),
        '/login': (BuildContext context) => SignUpScreen(),
        '/signup': (BuildContext context) => LoginScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthModel>(
      builder: (context, auth, child) {
        return FutureBuilder(
          future: auth.isLoggedIn,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == true) {
                return HomeScreen();
              } else {
                return WelcomeScreen();
              }
            } else {
              return Loading();
            }
          },
        );
      },
    );
  }
}
