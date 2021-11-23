import 'package:prova02/models/usuario.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static const _databaseName = "usuario.db";
  static const _databaseVersion = 1;

  static const tabela = 'usuario.db';

  static const colunaId = 'id';
  static const colunaUsuario = 'usuario';
  static const colunaSenha = 'senha';

  static Database? _database;
  
  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  DatabaseHelper.internal();

  // abrir o banco
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // criar tabela
  Future _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE $tabela IF NOT EXISTS(
      $colunaId INTEGER PRIMARY KEY AUTOINCREMENT,
      $colunaUsuario TEXT NOT NULL,
      $colunaSenha TEXT NOT NULL
    )
    ''');
    print("Tabela criada");
  }

  // CRUD

  // insere
  Future<int> saveUser(Usuario usuario) async {
    Database? db = await _instance.database;
    print(usuario);
    int res = await db!
        .insert(tabela, {'usuario': usuario.usuario, 'senha': usuario.senha});
    List<Map> list = await db.rawQuery('SELECT * FROM Usuario');
    print(list);
    return res;
  }

  // atualiza
  Future<int> updateUser(Usuario usuario) async {
    Database? db = await _instance.database;
    print(usuario);
    int id = usuario.toMap()['id'];
    int res = await db!.update(tabela, usuario.toMap(),
        where: '$colunaId = ?', whereArgs: [id]);
    List<Map> list = await db.rawQuery('SELECT * FROM Usuario');
    print(list);
    return res;
  }

  // deleta
  Future<int> deleteUser(int id) async {
    Database? db = await _instance.database;
    print(id);
    int res = await db!.delete(tabela, where: '$colunaId = ?', whereArgs: [id]);
    List<Map> list = await db.rawQuery('SELECT * FROM Usuario');
    print(list);
    return res;
  }

  // login
  Future<Usuario?> getLogin(String usuario, String senha) async {
    Database? db = await _instance.database;
    var res = await db!.rawQuery(
        "SELECT * FROM usuario WHERE usuario = '$usuario' AND senha = '$senha'");

    if (res.isNotEmpty) {
      return Usuario.fromMap(res.first);
    }

    return null;
  }

  // listar
  Future<List<Usuario>?> getAllUsers() async {
    Database? db = await _instance.database;
    var res = await db!.query("usuario");

    List<Usuario>? list =
        res.isNotEmpty ? res.map((c) => Usuario.fromMap(c)).toList() : null;
    return list;
  }
}
