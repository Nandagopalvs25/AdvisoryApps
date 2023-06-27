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
