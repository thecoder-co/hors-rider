import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rider/constants.dart';
import 'package:rider/logic/apis/finish_booking_api.dart';
import 'package:rider/logic/apis/process_booking.dart';
import 'package:rider/screens/client/components/wallet_components/open_fund_url.dart';
import 'package:rider/screens/client/home.dart';
import 'package:simple_shadow/simple_shadow.dart';

class FinishBookingPage extends StatefulWidget {
  final ProcessBooking? data;
  FinishBookingPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  _FinishBookingPageState createState() => _FinishBookingPageState();
}

class _FinishBookingPageState extends State<FinishBookingPage> {
  @override
  Widget build(BuildContext context) {
    ProcessBooking? data = widget.data!;
    print(processBookingToJson(data));
    return Scaffold(
      backgroundColor: Colors.white,
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
          onPressed: () => Navigator.of(context).pop(),
        ),
        iconTheme: IconThemeData(color: kPrimaryColor),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 10,
              top: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fee',
                  style: GoogleFonts.getFont(
                    'Overlock',
                    textStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    data.data!.serviceFee.toString(),
                    style: GoogleFonts.getFont(
                      'Overlock',
                      textStyle: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              'Finish Booking',
              style: GoogleFonts.getFont(
                'Overlock',
                textStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          data.data!.paymentWithCard!
              ? SimpleShadow(
                  opacity: 0.5, // Default: 0.5
                  color: Colors.grey,
                  offset: Offset(3, 3), // Default: Offset(2, 2)
                  sigma: 7,
                  child: Card(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    elevation: 0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () {
                          print(data.data!.bookingCode);
                          Future<FinishBooking> response = finishBooking(
                            paymentMethod: '1',
                            bookingCode: data.data!.bookingCode,
                          );
                          response.then((FinishBooking value) {
                            print(value);
                            print(value.data);
                            print(finishBookingToJson(value));
                            if (value.data != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return FundUrl(url: value.data!);
                                }),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(value.message!),
                                ),
                              );
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          height: 80,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Icon(
                                  Icons.credit_card_rounded,
                                  size: 50,
                                  color: kDarkGreen,
                                ),
                              ),
                              Text(
                                'Pay with card',
                                style: GoogleFonts.getFont(
                                  'Overlock',
                                  textStyle: TextStyle(
                                    fontSize: 18,
                                    color: kDarkGreen,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 13,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
              : SizedBox(),
          data.data!.paymentWithWallet!
              ? SimpleShadow(
                  opacity: 0.5, // Default: 0.5
                  color: Colors.grey,
                  offset: Offset(3, 3), // Default: Offset(2, 2)
                  sigma: 7,
                  child: Card(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    elevation: 0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () {
                          Future<FinishBooking> response = finishBooking(
                            paymentMethod: '0',
                            bookingCode: data.data!.bookingCode,
                          );
                          response.then((FinishBooking value) {
                            Navigator.pushAndRemoveUntil(context,
                                MaterialPageRoute(builder: (context) {
                              return Client();
                            }), (route) => false);
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Booking Successful')));
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          height: 80,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Icon(
                                  Icons.account_balance_wallet_rounded,
                                  size: 50,
                                  color: kDarkGreen,
                                ),
                              ),
                              Text(
                                'Pay with wallet',
                                style: GoogleFonts.getFont(
                                  'Overlock',
                                  textStyle: TextStyle(
                                    fontSize: 18,
                                    color: kDarkGreen,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 13,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
              : SizedBox(),
          data.data!.paymentAtDelivery!
              ? SimpleShadow(
                  opacity: 0.5, // Default: 0.5
                  color: Colors.grey,
                  offset: Offset(3, 3), // Default: Offset(2, 2)
                  sigma: 7,
                  child: Card(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    elevation: 0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () {
                          Future<FinishBooking> response = finishBooking(
                            paymentMethod: '2',
                            bookingCode: data.data!.bookingCode,
                          );
                          response.then((FinishBooking value) {
                            Navigator.pushAndRemoveUntil(context,
                                MaterialPageRoute(builder: (context) {
                              return Client();
                            }), (route) => false);
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Booking Successful')));
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          height: 80,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Icon(
                                  Icons.delivery_dining_rounded,
                                  size: 50,
                                  color: kDarkGreen,
                                ),
                              ),
                              Text(
                                'Pay on delivery',
                                style: GoogleFonts.getFont(
                                  'Overlock',
                                  textStyle: TextStyle(
                                    fontSize: 18,
                                    color: kDarkGreen,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 13,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
