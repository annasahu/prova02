import 'dart:async';

import '/models/usuario.dart';
import '/data/CtrlQuery/login_ctr.dart';

class LoginRequest {
  LoginCtr con = LoginCtr();

 Future<Usuario?> getLogin(String usuario, String senha) {
    var result = con.getLogin(usuario,senha);
    return result;
  }
}