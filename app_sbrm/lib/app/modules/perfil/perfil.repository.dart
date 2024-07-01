import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';
import 'package:santa_barbara/model/perfil_model.dart';

class PerfilRepository extends ChangeNotifier {
  final String COLECTION_NAME = 'perfil';
  final String PERFIL_ID = '001';
  // ignore: prefer_final_fields
  PerfilModel _perfilAtivo = PerfilModel(
      nome: '',
      nascimento: DateTime(1900),
      telefone: '',
      createDate: DateTime(1900),
      updateDate: DateTime(1900));

  PerfilModel get perfilAtivo => _perfilAtivo;
  final db = Localstore.instance;
  set perfilAtivo(PerfilModel value) {
    _perfilAtivo = value;
  }

  String createPerfil() {
    final id = db.collection(COLECTION_NAME).doc().id;
    db.collection(COLECTION_NAME).doc(id).set(_perfilAtivo.toJson());
    return id;
  }

  Future<PerfilModel> gerPerfil(String id) async {
    final data = await db.collection(COLECTION_NAME).doc(id).get();
    return data as PerfilModel;
  }

  Future<bool> existePerfil() async {
    final data = await db.collection(COLECTION_NAME).doc(PERFIL_ID).get();
    return (data == null);
  }
}
