import 'package:flutter/material.dart';
import 'home_page_logado.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'add_usuario.dart';
import '/models/usuario.dart';
import '/services/response/login_response.dart';

class CustomForm extends StatefulWidget {
  const CustomForm({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

enum LoginStatus { notSignIn, signIn }

class _HomePageState extends State<CustomForm> implements LoginCallBack {
  // LoginStatus _loginStatus = LoginStatus.notSignIn;

  final formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late String _usuario, _senha;

  bool _isObscure = true;
  bool _isLoading = false;

  late BuildContext _ctx;

  late LoginResponse _response;

  _LoginPageState() {
    _response = LoginResponse(this);
  }

  void _submit() {
    final form = formKey.currentState;

    if (form!.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        _response.doLogin(_usuario, _senha);
      });
    }
  }

  @override
  void onLoginError(String error) {
    print('erro');
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onLoginSuccess(Usuario usuario) async {
    print('logado');
    if (usuario.usuario == "") {
      print('erro');
    } else {
      print(usuario.toString());
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
          leading: Icon(Icons.person_rounded),
        ),
        body: Padding(
            padding: const EdgeInsets.all(100.0),
            //child: Form(
            child: Form(
                key: formKey,
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
                          Icons.account_circle_outlined,
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
                          Icons.lock_outline,
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

                    // ADICIONAR USUÁRIO
                    InkWell(
                      child: Text(
                        'Adicionar usuário',
                        textAlign: TextAlign.center,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddUsuario()),
                        );
                      },
                    ),

                    SizedBox(height: 20),

                    //BOTÃO PARA FAZER O LOGIN
                    ElevatedButton.icon(
                      icon: Icon(Icons.login, color: Colors.white),
                      label: Text('Logar'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.pinkAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          // SEM BD
                          if (_usuario == 'anna' && _senha == '1234') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePageUsuario(
                                        usuario: _usuario,
                                      )),
                            );
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title:
                                        Text('Usuário e/ou senha incorreto!'),
                                  );
                                });
                          };

                          // COM BD
                          // _submit();
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
