import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rider/constants.dart';
import 'package:rider/screens/client/components/wallet_components/picklocation.dart';
import 'package:simple_shadow/simple_shadow.dart';

class Cards extends StatelessWidget {
  const Cards({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.95,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SimpleShadow(
            opacity: 0.5, // Default: 0.5
            color: Colors.grey,
            offset: Offset(3, 3), // Default: Offset(2, 2)
            sigma: 7,
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          LocationPicker() /*LocationPicker()*/,
                    ),
                  );
                },
                child: Container(
                  width: (size.width * 0.95) / 2 - 8,
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.local_shipping_outlined,
                        size: 80,
                        color: kDarkGreen,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: Text(
                          'Order Delivery',
                          style: GoogleFonts.getFont(
                            'Overlock',
                            textStyle: TextStyle(
                              fontSize: 16,
                              color: kDarkGreen,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Spacer(),
          SimpleShadow(
            opacity: 0.5, // Default: 0.5
            color: Colors.grey,
            offset: Offset(3, 3), // Default: Offset(2, 2)
            sigma: 7,
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: InkWell(
                onTap: () {},
                child: Container(
                  width: (size.width * 0.95) / 2 - 8,
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.money_rounded,
                        size: 80,
                        color: kDarkGreen,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: Text(
                          'Withdraw Money',
                          style: GoogleFonts.getFont(
                            'Overlock',
                            textStyle: TextStyle(
                              fontSize: 16,
                              color: kDarkGreen,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
