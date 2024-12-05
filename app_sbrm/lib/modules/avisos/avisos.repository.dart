import 'dart:async';

import 'package:santa_barbara/model/avisos.interface.dart';
import 'package:santa_barbara/modules/avisos/avisos.service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AvisoRepository extends ChangeNotifier {
  AvisoService avisoService = AvisoService();
  final List<AvisoInterface> _lista = [];
  List<AvisoInterface> avisos = List<AvisoInterface>.empty();
  double _fontSize = 26;
  double get fontSize => _fontSize;
  set fontSize(value) => _fontSize = value;

  late AvisoInterface _avisoAtual = AvisoInterface();
  AvisoInterface get avisoAtual => _avisoAtual;
  set avisoAtual(value) => _avisoAtual = value;

  Future<double> initFontSize() async {
    final prefs = await SharedPreferences.getInstance();
    var f = prefs.getString('font_size') ?? '';
    return f as double;
  }

  incFontSize() async {
    _fontSize++;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('font_size', fontSize.toString());
    notifyListeners();
  }

  decFontSize() async {
    _fontSize--;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('font_size', fontSize.toString());
    notifyListeners();
  }

  List<AvisoInterface> get lista => _lista;

  AvisoInterface fromJson(Map<String, dynamic> json) {
    final AvisoInterface aviso = AvisoInterface();
    aviso.ativo = json['ativo'].toString();
    aviso.id = json['id'];
    aviso.autor = json['autor'];
    aviso.conteudo = json['conteudo'];
    aviso.grupo = json['grupo'];
    aviso.imagem = json['imagem'];
    aviso.likes = json['likes'];
    aviso.subtitulo = json['subtitulo'];
    aviso.titulo = json['titulo'];
    aviso.video = json['video'];
    aviso.visualizacoes = json['visualizacoes'];
    aviso.data = json['data'] != null
        ? DateTime.fromMillisecondsSinceEpoch(json['data'].seconds * 1000)
        : DateTime.now();
    aviso.dtInclusao =
        DateTime.fromMillisecondsSinceEpoch(json['dtInclusao'].seconds * 1000);
    aviso.dtLimiteExibicao = DateTime.fromMillisecondsSinceEpoch(
        json['dtLimiteExibicao'].seconds * 1000);
    return aviso;
  }

  DateTime getDatasMes(int mes, {bool inicio = false}) {
    int ano = 2024; //DateTime.now().year;
    mes++;
    late DateTime data;
    if (inicio) {
      data = DateTime(ano, mes, 1);
    } else {
      switch (mes) {
        case 2:
          data = DateTime(ano, 2, 28);
          break;
        case 1 || 3 || 5 || 7 || 8 || 10 || 12:
          data = DateTime(ano, mes, 31);
        case 4 || 6 || 9 || 11:
          data = DateTime(ano, mes, 30);
        default:
      }
    }
    return data;
  }

  Future<List<AvisoInterface>> recuperarAgenda(int mes) async {
    // Timestamp inicio = Timestamp.fromDate(getDatasMes(mes, inicio: true));
    // Timestamp fim = Timestamp.fromDate(getDatasMes(mes, inicio: false));
    var inicio = getDatasMes(mes, inicio: true);
    var fim = getDatasMes(mes, inicio: false);

    final firestore = FirebaseFirestore.instance;
    final query = firestore
        .collection('artigos')
        .where("grupo", isEqualTo: 'agenda')
        .where("data", isGreaterThanOrEqualTo: inicio)
        .where("data", isLessThanOrEqualTo: fim)
        .orderBy("data", descending: false)
        .get();
    final snapshot = await query.then((value) => value.docs);
    var av = snapshot.map((doc) => fromJson(doc.data())).toList();
    avisos = av;
    notifyListeners();
    return avisos;
  }

  Future<List<AvisoInterface>> recuperarAvisos(
      {String grupo = 'avisos', int limite = 9999}) async {
    final firestore = FirebaseFirestore.instance;
    final query = firestore
        .collection('artigos')
        .where("grupo", isEqualTo: grupo)
        .where("ativo", isEqualTo: true)
        .where("dtLimiteExibicao", isGreaterThanOrEqualTo: DateTime.now())
        .orderBy("data", descending: true)
        .limit(limite)
        .get();
    final snapshot = await query.then((value) => value.docs);
    final avisos = snapshot.map((doc) => fromJson(doc.data())).toList();
    if ((limite == 1) && (avisos.isNotEmpty)) {
      avisoAtual = avisos[0];
    }
    return avisos;
  }

  Future<List<AvisoInterface>> recuperarAvisosGeral(
      {String grupo = 'avisos', int limite = 9999}) async {
    final firestore = FirebaseFirestore.instance;
    final query = firestore
        .collection('artigos')
        .where("grupo", isEqualTo: grupo)
        .orderBy("dtInclusao", descending: true)
        .limit(limite)
        .get();
    final snapshot = await query.then((value) => value.docs);
    final avisos = snapshot.map((doc) => fromJson(doc.data())).toList();
    if ((limite == 1) && (avisos.isNotEmpty)) {
      avisoAtual = avisos[0];
    }
    notifyListeners();
    return avisos;
  }
}
