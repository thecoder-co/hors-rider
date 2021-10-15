import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rider/constants.dart';
import 'package:simple_shadow/simple_shadow.dart';

class PartialEditCard extends StatefulWidget {
  final String? firstName;
  final ValueChanged<String>? chgFirstName;
  final String? lastName;
  final ValueChanged<String>? chgLastName;
  final String? gender;
  final ValueChanged<String>? chgGender;
  final String? maritalStatus;
  final ValueChanged<String>? chgMaritalStatus;
  final String? address;
  final ValueChanged<String>? chgAddress;
  const PartialEditCard({
    Key? key,
    required this.chgAddress,
    required this.chgLastName,
    required this.chgGender,
    required this.chgFirstName,
    required this.chgMaritalStatus,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.maritalStatus,
    required this.address,
  }) : super(key: key);

  @override
  _PartialEditCardState createState() => _PartialEditCardState();
}

class _PartialEditCardState extends State<PartialEditCard> {
  @override
  Widget build(BuildContext context) {
    String? _chosenValue;
    String? gender = widget.gender;
    String? maritalStatus = widget.maritalStatus;
    String? amount = '';
    return Padding(
      padding: const EdgeInsets.all(6.0),
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
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'First Name',
                      style: GoogleFonts.getFont(
                        'Overlock',
                        textStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    TextField(
                      style: TextStyle(
                        color: kDarkGreen,
                        fontSize: 18,
                      ),
                      onChanged: widget.chgFirstName,
                      onSubmitted: widget.chgFirstName,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        hintText: '${widget.firstName}',
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Last Name',
                      style: GoogleFonts.getFont(
                        'Overlock',
                        textStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    TextField(
                      style: TextStyle(
                        color: kDarkGreen,
                        fontSize: 18,
                      ),
                      onChanged: widget.chgLastName,
                      onSubmitted: widget.chgLastName,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        hintText: '${widget.lastName}',
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gender',
                      style: GoogleFonts.getFont(
                        'Overlock',
                        textStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    TextField(
                      style: TextStyle(
                        color: kDarkGreen,
                        fontSize: 18,
                      ),
                      onChanged: widget.chgGender,
                      onSubmitted: widget.chgGender,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        hintText: '${widget.gender}',
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Marital Status',
                      style: GoogleFonts.getFont(
                        'Overlock',
                        textStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    TextField(
                      style: TextStyle(
                        color: kDarkGreen,
                        fontSize: 18,
                      ),
                      onChanged: widget.chgMaritalStatus,
                      onSubmitted: widget.chgMaritalStatus,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        hintText: '${widget.maritalStatus}',
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Address',
                      style: GoogleFonts.getFont(
                        'Overlock',
                        textStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    TextField(
                      style: TextStyle(
                        color: kDarkGreen,
                        fontSize: 18,
                      ),
                      onChanged: widget.chgAddress,
                      onSubmitted: widget.chgAddress,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        hintText: '${widget.address}',
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditPhone extends StatelessWidget {
  final String? phone;
  final ValueChanged<String>? chgPhone;
  const EditPhone({
    Key? key,
    required this.phone,
    required this.chgPhone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
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
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Phone Number',
                  style: GoogleFonts.getFont(
                    'Overlock',
                    textStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ),
                TextField(
                  style: TextStyle(
                    color: kDarkGreen,
                    fontSize: 18,
                  ),
                  onChanged: (value) {},
                  onSubmitted: (value) {},
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    hintText: '${phone}',
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
