import 'package:flutter/material.dart';
import 'package:rider/constants.dart';
import 'package:rider/screens/client/components/profile_components/full_profile.dart';
import 'package:simple_shadow/simple_shadow.dart';

class AccountTile extends StatelessWidget {
  final String? name;
  final String? email;
  final String? number;
  final String? image;

  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
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
    this.phoneNumber,
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
                    firstName: 'Idunnuoluwa',
                    accountStatus: accountStatus,
                    address: address,
                    email: email,
                    gender: gender,
                    image: image,
                    lastName: lastName,
                    maritalStatus: maritalStatus,
                    phoneNumber: phoneNumber,
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
                            ? CircleAvatar(
                                child: Image.network(image!),
                                radius: 35,
                              )
                            : CircleAvatar(
                                backgroundColor:
                                    Color.fromRGBO(198, 239, 251, 1),
                                radius: 35,
                                child: Icon(
                                  Icons.person_outline,
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
                          Text(
                            '$name',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '$number',
                            style: TextStyle(
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '$email',
                            style: TextStyle(
                              color: Colors.grey[700],
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
