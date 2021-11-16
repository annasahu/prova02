import 'package:flutter/material.dart';

class HomePageUsuario extends StatefulWidget {
  const HomePageUsuario({required this.usuario});
  final String usuario;

  @override
  HomePageUsuarioState createState() => HomePageUsuarioState();
}

class HomePageUsuarioState extends State<HomePageUsuario> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logado'),
      ),
      body: Center(
        child: Text(
          'Olá ${widget.usuario}!\n\nVocê está logado(a)',
          textAlign: TextAlign.center,
          style:TextStyle(
            color: Colors.pink[700],
            fontSize: 30,
          ),),
      ),
    );
  }
}
