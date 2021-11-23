import 'dart:async';
import '/data/database_helper.dart';
import '/models/usuario.dart';


class LoginRequest {
  DatabaseHelper instance = DatabaseHelper();

 Future<Usuario?> getLogin(String usuario, String senha) {
    var result = instance.getLogin(usuario,senha);
    return result;
  }
}