import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rider/constants.dart';
import 'package:rider/logic/apis/get_booking_details.dart';
import 'package:rider/screens/client/components/profile_components/edit_profile_page.dart';
import 'package:rider/screens/client/components/profile_components/full_profile_card.dart';
import 'package:rider/screens/client/components/profile_components/profile_picture_page.dart';
import 'package:rider/util/app_url.dart';
import 'package:simple_shadow/simple_shadow.dart';

class HistoryDetails extends StatefulWidget {
  final String? bookingId;

  const HistoryDetails({
    Key? key,
    this.bookingId,
  }) : super(key: key);

  @override
  _HistoryDetailsState createState() => _HistoryDetailsState();
}

class _HistoryDetailsState extends State<HistoryDetails> {
  late Future<BookingDetails> data;
  @override
  void initState() {
    // TODO: implement initState
    data = getBookingsDetails(bookingId: widget.bookingId);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Booking Details',
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
      body: SingleChildScrollView(
        child: Center(
          child: FutureBuilder(
            future: data,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                BookingDetails _data = snapshot.data;
                return Column(
                  children: [
                    Text(
                        "I want to add that picture first, the main page is under"),
                  ],
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
