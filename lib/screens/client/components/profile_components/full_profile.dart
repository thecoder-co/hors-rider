import 'package:flutter/material.dart';
import 'package:rider/constants.dart';
import 'package:simple_shadow/simple_shadow.dart';

class FullProfile extends StatelessWidget {
  final String? image;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
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
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        title: Text(
          'Account Details',
          style: TextStyle(
            color: Color.fromRGBO(37, 41, 45, 1),
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
                onTap: () {},
                child: image != null
                    ? CircleAvatar(
                        child: Image.network(image!),
                        radius: 35,
                      )
                    : CircleAvatar(
                        backgroundColor: Color.fromRGBO(198, 239, 251, 1),
                        radius: 50,
                        child: Icon(
                          Icons.person_outline,
                          color: kPrimaryColor,
                          size: 60,
                        ),
                      ),
              ),
              SizedBox(
                height: 35,
              ),
              SimpleShadow(
                opacity: 0.5, // Default: 0.5
                color: Colors.grey,
                offset: Offset(3, 3), // Default: Offset(2, 2)
                sigma: 7,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    width: size.width * 0.95,
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
                                'First Name',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '$firstName',
                                style: TextStyle(
                                  color: Color.fromRGBO(37, 41, 45, 1),
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 15.0, right: 15.0),
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
                                'Last Name',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '$lastName',
                                style: TextStyle(
                                  color: Color.fromRGBO(37, 41, 45, 1),
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 15.0, right: 15.0),
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
                                'E-mail',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '$email',
                                style: TextStyle(
                                  color: Color.fromRGBO(37, 41, 45, 1),
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 15.0, right: 15.0),
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
                                'Phone Number',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '$phoneNumber',
                                style: TextStyle(
                                  color: Color.fromRGBO(37, 41, 45, 1),
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 15.0, right: 15.0),
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
                                'Gender',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '$gender',
                                style: TextStyle(
                                  color: Color.fromRGBO(37, 41, 45, 1),
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 15.0, right: 15.0),
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
                                'Marital Status',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '$maritalStatus',
                                style: TextStyle(
                                  color: Color.fromRGBO(37, 41, 45, 1),
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 15.0, right: 15.0),
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
                                'Address',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '$address',
                                style: TextStyle(
                                  color: Color.fromRGBO(37, 41, 45, 1),
                                  fontSize: 18,
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
        ),
      ),
    );
  }
}
