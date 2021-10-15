import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rider/constants.dart';
import 'package:simple_shadow/simple_shadow.dart';

class WithdrawHistoryCard extends StatelessWidget {
  final String? accountName;
  final String? status;
  final String? amount;
  const WithdrawHistoryCard({
    Key? key,
    @required this.amount,
    @required this.accountName,
    @required this.status,
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
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(10),
              height: 80,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.credit_card,
                      size: 50,
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
                              text: 'Reference id: ',
                              style: GoogleFonts.getFont(
                                'Overlock',
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: kDarkGreen,
                                ),
                              ),
                            ),
                            TextSpan(
                              text: accountName!,
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
                              text: 'Amount: ',
                              style: GoogleFonts.getFont(
                                'Overlock',
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: kDarkGreen,
                                ),
                              ),
                            ),
                            TextSpan(
                              text: amount!,
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
                      Text(
                        status!,
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
