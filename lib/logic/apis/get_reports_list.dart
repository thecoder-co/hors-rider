import 'package:http/http.dart' as http;
import 'package:rider/domain/user.dart';
import 'package:rider/util/app_url.dart';
import 'package:rider/util/shared_preference.dart';
import 'dart:convert';

Future<ClientReports> getFullReports() async {
  try {
    ClientReports data = await getReports();
    bool next = false;
    String? url;
    ClientReports? newData;
    if (data.data!.nextPageUrl != null) {
      next = true;
      url = data.data!.nextPageUrl;
    }

    while (next) {
      newData = await getReports(newurl: url);
      if (newData.data!.nextPageUrl != null) {
        next = true;
        url = newData.data!.nextPageUrl;
      } else {
        next = false;
      }

      data.data!.reports!.addAll(newData.data!.reports!);
    }
    return data;
  } catch (e) {
    throw Exception();
  }
}

Future<ClientReports> getReports({String? newurl}) async {
  Uri url = Uri.parse(newurl ?? AppUrl.getReportList);
  User user = await UserPreferences().getUser();
  String token = user.token!;

  http.Response response = await http.get(
    url,
    headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    },
  );
  if (response.statusCode == 200) {
    return clientReportsFromJson(response.body);
  } else {
    throw Exception('Unable to load data');
  }
}

ClientReports clientReportsFromJson(String str) =>
    ClientReports.fromJson(json.decode(str));

String clientReportsToJson(ClientReports data) => json.encode(data.toJson());

class ClientReports {
  ClientReports({
    this.status,
    this.code,
    this.message,
    this.data,
    this.timestamp,
  });

  bool? status;
  int? code;
  String? message;
  Data? data;
  int? timestamp;

  factory ClientReports.fromJson(Map<String, dynamic> json) => ClientReports(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "data": data!.toJson(),
        "timestamp": timestamp,
      };
}

class Data {
  Data({
    this.reports,
    this.currentPage,
    this.prevPageUrl,
    this.nextPageUrl,
    this.resultDescription,
    this.pageDescription,
    this.total,
    this.lastPage,
  });

  List<Report>? reports;
  int? currentPage;
  dynamic prevPageUrl;
  dynamic nextPageUrl;
  String? resultDescription;
  String? pageDescription;
  int? total;
  int? lastPage;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        reports:
            List<Report>.from(json["reports"].map((x) => Report.fromJson(x))),
        currentPage: json["current_page"],
        prevPageUrl: json["prev_page_url"],
        nextPageUrl: json["next_page_url"],
        resultDescription: json["result_description"],
        pageDescription: json["page_description"],
        total: json["total"],
        lastPage: json["last_page"],
      );

  Map<String, dynamic> toJson() => {
        "reports": List<dynamic>.from(reports!.map((x) => x.toJson())),
        "current_page": currentPage,
        "prev_page_url": prevPageUrl,
        "next_page_url": nextPageUrl,
        "result_description": resultDescription,
        "page_description": pageDescription,
        "total": total,
        "last_page": lastPage,
      };
}

class Report {
  Report({
    this.subject,
    this.body,
    this.date,
  });

  String? subject;
  String? body;
  String? date;

  factory Report.fromJson(Map<String, dynamic> json) => Report(
        subject: json["subject"],
        body: json["body"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "subject": subject,
        "body": body,
        "date": date,
      };
}
