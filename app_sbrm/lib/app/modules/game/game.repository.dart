import 'dart:math';

import 'package:app_sbrm/model/quiz_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GameRepository extends ChangeNotifier {
  BaseTopicos topicoAtual = BaseTopicos();
  int topicoEscolhido = 0;
  List<BaseTopicos> listTopicos = []; // List<BaseTopicos>.empty();

  List<Color> colors = [];
  List<String> letters = [];

  bool _isPlaying = true;

  getTopicos() async {
    List<BaseTopicos> l = [];
    final firestore = FirebaseFirestore.instance;
    final query = firestore.collection('quiztopicos').get();
    final snapshot = await query.then((value) => value.docs);
    final topicos =
        snapshot.map((doc) => topicoAtual.fromJson(doc.data())).toList();
    // listTopicos = topicos as List<BaseTopicos>;
    letters = [];
    colors = [];
    for (var e in topicos) {
      BaseTopicos b = BaseTopicos();
      b.id = e.id;
      b.nome = e.nome;
      b.cor = e.cor;
      l.add(b);
      letters.add(b.nome!);
      colors.add(Colors.primaries[Random().nextInt(Colors.primaries.length)]);
    }
    listTopicos = l;
    // notifyListeners();
  }
}
