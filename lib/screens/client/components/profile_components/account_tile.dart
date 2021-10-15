import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rider/constants.dart';
import 'package:rider/screens/client/components/profile_components/full_profile.dart';
import 'package:rider/util/app_url.dart';
import 'package:simple_shadow/simple_shadow.dart';

class AccountTile extends StatelessWidget {
  final String? name;
  final String? email;
  final String? number;
  final String? image;

  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? address;
  final String? gender;
  final String? maritalStatus;
  final String? walletBalance;
  final String? accountStatus;
  const AccountTile({
    Key? key,
    this.image,
    this.name,
    this.email,
    this.number,
    this.firstName,
    this.lastName,
    this.phone,
    this.address,
    this.gender,
    this.maritalStatus,
    this.walletBalance,
    this.accountStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FullProfile(
                    firstName: firstName,
                    accountStatus: accountStatus,
                    address: address,
                    email: email,
                    gender: gender,
                    image: image,
                    lastName: lastName,
                    maritalStatus: maritalStatus,
                    phone: phone,
                    walletBalance: walletBalance,
                  ),
                ),
              );
            },
            child: Container(
              color: Colors.white.withOpacity(0),
              padding: EdgeInsets.all(8),
              width: size.width * 0.95,
              height: 100,
              //color: Colors.blue,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: image != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  AppUrl.baseURL + image!,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : CircleAvatar(
                                backgroundColor:
                                    Color.fromRGBO(198, 239, 251, 1),
                                radius: 35,
                                child: Icon(
                                  Icons.person_outline_rounded,
                                  color: kPrimaryColor,
                                  size: 45,
                                ),
                              ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              '$name',
                              style: GoogleFonts.getFont(
                                'Overlock',
                                textStyle: TextStyle(
                                  fontSize: 18,
                                  color: kDarkGreen,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '$phone',
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
                          Text(
                            '$email',
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
      ),
    );
  }
}
