import 'package:flutter/material.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final TextEditingController _controllerNum1 = TextEditingController();
  // final TextEditingController _controllerNum2 = TextEditingController();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink.shade300,
          title: Text("Login"),
          leading: Icon(Icons.person_rounded),
        ),
        body: Padding(
            padding: const EdgeInsets.all(100.0),
            child: Center(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // CAIXA PARA ENTRADA DE USUÁRIO
                TextField(
                  autofocus: true,
                  style: TextStyle(color: Colors.pink[700], fontSize: 18),
                  decoration: const InputDecoration(
                    labelText: "Usuário",
                    icon: Icon(
                      Icons.account_circle_outlined,
                      size: 30,
                    ),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                ),

                SizedBox(height: 15),
                
                // CAIXA PARA ENTRADA DE SENHA
                TextField(
                  autofocus: true,
                  obscureText: _isObscure,
                  style: TextStyle(color: Colors.pink[700], fontSize: 18),
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                            });
                          }
                        ),
                        icon: Icon(
                          Icons.lock_outline,
                          size: 30,
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),

                SizedBox(height: 20),

                //BOTÃO PARA LIMPAR CAMPOS
                ElevatedButton.icon(
                  icon: Icon(Icons.login, color: Colors.white),
                  label: Text('Logar'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.pinkAccent,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                  ),
                  onPressed: () {},
                ),
              ],
            )
          )
        )
      );
  }
}
