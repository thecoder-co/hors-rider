import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rider/constants.dart';
import 'package:rider/logic/apis/get_rider_details.dart';
import 'package:rider/util/app_url.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:simple_star_rating/simple_star_rating.dart';

class RiderDetailsPage extends StatelessWidget {
  final String? riderId;
  const RiderDetailsPage({
    Key? key,
    required this.riderId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Rider Details',
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
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: getRiderDetails(riderId: riderId!),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            RiderDetails _data = snapshot.data;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  Text(
                    'Rider profile',
                    style: GoogleFonts.getFont(
                      'Overlock',
                      textStyle: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Center(
                    child: SimpleShadow(
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
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: _data.data!.profilePhoto != null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                AppUrl.baseURL +
                                                    _data.data!.profilePhoto!,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SelectableText(
                                          '${_data.data!.surname! + ' ' + _data.data!.firstName!}',
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
                                          height: 5,
                                        ),
                                        InkWell(
                                          onLongPress: () async {
                                            var _url = Uri(
                                              scheme: 'tel',
                                              path:
                                                  '${_data.data!.phoneNumber}',
                                            );
                                            await canLaunch(_url.toString())
                                                ? await launch(_url.toString())
                                                : throw 'Could not launch $_url';
                                          },
                                          child: Text(
                                            '${_data.data!.phoneNumber}',
                                            style: GoogleFonts.getFont(
                                              'Overlock',
                                              textStyle: TextStyle(
                                                color: Colors.grey[700],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        SelectableText(
                                          '${_data.data!.email}',
                                          style: GoogleFonts.getFont(
                                            'Overlock',
                                            textStyle: TextStyle(
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        SelectableText(
                                          '${_data.data!.gender}',
                                          style: GoogleFonts.getFont(
                                            'Overlock',
                                            textStyle: TextStyle(
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        SelectableText(
                                          '${_data.data!.maritalStatus}',
                                          style: GoogleFonts.getFont(
                                            'Overlock',
                                            textStyle: TextStyle(
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Riding Details',
                    style: GoogleFonts.getFont(
                      'Overlock',
                      textStyle: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
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
                            Container(
                              padding: EdgeInsets.only(left: 20),
                              alignment: Alignment.centerLeft,
                              height: 60,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Total Jobs Completed',
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
                                    '${_data.data!.totalJobCompleted}',
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
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0),
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
                                    'Performance',
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
                                    '${_data.data!.performance}',
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
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0),
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
                                    'Ratings',
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
                                  Center(
                                    child: SimpleStarRating(
                                      allowHalfRating: true,
                                      starCount: 5,
                                      rating:
                                          double.tryParse(_data.data!.rating!)!,
                                      size: 32,
                                      isReadOnly: true,
                                      spacing: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0),
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
                                    'Total Reviews',
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
                                    '${_data.data!.totalReview}',
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
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0),
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
                                    'Trust Score',
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
                                    '${_data.data!.trustScore}',
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
                  )
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
