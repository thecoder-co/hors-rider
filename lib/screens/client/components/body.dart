import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rider/logic/providers/app_bar_provider.dart';
import 'package:rider/screens/client/components/history.dart';
import 'package:rider/screens/client/components/profile.dart';
import 'package:rider/screens/client/components/wallet.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    var index = Provider.of<AppIndex>(context);
    return IndexedStack(
      children: [History(), Wallet(), Profile()],
      index: index.currentIndex,
    );
  }
}
