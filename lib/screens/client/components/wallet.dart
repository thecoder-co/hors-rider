import 'package:flutter/material.dart';

class Wallet extends StatelessWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: FittedBox(
              child: Text('₦5000'),
              fit: BoxFit.fitWidth,
            ),
            width: MediaQuery.of(context).size.width * 0.65,
          )
        ],
      ),
    );
  }
}
