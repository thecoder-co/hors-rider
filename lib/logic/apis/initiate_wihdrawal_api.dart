import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:rider/constants.dart';
import 'package:rider/domain/user.dart';
import 'package:rider/logic/apis/save_bank_account.dart';

import 'package:rider/screens/client/home.dart';
import 'package:rider/util/app_url.dart';
import 'package:rider/util/shared_preference.dart';
import 'dart:convert';

Future initiateWithdrawal({
  required String? bankCode,
  required String? accountNumber,
  required String? accountName,
  required String? bankName,
  required String? reciepientCode,
  required String? amount,
  required String? reason,
  required bool? saveAccount,
}) async {
  Uri url = Uri.parse(AppUrl.initiateWithdrawal);
  User user = await UserPreferences().getUser();
  String token = user.token!;
  Get.defaultDialog(
    content: CircularProgressIndicator(),
    radius: 10,
    title: 'Loading',
    titleStyle: GoogleFonts.getFont(
      'Overlock',
      textStyle: TextStyle(
        fontSize: 16,
        color: kDarkGreen,
        fontWeight: FontWeight.w900,
      ),
    ),
  );
  http.Response response = await http.post(
    url,
    headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    },
    body: json.encode(
      {
        'bank_code': bankCode,
        'account_number': accountNumber,
        'account_name': accountName,
        'bank_name': bankName,
        'receipient_code': reciepientCode,
        'amount': amount,
        'reason': reason,
      },
    ),
  );
  Get.back();
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    if (data['status']) {
      Get.offAll(() => Client());

      if (saveAccount!) {
        Get.defaultDialog(
          radius: 10,
          actions: [
            TextButton(
              child: Text('save'),
              onPressed: () {
                saveBankAccount(
                  bankCode: bankCode,
                  accountNumber: accountNumber,
                  bankName: bankName,
                  reciepientCode: reciepientCode,
                  accountName: accountName,
                );
                Get.back();
              },
            ),
            TextButton(
              child: Text('cancel'),
              onPressed: () {
                Get.back();
              },
            )
          ],
          title: 'Save Account',
          middleText: 'Do you want to save the account number?',
        );
      }
      Get.defaultDialog(
        content: Text(
          'Withdrawn Successfully',
          style: GoogleFonts.getFont(
            'Overlock',
            textStyle: TextStyle(
              fontSize: 16,
              color: kDarkGreen,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        radius: 10,
        title: 'Alert',
        titleStyle: GoogleFonts.getFont(
          'Overlock',
          textStyle: TextStyle(
            fontSize: 16,
            color: kDarkGreen,
            fontWeight: FontWeight.w900,
          ),
        ),
      );
    } else {
      Get.showSnackbar(
        GetBar(
          snackStyle: SnackStyle.GROUNDED,
          message: data['message'].toString(),
          duration: Duration(milliseconds: 3000),
        ),
      );
    }
  } else {
    Get.showSnackbar(
      GetBar(
        snackStyle: SnackStyle.GROUNDED,
        message: 'Unable to create withdrawal',
        duration: Duration(milliseconds: 3000),
      ),
    );
  }
}
