import 'dart:collection';

import 'package:app_sbrm/model/avisos.interface.dart';
import 'package:app_sbrm/modules/avisos/avisos.service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class AvisoRepository extends ChangeNotifier {
  AvisoService avisoService = AvisoService();
  final List<AvisoInterface> _lista = [];
  List<AvisoInterface> get lista => _lista;

  AvisoInterface fromJson(Map<String, dynamic> json) {
    final AvisoInterface aviso = AvisoInterface();
    aviso.ativo = json['ativo'].toString();
    aviso.id = json['id'];
    aviso.autor = json['autor'];
    aviso.conteudo = json['conteudo'];
    // aviso.dtInclusao = DateTime.fromMicrosecondsSinceEpoch(json['dtInclusao']);
    // aviso.dtLimiteExibicao =
    //     DateTime.fromMicrosecondsSinceEpoch(json['dtLimiteExibicao']);
    aviso.grupo = json['grupo'];
    aviso.imagem = json['imagem'];
    aviso.likes = json['likes'];
    aviso.subtitulo = json['subtitulo'];
    aviso.titulo = json['titulo'];
    aviso.video = json['video'];
    aviso.visualizacoes = json['visualizacoes'];
    return aviso;
  }

  Future<List<AvisoInterface>> recuperarAvisos() async {
    final firestore = FirebaseFirestore.instance;
    final query = firestore
        .collection('artigos')
        .where("grupo", isEqualTo: "avisos")
        .get();
    final snapshot = await query.then((value) => value.docs);
    final avisos = snapshot.map((doc) => fromJson(doc.data())).toList();
    return avisos;
    // notifyListeners();
  }
}
