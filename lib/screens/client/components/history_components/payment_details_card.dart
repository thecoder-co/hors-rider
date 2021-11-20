import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rider/components/rounded_button.dart';
import 'package:rider/constants.dart';
import 'package:rider/logic/apis/cancel_booking.dart';
import 'package:simple_shadow/simple_shadow.dart';

class PaymentDetailscard extends StatelessWidget {
  final String? serviceFee;
  final String? paymentStatus;
  final String? paymentmethod;
  final String? distance;
  final String? bookingStatus;
  final String? weight;
  final String? bookingId;

  const PaymentDetailscard({
    Key? key,
    required this.serviceFee,
    required this.paymentmethod,
    required this.distance,
    required this.weight,
    required this.bookingStatus,
    required this.bookingId,
    required this.paymentStatus,
  }) : super(key: key);

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
        child: Container(
          width: Get.width * 0.95,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                height: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Service Fee',
                      style: GoogleFonts.getFont(
                        'Overlock',
                        textStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SelectableText(
                      serviceFee!,
                      style: GoogleFonts.getFont(
                        'Overlock',
                        textStyle: TextStyle(
                          color: kDarkGreen,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Divider(
                  height: 1,
                  color: Colors.grey[400],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                height: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Payment Status',
                      style: GoogleFonts.getFont(
                        'Overlock',
                        textStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SelectableText(
                      paymentStatus!,
                      style: GoogleFonts.getFont(
                        'Overlock',
                        textStyle: TextStyle(
                          color: kDarkGreen,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Divider(
                  height: 1,
                  color: Colors.grey[400],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                height: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Booking Status',
                      style: GoogleFonts.getFont(
                        'Overlock',
                        textStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: bookingStatus!,
                            style: GoogleFonts.getFont(
                              'Overlock',
                              textStyle: TextStyle(
                                color: bookingStatus! == 'In review'
                                    ? Colors.yellow[800]
                                    : bookingStatus! == 'Approved'
                                        ? Colors.blue
                                        : bookingStatus! == 'on delivery'
                                            ? Colors.blue[800]
                                            : bookingStatus! == 'Completed'
                                                ? Colors.green[700]
                                                : Colors.red,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Divider(
                  height: 1,
                  color: Colors.grey[400],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                height: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Payment Method',
                      style: GoogleFonts.getFont(
                        'Overlock',
                        textStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      paymentmethod!,
                      style: GoogleFonts.getFont(
                        'Overlock',
                        textStyle: TextStyle(
                          color: kDarkGreen,
                          fontSize: 18,
                        ),
                      ),
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Divider(
                  height: 1,
                  color: Colors.grey[400],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                height: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Distance',
                      style: GoogleFonts.getFont(
                        'Overlock',
                        textStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${double.parse(distance!) / 1000} kilometres',
                      style: GoogleFonts.getFont(
                        'Overlock',
                        textStyle: TextStyle(
                          color: kDarkGreen,
                          fontSize: 18,
                        ),
                      ),
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Divider(
                  height: 1,
                  color: Colors.grey[400],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                height: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Weight',
                      style: GoogleFonts.getFont(
                        'Overlock',
                        textStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      weight!,
                      style: GoogleFonts.getFont(
                        'Overlock',
                        textStyle: TextStyle(
                          color: kDarkGreen,
                          fontSize: 18,
                        ),
                      ),
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    )
                  ],
                ),
              ),
              bookingStatus == 'In review'
                  ? RoundedButton(
                      text: 'Cancel Delivery',
                      color: Colors.red,
                      press: () async {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    'Are you sure you want to cancel?',
                                    style: GoogleFonts.getFont(
                                      'Overlock',
                                      textStyle: TextStyle(
                                        fontSize: 16,
                                        color: kDarkGreen,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      SimpleShadow(
                                        opacity: 0.5,
                                        color: Colors.grey,
                                        offset: Offset(3, 3),
                                        sigma: 7,
                                        child: Card(
                                          elevation: 0,
                                          color: Colors.red,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              cancelBooking(
                                                  bookingId: bookingId);
                                              Get.back();
                                            },
                                            child: Container(
                                              width: (Get.width * 0.95) / 2 - 8,
                                              height: 150,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Icon(
                                                    Icons.cancel_rounded,
                                                    size: 80,
                                                    color: kDarkGreen,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 15.0,
                                                            bottom: 15.0),
                                                    child: Text(
                                                      'Cancel Delivery',
                                                      style:
                                                          GoogleFonts.getFont(
                                                        'Overlock',
                                                        textStyle: TextStyle(
                                                          fontSize: 16,
                                                          color: kDarkGreen,
                                                          fontWeight:
                                                              FontWeight.w900,
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
                                      SimpleShadow(
                                        opacity: 0.5, // Default: 0.5
                                        color: Colors.grey,
                                        offset: Offset(
                                            3, 3), // Default: Offset(2, 2)
                                        sigma: 7,
                                        child: Card(
                                          elevation: 0,
                                          color: Colors.green,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              Get.back();
                                            },
                                            child: Container(
                                              width: (Get.width * 0.95) / 2 - 8,
                                              height: 150,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Icon(
                                                    Icons.check_rounded,
                                                    size: 80,
                                                    color: kDarkGreen,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 15.0,
                                                            bottom: 15.0),
                                                    child: Text(
                                                      'Back',
                                                      style:
                                                          GoogleFonts.getFont(
                                                        'Overlock',
                                                        textStyle: TextStyle(
                                                          fontSize: 16,
                                                          color: kDarkGreen,
                                                          fontWeight:
                                                              FontWeight.w900,
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
                                ],
                              );
                            });
                      },
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
