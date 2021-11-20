import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:rider/constants.dart';
import 'package:rider/logic/apis/verification_status.dart';
import 'package:rider/logic/providers/app_bar_provider.dart';
import 'package:rider/screens/client/components/history.dart';
import 'package:rider/screens/client/components/profile.dart';
import 'package:rider/screens/client/components/wallet.dart';
import 'package:rider/screens/email_otp/otp.dart';
import 'package:rider/screens/phone_otp/otp.dart';

class Client extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<VerificationStatus> verified = checkVerified();
    verified.then(
      (value) async {
        if (value.data!.phoneVerificationStatus == 0 ||
            value.data!.emailVerificationStatus == 0) {
          if (value.data!.phoneVerificationStatus == 0) {
            Get.offAll(() => OTP());
          } else {
            Get.offAll(() => EmailOtp());
          }
        }
      },
    );
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
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : Text(
                          'My Profile',
                          style: GoogleFonts.getFont(
                            'Overlock',
                            textStyle: TextStyle(
                              color: kPrimaryColor,
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
              selectedItemColor: kPrimaryColor,
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
