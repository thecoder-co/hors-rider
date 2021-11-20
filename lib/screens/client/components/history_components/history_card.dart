import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rider/constants.dart';
import 'package:rider/screens/client/components/history_components/history_card_details.dart';
import 'package:simple_shadow/simple_shadow.dart';

class HistoryCard extends StatelessWidget {
  final String? bookingNumber;
  final int? bookingId;
  final String? status;
  final String? date;

  const HistoryCard({
    Key? key,
    @required this.status,
    @required this.bookingId,
    @required this.bookingNumber,
    @required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleShadow(
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HistoryDetails(
                    bookingId: bookingId.toString(),
                  ),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.all(10),
              height: 80,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.delivery_dining,
                      size: 50,
                      color: kPrimaryDarkColor,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Booking number: ',
                              style: GoogleFonts.getFont(
                                'Overlock',
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: kDarkGreen,
                                ),
                              ),
                            ),
                            TextSpan(
                              text: bookingNumber,
                              style: GoogleFonts.getFont(
                                'Overlock',
                                textStyle: TextStyle(
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                          ],
                        ),
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'status: ',
                              style: GoogleFonts.getFont(
                                'Overlock',
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: kDarkGreen,
                                ),
                              ),
                            ),
                            TextSpan(
                              text: status!,
                              style: GoogleFonts.getFont(
                                'Overlock',
                                textStyle: TextStyle(
                                  color: status == 'In review'
                                      ? Colors.yellow[800]
                                      : status == 'Approved'
                                          ? Colors.blue
                                          : status == 'on delivery'
                                              ? Colors.blue
                                              : status == 'Completed'
                                                  ? Colors.green[700]
                                                  : Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                      Text(
                        date!,
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
    );
  }
}
