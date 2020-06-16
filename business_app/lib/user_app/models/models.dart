//When this file gets to big, split into multiple files.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModelData {
  User user;

  ModelData() {
    user = User();
  }
}

class User extends ChangeNotifier {
  String qcode;
  String name;
  String phoneNumber;
  String notes;
}

