import 'package:flutter/material.dart';
import 'package:rider/screens/client/components/background.dart';
import 'package:rider/components/rounded_button.dart';
import 'package:rider/constants.dart';
import 'package:rider/screens/client/components/booking.dart';
import 'package:rider/screens/client/components/history.dart';
import 'package:rider/screens/client/components/wallet.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _widgetOptions = [Booking(), History(), Wallet()];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Hors'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings),
          )
        ],
      ),
      body: Background(
        child: SingleChildScrollView(
          child: Center(
            child: _widgetOptions[_selectedIndex],
          ),
        ),
      ),
      bottomNavigationBar: PreferredSize(
        child: BottomNavigationBar(
          backgroundColor: Colors.white.withOpacity(0.3),
          selectedItemColor: Colors.black,
          onTap: _onItemTapped,
          currentIndex: _selectedIndex,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Booking',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.wallet_membership),
              label: 'Wallet',
            ),
          ],
        ),
        preferredSize: Size(
          double.infinity,
          56.0,
        ),
      ),
    );
  }
}
