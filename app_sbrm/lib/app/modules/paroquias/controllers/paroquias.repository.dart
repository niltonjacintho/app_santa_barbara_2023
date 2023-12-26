import 'dart:ffi';

import 'package:app_sbrm/model/paroquias.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ParoquiasRepository extends ChangeNotifier {
  num fontDetailsSize = 18;
  bool first = true;
  ParoquiaInterface paroquiaAtual = ParoquiaInterface();
  List<ParoquiaInterface> lista_original = List<ParoquiaInterface>.empty();
  List<ParoquiaInterface> lista = List<ParoquiaInterface>.empty();

  filtrarLista(value) {
    lista = lista_original
        .where((p) => (p.nome!.toLowerCase().contains(value.toLowerCase())))
        .toList();
    print('Lista filtrada $lista');
    notifyListeners();
  }

  Future<List<ParoquiaInterface>> getData() async {
    if (first) {
      print('getting data');
      final firestore = FirebaseFirestore.instance;
      final query = firestore.collection('paroquias').get();
      final snapshot = await query.then((value) => value.docs);
      final List paroquias = await snapshot
          .map((doc) => paroquiaAtual.fromJson(doc.data()))
          .toList();
      lista = paroquias as List<ParoquiaInterface>;
      lista_original = paroquias;
      first = false;
      notifyListeners();
      return lista;
    } else {
      return Future(() => lista);
    }
  }
}
