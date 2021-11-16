class Usuario {
  late int _id;
  late String _usuario;
  late String _senha;

  Usuario(this._usuario, this._senha);

  Usuario.fromMap(dynamic obj) {
    _usuario = obj['usuario'];
    _senha = obj['senha'];
  }

  String get usuario => _usuario;
  String get senha => _senha;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["usuario"] = _usuario;
    map["senha"] = _senha;
    return map;
  }
}
