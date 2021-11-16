import 'package:flutter/material.dart';
import 'home_page.dart';
import 'home_page_logado.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'add_usuario.dart';
import '/models/usuario.dart';
import '/services/response/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomForm extends StatefulWidget {
  const CustomForm({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

//enum LoginStatus { notSignIn, signIn }

class _HomePageState extends State<CustomForm> {
  // LoginStatus _loginStatus = LoginStatus.notSignIn;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late String _usuario, _senha;

  bool _isObscure = true;
  // bool _isLoading = false;

  // late LoginResponse _response;

  //late BuildContext _ctx;

  // void _submit() {
  //   final form = _formKey.currentState;

  //   if (form!.validate()) {
  //     setState(() {
  //       _isLoading = true;
  //       form.save();
  //       _response.doLogin(_usuario, _senha);
  //     });
  //   }
  // }

  // var value;
  // getPref() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   setState(() {
  //     value = preferences.getInt("value");

  //     _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
  //   });
  // }

  // signOut() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   setState(() {
  //     preferences.setInt("value", 0);
  //     preferences.commit();
  //     _loginStatus = LoginStatus.notSignIn;
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   getPref();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
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
                              MaterialPageRoute(
                                  builder: (context) => AddUsuario()),
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
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          //_submit();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePageUsuario(
                                      usuario: _usuario,
                                    )),
                          );
                        }
                      },
                    ),
                  ],
                ))));
  }
}
