import 'package:flutter/material.dart';
import '/screens/home_page.dart';
import '/screens/login.dart';
import '/screens/add_usuario.dart';

void main() => runApp(HomeScreen());

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.pink),
      home: const CustomForm(),
    );
  }
}
  