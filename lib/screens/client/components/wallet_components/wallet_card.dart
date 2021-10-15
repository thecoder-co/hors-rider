import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rider/constants.dart';
import 'package:rider/screens/client/components/wallet_components/deposit_history_page.dart';
import 'package:rider/screens/client/components/wallet_components/fund_wallet_page.dart';
import 'package:simple_shadow/simple_shadow.dart';

class WalletCard extends StatelessWidget {
  const WalletCard({
    Key? key,
    required this.size,
    required this.walletBalance,
  }) : super(key: key);

  final Size size;
  final String? walletBalance;

  @override
  Widget build(BuildContext context) {
    return SimpleShadow(
      opacity: 0.5, // Default: 0.5
      color: Colors.grey,
      offset: Offset(3, 3), // Default: Offset(2, 2)
      sigma: 7,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: size.width * 0.95,
            height: 100,
            child: Column(
              children: [
                Container(
                  height: 33,
                  color: kDarkGreen,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.account_balance_wallet_rounded,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Wallet',
                              style: GoogleFonts.getFont(
                                'Overlock',
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Text(
                          'NGN $walletBalance',
                          style: GoogleFonts.getFont(
                            'Overlock',
                            textStyle: TextStyle(
                              color: Color.fromRGBO(219, 254, 135, 1),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FundWalletPage(),
                                  ),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.add_circle_outline_rounded,
                                    color: kPrimaryColor,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text('Top Up',
                                      style: GoogleFonts.getFont(
                                        'Overlock',
                                        textStyle: TextStyle(
                                          color: kPrimaryColor,
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DepositHistoryPage(),
                                  ),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.autorenew_rounded,
                                    color: kPrimaryColor,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text('Transactions',
                                      style: GoogleFonts.getFont(
                                        'Overlock',
                                        textStyle: TextStyle(
                                          color: kPrimaryColor,
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
