import 'package:prova02/services/request/login_request.dart';
import 'package:prova02/models/usuario.dart';

abstract class LoginCallBack {
  void onLoginSuccess(Usuario usuario);
  void onLoginError(String error);
}

class LoginResponse {
  LoginCallBack _callBack; 
  LoginRequest loginRequest = LoginRequest();
  LoginResponse(this._callBack);

  doLogin(String usuario, String senha) {
    loginRequest
        .getLogin(usuario, senha)
        .then((usuario) => _callBack.onLoginSuccess(usuario!))
        .catchError((onError) => _callBack.onLoginError(onError.toString()));
  } 
}