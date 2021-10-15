import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rider/constants.dart';
import 'package:rider/screens/client/components/profile_components/edit_profile_page.dart';
import 'package:rider/screens/client/components/profile_components/full_profile_card.dart';
import 'package:rider/screens/client/components/profile_components/profile_picture_page.dart';
import 'package:rider/util/app_url.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:image_picker/image_picker.dart';

class FullProfile extends StatefulWidget {
  final String? image;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? address;
  final String? gender;
  final String? maritalStatus;
  final String? email;
  final String? walletBalance;
  final String? accountStatus;
  const FullProfile({
    Key? key,
    this.image,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.address,
    this.gender,
    this.maritalStatus,
    this.walletBalance,
    this.accountStatus,
  }) : super(key: key);

  @override
  _FullProfileState createState() => _FullProfileState();
}

class _FullProfileState extends State<FullProfile> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Account Details',
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
          child: Column(
            children: [
              SizedBox(
                height: 35,
              ),
              InkWell(
                onTap: () async {
                  Future imageFrom = showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
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
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(
                                      context,
                                      'gallery',
                                    );
                                  },
                                  child: Container(
                                    width: (size.width * 0.95) / 2 - 8,
                                    height: 200,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(
                                          Icons.camera_alt,
                                          size: 80,
                                          color: kDarkGreen,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 15.0, bottom: 15.0),
                                          child: Text(
                                            'Gallery',
                                            style: GoogleFonts.getFont(
                                              'Overlock',
                                              textStyle: TextStyle(
                                                fontSize: 16,
                                                color: kDarkGreen,
                                                fontWeight: FontWeight.w900,
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
                              offset: Offset(3, 3), // Default: Offset(2, 2)
                              sigma: 7,
                              child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(
                                      context,
                                      'camera',
                                    );
                                  },
                                  child: Container(
                                    width: (size.width * 0.95) / 2 - 8,
                                    height: 200,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(
                                          Icons.collections,
                                          size: 80,
                                          color: kDarkGreen,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 15.0, bottom: 15.0),
                                          child: Text(
                                            'Camera',
                                            style: GoogleFonts.getFont(
                                              'Overlock',
                                              textStyle: TextStyle(
                                                fontSize: 16,
                                                color: kDarkGreen,
                                                fontWeight: FontWeight.w900,
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
                        );
                      });
                  imageFrom.then((value) async {
                    if (value == 'gallery') {
                      print('gallery');
                    } else if (value == 'camera') {
                      print('camera');
                    }
                    final ImagePicker _picker = ImagePicker();
                    // Pick an image
                    final XFile? image = await _picker.pickImage(
                        source: value == 'gallery'
                            ? ImageSource.gallery
                            : ImageSource.camera);
                    if (image != null) {
                      dynamic imageBytes = await image.readAsBytes();
                      String? path = image.path;
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProfilePicturePage(
                            image: imageBytes,
                            path: path,
                          ),
                        ),
                      );
                    }
                  }).onError((error, stackTrace) {
                    return null;
                  });
                },
                child: widget.image != null
                    ? Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              AppUrl.baseURL + widget.image!,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Icon(
                            Icons.add_a_photo,
                            color: kPrimaryColor,
                          ),
                        ],
                      )
                    : Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            backgroundColor: Color.fromRGBO(198, 239, 251, 1),
                            radius: 50,
                            child: Icon(
                              Icons.person_outline,
                              color: kPrimaryColor,
                              size: 60,
                            ),
                          ),
                          Icon(
                            Icons.add_a_photo_rounded,
                            color: kPrimaryColor,
                          ),
                        ],
                      ),
              ),
              SizedBox(
                height: 35,
              ),
              FullProfileCard(
                size: size,
                firstName: widget.firstName,
                lastName: widget.lastName,
                email: widget.email,
                phone: widget.phone,
                gender: widget.gender,
                maritalStatus: widget.maritalStatus,
                address: widget.address,
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Column(
                    children: [
                      Divider(
                        height: 1,
                        color: kPrimaryColor,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => EditProfile(
                                address: widget.address,
                                email: widget.email,
                                firstName: widget.firstName,
                                gender: widget.gender,
                                image: widget.image,
                                lastName: widget.lastName,
                                maritalStatus: widget.maritalStatus,
                                phone: widget.phone,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          child: Text(
                            'Edit',
                            style: GoogleFonts.getFont(
                              'Overlock',
                              textStyle: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        height: 1,
                        color: kPrimaryColor,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
