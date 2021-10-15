import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:rider/constants.dart';
import 'package:rider/logic/apis/update_profile_picture.dart';

import 'package:rider/screens/client/home.dart';
import 'package:simple_shadow/simple_shadow.dart';

class ProfilePicturePage extends StatefulWidget {
  final dynamic image;
  final String? path;
  ProfilePicturePage({
    Key? key,
    @required this.image,
    @required this.path,
  }) : super(key: key);

  @override
  _ProfilePicturePageState createState() =>
      _ProfilePicturePageState(image: image, path: path);
}

class _ProfilePicturePageState extends State<ProfilePicturePage> {
  var image;
  final String? path;
  _ProfilePicturePageState({
    @required this.image,
    @required this.path,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SimpleShadow(
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
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.memory(
                          image,
                          height: 350,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Dismiss'),
                            style: TextButton.styleFrom(
                              textStyle: GoogleFonts.getFont(
                                'Overlock',
                                color: kPrimaryColor,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              AddProfilePhoto data =
                                  await updateProfilePicture(path: path);
                              if (data.status) {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) => Client(),
                                    ),
                                    (route) => false);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Unable to change profile picture',
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Text('Choose'),
                            style: TextButton.styleFrom(
                              textStyle: GoogleFonts.getFont(
                                'Overlock',
                                color: kPrimaryColor,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
