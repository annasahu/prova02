import 'package:prova02/models/usuario.dart';
import 'dart:async';
import 'package:prova02/data/database_helper.dart';

class LoginCtr {
  DatabaseHelper con = DatabaseHelper();

  // insere
  Future<int> salvaUsuario(Usuario usuario) async {
    var dbClient = await con.db;
    int res = await dbClient!.insert("Usuario", usuario.toMap());
    return res;
  }

  // deleta
  Future<int> deletaUsuario(Usuario usuario) async {
    var dbClient = await con.db;
    int res = await dbClient!.delete("Usuario");
    return res;
  }

  // dados de login
  Future<Usuario?> getLogin(String usuario, String senha) async {
    var dbClient = await con.db;
    var res = await dbClient!.rawQuery(
        "SELECT * FROM usuario WHERE usuario = '$usuario' and senha = '$usuario'");

    if (res.isNotEmpty) {
      return Usuario.fromMap(res.first);
    }

    return null;
  }

  // listar usuarios
  Future<List<Usuario>?> getAllUsuario() async {
    var dbClient = await con.db;
    var res = await dbClient!.query("usuario");

    List<Usuario>? list =
        res.isNotEmpty ? res.map((c) => Usuario.fromMap(c)).toList() : null;

    return list;
  }
}
