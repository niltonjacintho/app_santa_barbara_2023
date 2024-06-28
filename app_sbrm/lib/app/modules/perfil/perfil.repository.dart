import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';
import 'package:santa_barbara/model/perfil_model.dart';

class PerfilRepository extends ChangeNotifier {
  final String COLECTION_NAME = 'perfil';
  PerfilModel perfilAtivo = PerfilModel(
      nome: '',
      nascimento: null,
      telefone: '',
      createDate: null,
      updateDate: null);

  final db = Localstore.instance;

  String createPerfil(PerfilModel perfil) {
    final id = db.collection(COLECTION_NAME).doc().id;
    db.collection(COLECTION_NAME).doc(id).set(perfil.toJson());
    return id;
  }

  Future<PerfilModel> gerPerfil(String id) async {
    final data = await db.collection('todos').doc(id).get();
    return data as PerfilModel;
  }
}
