import 'package:flutter/material.dart';
import 'home_page.dart';

class AppLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.pink),
      home: HomePage(),
    ); 
  }
}
