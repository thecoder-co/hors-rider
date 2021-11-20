import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rider/constants.dart';
import 'package:rider/logic/apis/get_client_bookings.dart';
import 'package:rider/screens/client/components/history_components/history_card.dart';

class History extends StatefulWidget {
  const History({
    Key? key,
  }) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  late Future<ClientBookings> data;
  @override
  void initState() {
    super.initState();
    data = getFullBookings();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: data,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          ClientBookings _data = snapshot.data;
          if (snapshot.data.data!.total! != 0) {
            return ListView.builder(
              controller: ScrollController(),
              itemCount: _data.data!.bookings!.length,
              itemBuilder: (BuildContext context, int index) {
                return HistoryCard(
                  bookingId: _data.data!.bookings![index].bookingId,
                  bookingNumber: _data.data!.bookings![index].bookingNumber,
                  date: _data.data!.bookings![index].date,
                  status: _data.data!.bookings![index].bookingStatus,
                );
              },
            );
          }
          if (snapshot.hasError) {
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 200,
                    child: Image.asset(
                      'assets/images/hors_logo.png',
                    ),
                  ),
                  Text(
                    'No orders yet',
                    style: GoogleFonts.getFont(
                      'Overlock',
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kDarkGreen,
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
