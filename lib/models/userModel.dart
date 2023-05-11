import 'dart:convert';

import 'package:flutter/material.dart';

class UserModel {
  String? username;
  String? batch;
  String? role;

  UserModel(
      {required String username, required String batch, required String role}) {
    this.username = username;
    this.batch = batch;
    this.role = role;
  }

  UserModel.fromReqBody(String body) {
    Map<String, dynamic> json = jsonDecode(body);
    username = json['username'];
    batch = json['batch'];
    role = json['role'];
  }

  void printAttributes() {
    print("username: ${this.username}\n");
    print("role: ${this.role}\n");
  }
}
