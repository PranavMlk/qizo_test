import 'package:flutter/material.dart';
import 'package:qizo_test/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';


late SharedPreferences sp;
void main() {
  runApp(MaterialApp(
    home: LoginScreen(),
  )
  );
}
