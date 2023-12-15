import 'dart:async';
import 'dart:collection';

import 'package:app_sbrm/model/avisos.interface.dart';
import 'package:app_sbrm/modules/avisos/avisos.service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AvisoRepository extends ChangeNotifier {
  AvisoService avisoService = AvisoService();
  final List<AvisoInterface> _lista = [];
  double _fontSize = 26;
  // String s = '';
  // initialize() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   var value = prefs.getString('font_size') ?? '';
  //   _fontSize = double.parse(value);
  //   print('FONT SIZE $_fontSize Value $value  string $s');
  //   notifyListeners();
  // }

  double get fontSize => _fontSize;
  set fontSize(value) => _fontSize = value;

  late AvisoInterface _avisoAtual = new AvisoInterface();
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

  Future<List<AvisoInterface>> recuperarAvisos(
      {String grupo = 'avisos', int limite = 9999}) async {
    final firestore = FirebaseFirestore.instance;
    final query = firestore
        .collection('artigos')
        .where("grupo", isEqualTo: grupo)
        .orderBy("data", descending: true)
        .limit(limite)
        .get();
    final snapshot = await query.then((value) => value.docs);
    final avisos = snapshot.map((doc) => fromJson(doc.data())).toList();
    if ((limite == 1) && (avisos.isNotEmpty)) {
      avisoAtual = avisos[0];
    }
    //notifyListeners();
    print('AVISOS ${avisos[0].dtInclusao}');
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
