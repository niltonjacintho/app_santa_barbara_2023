import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:santa_barbara/app/modules/velario/vela.Interface.dart';
import 'package:santa_barbara/modules/auth/auth.repository.dart';

class VelarioRepository extends ChangeNotifier {
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

  Future<void> acenderVela(VelaInterface vela) async {
    UserRepository userRepository = UserRepository();
    VelaInterface vela = VelaInterface();
    vela.data = DateTime.now();
    vela.dataInclusao = DateTime.now();
    vela.solicitanteemail = userRepository.usuario.email;
    vela.solicitantenome = userRepository.usuario.nome;
    final firestore = FirebaseFirestore.instance;
    final docRef = firestore
        .collection('velas')
        .doc(vela.id ?? ''); // Use o ID da vela, se existir, ou gere um novo

    await docRef.set(vela as Map<String, dynamic>);
  }
}
