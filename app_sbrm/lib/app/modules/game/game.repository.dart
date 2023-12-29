import 'dart:math';

import 'package:app_sbrm/model/quiz_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GameRepository extends ChangeNotifier {
  BaseTopicos topicoAtual = BaseTopicos();
  BasePerguntas perguntaAtual = BasePerguntas();
  int idPerguntaAtual = 0;
  int topicoEscolhido = 0;
  List<BaseTopicos> listTopicos = []; // List<BaseTopicos>.empty();
  List<BasePerguntas> listPerguntas = [];

  List<Color> colors = [];
  List<String> letters = [];

  final bool _isPlaying = true;

  setTopico(int id) {
    topicoEscolhido = id;
    topicoAtual = listTopicos[id];
  }

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
    notifyListeners();
  }

  bool proximaPergunta() {
    if (idPerguntaAtual + 1 > listPerguntas.length) {
      return false;
    } else {
      idPerguntaAtual++;
      perguntaAtual = listPerguntas[idPerguntaAtual];
      notifyListeners();
      return true;
    }
  }

  getQuiz() async {
    final firestore = FirebaseFirestore.instance;
    final query = firestore
        .collection('quizperguntas')
        .where("idTopico", isEqualTo: topicoAtual.id)
        .get();
    final snapshot = await query.then((value) => value.docs);
    final perguntas =
        snapshot.map((doc) => perguntaAtual.fromJson(doc.data())).toList();
    listPerguntas = perguntas;
    perguntaAtual = listPerguntas[0];
    notifyListeners();
  }

  List<String> getButtonLabels() {
    List<String> a = [];

    if (perguntaAtual.perguntasRespostas != null) {
      for (var element in perguntaAtual.perguntasRespostas!) {
        a.add(element.respostatexto!.substring(2));
      }
    }
    return a;
  }

  List<String> getButtonValues() {
    List<String> a = [];
    if (perguntaAtual.perguntasRespostas != null) {
      for (var i = 0; i < perguntaAtual.perguntasRespostas!.length; i++) {
        a.add(((idPerguntaAtual * 10 + i).toString()));
      }
      print(a);
    }
    return a;
  }

  acertou(String p) {
    int pos = int.parse(p);
    pos = pos - (idPerguntaAtual * 10);
    return (perguntaAtual.perguntasRespostas![pos].respostacerta!);
  }
}
