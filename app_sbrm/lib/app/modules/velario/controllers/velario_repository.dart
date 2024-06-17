import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:santa_barbara/app/modules/velario/vela.Interface.dart';
import 'package:santa_barbara/modules/auth/auth.repository.dart';
import 'package:uuid/uuid.dart';

class VelarioRepository extends ChangeNotifier {
  List<VelaInterface> velas = [];
  VelaInterface vela = VelaInterface();

  double _fontSize = 26;
  double get fontSize => _fontSize;
  set fontSize(value) => _fontSize = value;

  late VelaInterface velaAtual = VelaInterface();
  VelaInterface get avisoAtual => velaAtual;
  set avisoAtual(value) => velaAtual = value;

  var uuid = Uuid();
  late UserRepository userRepository;

  Map<String, dynamic> toJson(
      UserRepository userRepository, VelaInterface vela) {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['id'] = vela.id;
    // data['data'] = vela.data;
    data['intencao'] = vela.intencao;
    data['minutosrestantes'] = 60;
    data['destinatario'] = vela.destinatario;
    data['solicitanteemail'] = userRepository.usuario.email;
    data['solicitantenome'] = userRepository.usuario.nome;
    data['texto'] = vela.texto;
    data['dataInclusao'] = DateTime.now();
    data['dataAlteracao'] = DateTime.now();
    return data;
  }

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
        .orderBy("data", descending: false)
        .get();
    final snapshot = await query.then((value) => value.docs);
    var av = snapshot.map((doc) => fromJson(doc.data())).toList();
    velas = av as List<VelaInterface>;
    notifyListeners();
    return velas;
  }

  Future<void> acenderVela(VelaInterface vela, BuildContext context) async {
    userRepository = Provider.of<UserRepository>(context, listen: false);
    vela.data = DateTime.now();
    vela.dataInclusao = DateTime.now();
    vela.solicitanteemail = userRepository.usuario.email;
    vela.solicitantenome = userRepository.usuario.nome;
    vela.id = vela.id == '' ? uuid.v4() : vela.id;
    final firestore = FirebaseFirestore.instance;
    final docRef = firestore
        .collection('velas')
        .doc(vela.id); // Use o ID da vela, se existir, ou gere um novo

    await docRef.set(toJson(userRepository, vela));
  }
}
