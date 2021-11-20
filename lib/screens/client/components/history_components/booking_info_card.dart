import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rider/constants.dart';
import 'package:simple_shadow/simple_shadow.dart';

class BookingDetailsCard extends StatelessWidget {
  final String? bookingId;
  final String? pickupAddress;
  final String? dropoffAddress;
  final String? packageDetails;
  final String? taskDescription;
  final String? date;
  final String? bookingStatus;
  final String? pickupName;
  final String? pickupContact;
  final String? dropoffName;
  final String? dropoffContact;
  const BookingDetailsCard({
    Key? key,
    required this.bookingId,
    required this.date,
    required this.dropoffAddress,
    required this.taskDescription,
    required this.pickupAddress,
    required this.packageDetails,
    required this.bookingStatus,
    required this.pickupName,
    required this.pickupContact,
    required this.dropoffName,
    required this.dropoffContact,
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
                      'Booking Number',
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
                      bookingId!,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pickup Address',
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
                      pickupAddress!,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dropoff Address',
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
                      dropoffAddress!,
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
                      'Pickup Name',
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
                      pickupName!,
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
                      'Pickup Contact',
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
                      pickupContact!,
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
                      'Delivery Name',
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
                      dropoffName!,
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
                      'Delivery Contact',
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
                      dropoffContact!,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Package Details',
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
                      packageDetails!,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Task Description',
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
                      taskDescription!,
                      style: GoogleFonts.getFont(
                        'Overlock',
                        textStyle: TextStyle(
                          color: kDarkGreen,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date',
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
                      date!,
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
            ],
          ),
        ),
      ),
    );
  }
}
