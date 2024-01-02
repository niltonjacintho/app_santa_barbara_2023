// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:math';

import 'package:app_sbrm/model/quizRank_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:app_sbrm/model/quiz_model.dart';
import 'package:uuid/uuid.dart';

class BasePontos {
  int acertos = 0;
  int erros = 0;
  double pontos = 0;
}

class GameRepository extends ChangeNotifier {
  BaseTopicos topicoAtual = BaseTopicos();
  BasePerguntas perguntaAtual = BasePerguntas();
  BasePontos basePontos = BasePontos();
  Uuid uuid = const Uuid();
  int idPerguntaAtual = 0;
  int topicoEscolhido = 0;
  List<BaseTopicos> listTopicos = []; // List<BaseTopicos>.empty();
  List<BasePerguntas> listPerguntas = [];
  List<QuizRankModel> listRank = [];

  List<Color> colors = [];
  List<String> letters = [];

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
    listPerguntas = [];
    var arrayValues = generateArray(10, 0, perguntas.length - 1);

    for (var i = 0; i < arrayValues.length; i++) {
      listPerguntas.add(perguntas[arrayValues[i]]);
    }
    perguntaAtual = listPerguntas[0];
    print(arrayValues);
    print(listPerguntas);
    notifyListeners();
  }

  List<int> generateArray(int qtd, int x, int y) {
    Set<int> set = {};
    var i = 0;
    while (i < qtd) {
      Random random = Random();
      int randomNumber = random.nextInt(y - x + 1) + x;
      if (!set.contains(randomNumber)) {
        set.add(randomNumber);
        i++;
      }
    }
    return set.toList();
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

  acertou(int pos) {
    return (perguntaAtual.perguntasRespostas![pos].respostacerta!);
  }

  gravarPontos(int tempo) {
    if (acertou(idPerguntaAtual)) {
      basePontos.acertos++;
    } else {
      basePontos.erros++;
    }
    basePontos.pontos += (idPerguntaAtual * tempo);
  }

  salvarRank() async {
    QuizRankModel quiz = QuizRankModel();
    quiz.acertos = basePontos.acertos;
    quiz.erros = basePontos.erros;
    quiz.data = DateTime.now();
    quiz.id = uuid.v4();
    quiz.pontos = basePontos.pontos;
    quiz.email = 'incluir ainda';
    quiz.nome = 'incluir apos o auth';
    quiz.topico = topicoAtual.id;

    final firestore = FirebaseFirestore.instance;
    firestore.collection('quizrank').add(quiz.toJson());
    basePontos = BasePontos();
  }

  getWinners() async {
    final firestore = FirebaseFirestore.instance;
    final query = firestore
        .collection('quizrank')
        .where("idTopico", isEqualTo: topicoAtual.id)
        .orderBy('pontos', descending: true)
        .limit(3)
        .get();
    final snapshot = await query.then((value) => value.docs);
    final top =
        snapshot.map((doc) => perguntaAtual.fromJson(doc.data())).toList();
    listRank = top as List<QuizRankModel>;
  }
}
