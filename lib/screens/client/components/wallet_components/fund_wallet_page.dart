import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rider/components/rounded_button.dart';
import 'package:rider/constants.dart';
import 'package:rider/logic/apis/fund_wallet.dart';
import 'package:rider/screens/client/components/wallet_components/open_fund_url.dart';
import 'package:simple_shadow/simple_shadow.dart';

class FundWalletPage extends StatefulWidget {
  @override
  State<FundWalletPage> createState() => _FundWalletPageState();
}

class _FundWalletPageState extends State<FundWalletPage> {
  @override
  Widget build(BuildContext context) {
    String? amount = '';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Fund Wallet',
          style: GoogleFonts.getFont(
            'Overlock',
            textStyle: TextStyle(
              color: kDarkGreen,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        iconTheme: IconThemeData(color: kPrimaryColor),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'PLEASE ENTER THE AMOUNT',
                  style: GoogleFonts.getFont(
                    'Overlock',
                    textStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: SimpleShadow(
              opacity: 0.5, // Default: 0.5
              color: Colors.grey,
              offset: Offset(3, 3), // Default: Offset(2, 2)
              sigma: 7,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'AMOUNT',
                        style: GoogleFonts.getFont(
                          'Overlock',
                          textStyle: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            'NGN',
                            style: GoogleFonts.getFont(
                              'Overlock',
                              textStyle: TextStyle(
                                color: kDarkGreen,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                color: kDarkGreen,
                                fontSize: 25,
                              ),
                              onChanged: (value) {
                                amount = value;
                              },
                              onSubmitted: (value) {
                                amount = value;
                              },
                              decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                hintText: 'e.g 40,000',
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Spacer(),
          RoundedButton(
            color: kPrimaryColor,
            text: 'PROCEED',
            textColor: Colors.white,
            press: () async {
              if (amount != '') {
                final Future<FundWallet> successfulMessage =
                    fundWallet(amount: amount);
                successfulMessage.then((response) {
                  if (response.status!) {
                    print(response.data);
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => FundUrl(
                            url: response.data!,
                          ),
                        ),
                        (Route<dynamic> route) => false);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '${response.message}',
                          style: GoogleFonts.getFont(
                            'Overlock',
                          ),
                        ),
                      ),
                    );
                    //print('${response['message']}');
                  }
                });
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Input an amount',
                      style: GoogleFonts.getFont(
                        'Overlock',
                      ),
                    ),
                  ),
                );
              }
            },
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
