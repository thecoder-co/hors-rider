import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pagination_view/pagination_view.dart';
import 'package:rider/constants.dart';
import 'package:rider/logic/apis/deposit_history.dart';
import 'package:rider/logic/apis/withdrawal_history.dart';
import 'package:rider/screens/client/components/wallet_components/deposit_history_card.dart';
import 'package:rider/screens/client/components/wallet_components/withdraw_history_card.dart';

class DepositHistoryPage extends StatefulWidget {
  const DepositHistoryPage({
    Key? key,
  }) : super(key: key);

  @override
  _DepositHistoryPageState createState() => _DepositHistoryPageState();
}

class _DepositHistoryPageState extends State<DepositHistoryPage> {
  late Future<DepositHistory> depositData;
  late Future<WithdrawalHistory> withdrawData;
  @override
  void initState() {
    super.initState();
    depositData = getDepositHistory();
    withdrawData = getWithdrawHistory();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          bottom: const TabBar(
            indicatorColor: kPrimaryColor,
            enableFeedback: false,
            labelColor: kDarkGreen,
            tabs: [
              Tab(
                icon: Icon(Icons.credit_card_rounded),
                text: 'Deposit',
              ),
              Tab(
                icon: Icon(Icons.credit_card_rounded),
                text: 'Withdrawal',
              ),
            ],
          ),
          backgroundColor: Colors.white,
          title: Text(
            'Transaction History',
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
        body: TabBarView(
          children: [
            FutureBuilder(
              future: depositData,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.data!.total! != 0) {
                    DepositHistory _data = snapshot.data;
                    return ListView.builder(
                      itemCount: _data.data!.deposits!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return DepositHistoryCard(
                          refId: _data.data!.deposits![index].refId,
                          amount: _data.data!.deposits![index].amount,
                          status: _data.data!.deposits![index].status,
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 200,
                            child: Image.asset(
                              'assets/images/hors_logo.png',
                            ),
                          ),
                          Text(
                            'No deposits yet',
                            style: GoogleFonts.getFont(
                              'Overlock',
                              textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kDarkGreen,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
            FutureBuilder(
              future: withdrawData,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.data!.length != 0) {
                    WithdrawalHistory _data = snapshot.data;
                    return ListView.builder(
                      itemCount: _data.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return WithdrawHistoryCard(
                          accountName: _data.data![index].accountName,
                          amount: _data.data![index].amount,
                          status: _data.data![index].status,
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 200,
                            child: Image.asset(
                              'assets/images/hors_logo.png',
                            ),
                          ),
                          Text(
                            'No withdrawals yet',
                            style: GoogleFonts.getFont(
                              'Overlock',
                              textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kDarkGreen,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }
}
