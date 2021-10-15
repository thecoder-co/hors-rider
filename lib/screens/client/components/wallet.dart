import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rider/constants.dart';
import 'package:rider/logic/apis/wallet_balance.dart';
import 'package:rider/screens/client/components/wallet_components/cards.dart';
import 'package:rider/screens/client/components/wallet_components/wallet_card.dart';
import 'package:simple_shadow/simple_shadow.dart';

class Wallet extends StatefulWidget {
  const Wallet({
    Key? key,
  }) : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  late Future<String?> data;
  @override
  void initState() {
    super.initState();
    data = getWalletBalance();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      restorationId: 'asdfghjk',
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: size.height * 0.3,
            color: kPrimaryColor,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0, bottom: 20.0),
                child: Text(
                  'Hors Delivery Service',
                  style: GoogleFonts.getFont(
                    'Overlock',
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Cards(size: size),
              FutureBuilder(
                future: data,
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return WalletCard(
                      size: size,
                      walletBalance: snapshot.data,
                    );
                  } else if (snapshot.hasError) {
                    return WalletCard(
                      size: size,
                      walletBalance: '...',
                    );
                  }
                  return WalletCard(
                    size: size,
                    walletBalance: '...',
                  );
                },
              ),
              /*SimpleShadow(
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
                      width: (size.width * 0.95),
                      height: 250,
                    ),
                  ),
                ),
              ),*/
            ],
          ),
        ],
      ),
    );
  }
}
