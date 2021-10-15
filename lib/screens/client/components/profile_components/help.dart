import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rider/constants.dart';
import 'package:simple_shadow/simple_shadow.dart';

class Help extends StatelessWidget {
  const Help({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Help',
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            SimpleShadow(
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
                  width: size.width * 0.95,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 60,
                        child: ListTile(
                          onTap: () {},
                          leading: Icon(
                            Icons.report_problem_outlined,
                            color: kPrimaryColor,
                          ),
                          title: Text(
                            'Report',
                            style: GoogleFonts.getFont(
                              'Overlock',
                              textStyle: TextStyle(
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 13,
                            color: Colors.grey,
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
                        alignment: Alignment.center,
                        height: 60,
                        child: ListTile(
                          onTap: () {},
                          leading: Icon(
                            Icons.contact_support_outlined,
                            color: kPrimaryColor,
                          ),
                          title: Text(
                            'Contact Us',
                            style: GoogleFonts.getFont(
                              'Overlock',
                              textStyle: TextStyle(
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
