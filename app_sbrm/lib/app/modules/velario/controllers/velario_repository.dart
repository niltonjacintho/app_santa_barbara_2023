import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:santa_barbara/app/modules/velario/vela.Interface.dart';

class AvisoRepository extends ChangeNotifier {
  List<VelaInterface> velas = [];
  VelaInterface vela = VelaInterface();

  double _fontSize = 26;
  double get fontSize => _fontSize;
  set fontSize(value) => _fontSize = value;

  late VelaInterface velaAtual = VelaInterface();
  VelaInterface get avisoAtual => velaAtual;
  set avisoAtual(value) => velaAtual = value;

  fromJson(Map<String, dynamic> json) {
    vela.id = json["id"];
    vela.data = json['data'];
    vela.intencao = json['intencao'];
    vela.minutosrestantes = json['minutosrestantes'];
    vela.destinatario = json['destinatario'];
    vela.solicitanteemail = json['solicitanteemail'];
    vela.solicitantenome = json['solicitantenome'];
    vela.texto = json['texto'];
    vela.dataInclusao = json['dataAlteracao'];
  }

  Future<List<VelaInterface>> recuperarVelasAcesas(bool somenteAcesas) async {
    final firestore = FirebaseFirestore.instance;
    final query = firestore
        .collection('velas')
        .where("grupo", isEqualTo: 'velas')
        // .where("data", isGreaterThanOrEqualTo: inicio)
        // .where("data", isLessThanOrEqualTo: fim)
        .orderBy("data", descending: false)
        .get();
    final snapshot = await query.then((value) => value.docs);
    var av = snapshot.map((doc) => fromJson(doc.data())).toList();
    velas = av as List<VelaInterface>;
    notifyListeners();
    return velas;
  }
}
