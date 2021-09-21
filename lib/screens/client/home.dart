import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rider/logic/providers/app_bar_provider.dart';
import 'package:rider/screens/client/components/body.dart';

class Client extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _index = Provider.of<AppIndex>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Body(),
      appBar: _index.currentIndex == 1
          ? null
          : AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              title: _index.currentIndex == 0
                  ? Text(
                      'History',
                      style: TextStyle(
                        color: Color.fromRGBO(8, 9, 10, 1),
                      ),
                    )
                  : Text(
                      'My Profile',
                      style: TextStyle(
                        color: Color.fromRGBO(8, 9, 10, 1),
                      ),
                    ),
            ),
      bottomNavigationBar: PreferredSize(
        child: BottomNavigationBar(
          //type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,

          selectedItemColor: Color.fromRGBO(14, 162, 207, 1),
          onTap: (index) {
            var _index = context.read<AppIndex>();
            _index.changeIndex = index;
          },
          currentIndex: _index.currentIndex,
          elevation: 20,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.motorcycle),
              label: 'Hors',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
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
