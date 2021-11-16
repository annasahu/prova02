import 'dart:html';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:prova02/models/usuario.dart';

import 'login.dart';

class AddUsuario extends StatefulWidget {
  const AddUsuario({Key? key}) : super(key: key);

  @override
  AddUsuarioState createState() => AddUsuarioState();
}

class AddUsuarioState extends State<AddUsuario> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late String _usuario, _senha;

  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Cadastrar usuário"),
          leading: Icon(Icons.person_rounded),
        ),
        body: Padding(
            padding: const EdgeInsets.all(100.0),
            //child: Form(
            child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // CAIXA PARA ENTRADA DE USUÁRIO
                    TextFormField(
                      autofocus: true,
                      style: TextStyle(color: Colors.pink[700], fontSize: 18),
                      decoration: const InputDecoration(
                        labelText: "Usuário",
                        icon: Icon(
                          Icons.person_add_alt_rounded,
                          size: 30,
                        ),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.text,
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Preencher campo"),
                        MinLengthValidator(4,
                            errorText:
                                "O campo necessita de pelo menos 4 dígitos"),
                        MaxLengthValidator(12,
                            errorText: "O campo deve ter no máximo 12 dígitos")
                      ]),
                      onSaved: (validacao) => _usuario = validacao!,
                    ),

                    SizedBox(height: 15),

                    // CAIXA PARA ENTRADA DE SENHA
                    TextFormField(
                      autofocus: true,
                      obscureText: _isObscure,
                      style: TextStyle(color: Colors.pink[700], fontSize: 18),
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        suffixIcon: IconButton(
                            icon: Icon(_isObscure
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            }),
                        icon: Icon(
                          Icons.password_rounded,
                          size: 30,
                        ),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.text,
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Preencher campo"),
                        MinLengthValidator(4,
                            errorText:
                                "O campo necessita de pelo menos 4 dígitos"),
                        MaxLengthValidator(12,
                            errorText: "O campo deve ter no máximo 12 dígitos")
                      ]),
                      onSaved: (validacao) => _senha = validacao!,
                    ),

                    SizedBox(height: 20),

                    //BOTÃO PARA SALVAR USUÁRIO
                    ElevatedButton.icon(
                      icon: Icon(Icons.add, color: Colors.white),
                      label: Text('Salvar'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.pinkAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          //_submit();
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                      'Usuário "$_usuario" adicionado com sucesso!'),
                                  actions: <Widget>[
                                    ElevatedButton.icon(
                                      icon: Icon(Icons.keyboard_return_rounded,
                                          color: Colors.white),
                                      label: Text('Voltar'),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.pinkAccent,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0)),
                                      ),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                          //_submit();
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const CustomForm()),
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                );
                              });
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => HomePageUsuario(
                          //             usuario: _usuario,
                          //           )),
                          // );
                        }
                      },
                    ),
                  ],
                ))));
  }
}
