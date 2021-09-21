import 'package:flutter/material.dart';
import 'package:rider/screens/client/components/profile_components/account_tile.dart';

class Wallet extends StatelessWidget {
  const Wallet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('Wallet')],
      ),
    );
  }
}
