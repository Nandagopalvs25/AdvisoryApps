import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';

class UserModel {
  String? username;
  String? email;
  String? batch;
  String? admission_number;
  String? dob;
  String? phone_no;
  String? guardian;
  String? guardian_no;
  String? teacher_remarks;
  List<Activity>? activity;

  UserModel.fromReqBody(String body) {
    Map<String, dynamic> json = jsonDecode(body);
    username = json['username'];
    email = json['email'];
    batch = json['batch'];
    admission_number = json["admission_number"].toString();
    teacher_remarks = json['teacher_remarks'];
    batch = json['batch'];
    guardian = json['guardian'];
    guardian_no = json['guardian_no'];
    phone_no = json['phone_no'];
    final activityData = json['activity'] as List<dynamic>?;
     activity = activityData != null
        ? activityData.map((e) => Activity.fromJson(e)).toList()
        : <Activity>[];

    
  }

  Map<String, dynamic> toJson() => {
        'name': username,
        'batch': batch,
      };

  void printAttributes() {
    print("username: ${this.username}\n");
    print("batch:${this.batch}");
  }

  static List<UserModel> fromJsonList(dynamic jsonList) {
    final transactionDetailsList = <UserModel>[];
    if (jsonList == null) return transactionDetailsList;

    if (jsonList is List<dynamic>) {
      for (final json in jsonList) {
        transactionDetailsList.add(
          UserModel.fromReqBody(json),
        );
      }
      print(transactionDetailsList);
    }

    return transactionDetailsList;
  }
}

class Activity {
  Activity(
      {required this.name,
      required this.start_date,
      required this.end_date,
      required this.file_url});
  final String? name;
  final String? start_date;
  final String? end_date;
  final String? file_url;

  factory Activity.fromJson(Map<String, dynamic> data) {
    final name = data['name'] as String?;
    final start_date = data['start_date'] as String?;
    final end_date = data['end_date'] as String?;
    final file_url = data['file_url'] as String?;
    return Activity(
        name: name,
        start_date: start_date,
        end_date: end_date,
        file_url: file_url);
  }
}
