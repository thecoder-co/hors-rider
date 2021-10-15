import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:rider/constants.dart';

import 'package:rider/screens/client/home.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FundUrl extends StatefulWidget {
  final String? url;
  FundUrl({@required this.url});
  @override
  FundUrlState createState() => FundUrlState(url: url!);
}

class FundUrlState extends State<FundUrl> {
  final String? url;
  FundUrlState({this.url});
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Payment Gateway',
          style: GoogleFonts.getFont(
            'Overlock',
            textStyle: TextStyle(
              color: kDarkGreen,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => Client(),
              ),
              (Route<dynamic> route) => false),
        ),
        iconTheme: IconThemeData(color: kPrimaryColor),
      ),
      body: WebView(
        initialUrl: url!.replaceAll('\\', ''),
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
