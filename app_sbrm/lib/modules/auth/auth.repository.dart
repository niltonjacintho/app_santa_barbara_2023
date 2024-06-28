import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:santa_barbara/model/user_model.dart';

class UserRepository extends ChangeNotifier {
  UserModel _usuario = UserModel();
  UserModel get usuario => _usuario;
  set usuario(UserModel value) => {_usuario = value, notifyListeners()};



  usuarioFromAccount(GoogleSignInAccount account) {
    UserModel u = UserModel();
    u.data = DateTime.now();
    u.email = account.email;
    u.nome = account.displayName;
    u.photo = account.photoUrl;
    usuario = u;
  }
}
