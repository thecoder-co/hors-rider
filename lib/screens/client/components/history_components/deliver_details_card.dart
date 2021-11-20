import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rider/components/rounded_button.dart';
import 'package:rider/constants.dart';
import 'package:rider/logic/apis/confirm_booking.dart';
import 'package:rider/logic/apis/get_booking_details.dart';
import 'package:rider/screens/client/components/history_components/rider_details.dart';
import 'package:rider/util/app_url.dart';
import 'package:simple_shadow/simple_shadow.dart';

class DeliverDetailsCard extends StatelessWidget {
  const DeliverDetailsCard({
    Key? key,
    required BookingDetails data,
  })  : _data = data,
        super(key: key);

  final BookingDetails _data;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _data.data!.deliverDetails!.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Deliver Details',
              style: GoogleFonts.getFont(
                'Overlock',
                textStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ),
            SimpleShadow(
              opacity: 0.5, // Default: 0.5
              color: Colors.grey,
              offset: Offset(3, 3), // Default: Offset(2, 2)
              sigma: 7,
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  width: Get.width * 0.95,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(
                            () => RiderDetailsPage(
                              riderId:
                                  _data.data!.deliverDetails![index].riderId,
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 20),
                          alignment: Alignment.centerLeft,
                          height: 130,
                          width: Get.width * 0.95,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: _data.data!.deliverDetails![index]
                                                .profilePhoto !=
                                            null
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              AppUrl.baseURL +
                                                  _data
                                                      .data!
                                                      .deliverDetails![index]
                                                      .profilePhoto!,
                                              fit: BoxFit.cover,
                                              height: 100,
                                            ),
                                          )
                                        : CircleAvatar(
                                            backgroundColor: Color.fromRGBO(
                                                198, 239, 251, 1),
                                            radius: 50,
                                            child: Icon(
                                              Icons.person_outline_rounded,
                                              color: kPrimaryColor,
                                              size: 60,
                                            ),
                                          ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SelectableText(
                                        '${_data.data!.deliverDetails![index].surname! + ' ' + _data.data!.deliverDetails![index].firstName!}',
                                        style: GoogleFonts.getFont(
                                          'Overlock',
                                          textStyle: TextStyle(
                                            fontSize: 18,
                                            color: kDarkGreen,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      SelectableText(
                                        '${_data.data!.deliverDetails![index].phoneNumber}',
                                        style: GoogleFonts.getFont(
                                          'Overlock',
                                          textStyle: TextStyle(
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      SelectableText(
                                        '${_data.data!.deliverDetails![index].email}',
                                        style: GoogleFonts.getFont(
                                          'Overlock',
                                          textStyle: TextStyle(
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.grey,
                                    size: 10,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ],
                          ),
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
                              'Delivery Status',
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
                              '${_data.data!.deliverDetails![index].jobStatus}',
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
                              'Motorcycle Brand',
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
                              '${_data.data!.deliverDetails![index].motocycleBrand}',
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
                              'Motorcycle Color',
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
                              '${_data.data!.deliverDetails![index].motocycleColor}',
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
                              'Motorcycle Model',
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
                              '${_data.data!.deliverDetails![index].motocycleModel}',
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
                              'Motorcycle License Number',
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
                              '${_data.data!.deliverDetails![index].motocycleLicenceNumber}',
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
                      _data.data!.deliverDetails![index].jobStatus ==
                                  'Accepted' ||
                              _data.data!.deliverDetails![index].jobStatus ==
                                  'Picked up' ||
                              _data.data!.deliverDetails![index].jobStatus ==
                                  'Delivered'
                          ? RoundedButton(
                              text: 'Confirm Delivery',
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
                                            'Are you sure you want to confirm?',
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
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      Get.back();
                                                    },
                                                    child: Container(
                                                      width:
                                                          (Get.width * 0.95) /
                                                                  2 -
                                                              8,
                                                      height: 150,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .cancel_rounded,
                                                            size: 80,
                                                            color: kDarkGreen,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 15.0,
                                                                    bottom:
                                                                        15.0),
                                                            child: Text(
                                                              'Back',
                                                              style: GoogleFonts
                                                                  .getFont(
                                                                'Overlock',
                                                                textStyle:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                  color:
                                                                      kDarkGreen,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900,
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
                                                offset: Offset(3,
                                                    3), // Default: Offset(2, 2)
                                                sigma: 7,
                                                child: Card(
                                                  elevation: 0,
                                                  color: Colors.green,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      confirmBooking(
                                                          jobId: _data
                                                              .data!
                                                              .deliverDetails![
                                                                  index]
                                                              .jobId
                                                              .toString());
                                                      Get.back();
                                                    },
                                                    child: Container(
                                                      width:
                                                          (Get.width * 0.95) /
                                                                  2 -
                                                              8,
                                                      height: 150,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Icon(
                                                            Icons.check_rounded,
                                                            size: 80,
                                                            color: kDarkGreen,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 15.0,
                                                                    bottom:
                                                                        15.0),
                                                            child: Text(
                                                              'Confirm Delivery',
                                                              style: GoogleFonts
                                                                  .getFont(
                                                                'Overlock',
                                                                textStyle:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                  color:
                                                                      kDarkGreen,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900,
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
            ),
          ],
        );
      },
    );
  }
}
