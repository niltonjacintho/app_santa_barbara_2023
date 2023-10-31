import 'dart:collection';

import 'package:app_sbrm/model/avisos.interface.dart';
import 'package:app_sbrm/modules/avisos/avisos.service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class AvisoRepository extends ChangeNotifier {
  AvisoService avisoService = AvisoService();
  List<AvisoInterface> _lista = [];
  UnmodifiableListView<AvisoInterface> get lista =>
      UnmodifiableListView(_lista);

  recuperarAvisos() async {
    final firestore = FirebaseFirestore.instance;
    final query = firestore.collection('artigos').get();
    final snapshot = await query.then((value) => value.docs);
    final avisos =
        snapshot.map((doc) => avisoService.fromJson(doc.data())).toList();
    _lista = avisos;
    notifyListeners();
  }
}
