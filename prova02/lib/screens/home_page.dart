import 'package:flutter/material.dart';
import 'login.dart';

class AppLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.pink),
      home: const CustomForm(),
    ); 
  }
}