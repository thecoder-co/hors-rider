import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rider/constants.dart';
import 'package:rider/logic/get_profile.dart';
import 'package:rider/screens/client/components/profile_components/account_tile.dart';
import 'package:rider/screens/client/components/profile_components/profile_card.dart';
import 'package:rider/logic/providers/auth.dart';
import 'package:rider/logic/providers/user_provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late Future<ProfileData> data;
  @override
  void initState() {
    super.initState();
    data = APIs().getProfileDetails();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: data,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data.data;
          return SingleChildScrollView(
            child: Center(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 10),
                      AccountTile(
                        email: data.email,
                        name: '${data.firstName} ${data.surname}',
                        number: data.phone,
                        accountStatus: data.accountStatus,
                        address: data.address,
                        firstName: data.firstName,
                        gender: data.gender,
                        image: data.profilePhoto,
                        lastName: data.surname,
                        maritalStatus: data.maritalStatus,
                        phoneNumber: data.phone,
                        walletBalance: data.walletBalance,
                      ),
                      SizedBox(height: 10),
                      ProfileCard(),
                      Image.asset(
                        "assets/images/hors_logo.png",
                        height: size.height * 0.29,
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: size.height - 112,
                    ),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Divider(
                                height: 1,
                              ),
                              InkWell(
                                onTap: () {
                                  auth.logout();
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, '/login', (_) => false);
                                },
                                child: Container(
                                  height: 50,
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Log Out',
                                    style: TextStyle(
                                        color: kPrimaryColor, fontSize: 15),
                                  ),
                                ),
                              ),
                              Divider(
                                height: 1,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('${snapshot.error}'),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
