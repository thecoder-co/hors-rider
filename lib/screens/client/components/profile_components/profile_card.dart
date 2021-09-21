import 'package:flutter/material.dart';
import 'package:rider/constants.dart';
import 'package:simple_shadow/simple_shadow.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key}) : super(key: key);

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
                    Icons.mail_outline,
                    color: kPrimaryColor,
                  ),
                  title: Text(
                    'Messages',
                    style: TextStyle(
                      color: Colors.grey[700],
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
                    Icons.money_rounded,
                    color: kPrimaryColor,
                  ),
                  title: Text(
                    'Fund',
                    style: TextStyle(
                      color: Colors.grey[700],
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
                height: 60,
                alignment: Alignment.center,
                child: ListTile(
                  onTap: () {},
                  leading: Icon(
                    Icons.help_outline,
                    color: kPrimaryColor,
                  ),
                  title: Text(
                    'Help',
                    style: TextStyle(
                      color: Colors.grey[700],
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
                    Icons.info_outline,
                    color: kPrimaryColor,
                  ),
                  title: Text(
                    'About',
                    style: TextStyle(
                      color: Colors.grey[700],
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
    );
  }
}
