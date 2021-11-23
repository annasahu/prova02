import 'package:prova02/data/database_helper.dart';

class Usuario {
  late int id;
  late String usuario;
  late String senha;

  Usuario(this.usuario, this.senha);

  Usuario.fromMap(Map<String,dynamic> map) {
    // id = map['id'];
    usuario = map['usuario'];
    senha = map['senha'];
  }

  Map<String, dynamic> toMap() {
    return {
      // DatabaseHelper.colunaId: id,
      DatabaseHelper.colunaUsuario: usuario,
      DatabaseHelper.colunaSenha: senha,
    };
  }
}
