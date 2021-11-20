import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rider/components/rounded_button.dart';
import 'package:rider/screens/login/components/background.dart';
import 'package:rider/screens/login/login_screen.dart';
import 'package:rider/screens/signup/signup_screen.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';

class OpeningPage extends StatefulWidget {
  OpeningPage({Key? key}) : super(key: key);

  @override
  _OpeningPageState createState() => _OpeningPageState();
}

class _OpeningPageState extends State<OpeningPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Column(
          children: [
            Spacer(),
            SizedBox(
              height: Get.height / 2 + 100,
              child: Swiper(
                itemCount: 3,
                control: SwiperControl(),
                itemBuilder: (context, index) {
                  return Container(
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: index == 0
                          ? [
                              Image.asset(
                                'assets/images/hors_logo.png',
                                height: 200,
                              ),
                              Text(
                                'Hors Delivery Service',
                                style: GoogleFonts.getFont(
                                  'Overlock',
                                  textStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ]
                          : index == 1
                              ? [
                                  Image.asset(
                                    'assets/images/delivery 1.png',
                                    height: 200,
                                  ),
                                  Text(
                                    'Let us handle your deliveries for you',
                                    style: GoogleFonts.getFont(
                                      'Overlock',
                                      textStyle: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                ]
                              : [
                                  Image.asset(
                                    'assets/images/delivery.png',
                                    height: 200,
                                  ),
                                  Text(
                                    'Your deliveries matter to us',
                                    style: GoogleFonts.getFont(
                                      'Overlock',
                                      textStyle: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                ],
                    ),
                  );
                },
              ),
            ),
            Spacer(),
            RoundedButton(
              text: 'Get Started',
              press: () => Get.offAll(() => LoginScreen()),
            ),
          ],
        ),
      ),
    );
  }
}
