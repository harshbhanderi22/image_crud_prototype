import 'package:flutter/material.dart';

class UserModel {


  final String name;
  final String uid;
  final String email;
  final List<String> followers;

   UserModel(this.name, this.uid, this.email, this.followers);
}