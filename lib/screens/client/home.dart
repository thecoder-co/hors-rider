import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:rider/constants.dart';
import 'package:rider/logic/providers/app_bar_provider.dart';
import 'package:rider/screens/client/components/history.dart';
import 'package:rider/screens/client/components/profile.dart';
import 'package:rider/screens/client/components/wallet.dart';

class Client extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppIndex c = Get.put(AppIndex());
    return Obx(() => Scaffold(
          backgroundColor: Colors.white,
          body: IndexedStack(
            children: [History(), Wallet(), Profile()],
            index: c.selectedIndex.value,
          ),
          appBar: c.selectedIndex.value != 1
              ? AppBar(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  title: c.selectedIndex.value == 0
                      ? Text(
                          'History',
                          style: GoogleFonts.getFont(
                            'Overlock',
                            textStyle: TextStyle(
                              color: kDarkGreen,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : Text(
                          'My Profile',
                          style: GoogleFonts.getFont(
                            'Overlock',
                            textStyle: TextStyle(
                              color: kDarkGreen,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                )
              : null,
          bottomNavigationBar: PreferredSize(
            child: BottomNavigationBar(
              //type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              selectedLabelStyle: GoogleFonts.getFont(
                'Overlock',
              ),
              unselectedLabelStyle: GoogleFonts.getFont(
                'Overlock',
              ),
              selectedItemColor: Color.fromRGBO(14, 162, 207, 1),
              onTap: (index) {
                c.changeTabIndex(index);
              },
              currentIndex: c.selectedIndex.value,
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
        ));
  }
}
