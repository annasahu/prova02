import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  // Avoid errors caused by flutter upgrade.
  // Importing 'package:flutter/widgets.dart' is required.
  WidgetsFlutterBinding.ensureInitialized();
  // Open the database and store the reference.
  final database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'usuario_database.db'),
    // When the database is first created, create a table to store dogs.
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        'CREATE TABLE usuarios(id INTEGER PRIMARY KEY, usuario TEXT, senha TEXT)',
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );

  // Define a function that inserts dogs into the database
  Future<void> insereUsuario(Usuario usuario) async {
    // Get a reference to the database.
    final db = await database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'usuarios',
      usuario.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the dogs from the dogs table.
  Future<List<Usuario>> usuarios() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('usuarios');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Usuario(
        id: maps[i]['id'],
        usuario: maps[i]['usuario'],
        senha: maps[i]['senha'],
      );
    });
  }

  Future<void> atualizaUsuario(Usuario usuario) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given Dog.
    await db.update(
      'usuarios',
      usuario.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [usuario.id],
    );
  }

  Future<void> deletaUsuario(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Dog from the database.
    await db.delete(
      'usuarios',
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  // Create a Dog and add it to the dogs table
  var fido = Usuario(
    id: 0,
    usuario: 'Anna',
    senha: '1234',
  );

  await insereUsuario(fido);

  // Now, use the method above to retrieve all the dogs.
  print(await usuarios()); // Prints a list that include Fido.

  // Update Fido's age and save it to the database.
  fido = Usuario(
    id: fido.id,
    usuario: fido.usuario,
    senha: fido.senha,
  );
  await atualizaUsuario(fido);

  // Print the updated results.
  print(await usuarios()); // Prints Fido with age 42.

  // Delete Fido from the database.
  //await deletaUsuario(fido.id);

  // Print the list of dogs (empty).
  print(await usuarios());
}

class Usuario {
  final int id;
  final String usuario;
  final String senha;

  Usuario({
    required this.id,
    required this.usuario,
    required this.senha,
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'usuario': usuario,
      'senha': senha,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Usuario{id: $id, usuario: $usuario, senha: $senha}';
  }
}