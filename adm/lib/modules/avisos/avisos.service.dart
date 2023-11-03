import 'package:adm/model/artigo.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AvisoService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> gravarEntrada(ArtigosModel entrada) async {
    try {
      await _firestore.collection('artigos').add(entrada.toMap());
      print('gravou');
    } catch (e) {
      print('Erro ao salvar a entrada no Firestore: $e');
    }
  }

  Future<List<ArtigosModel>> getEntradas() async {
    final QuerySnapshot querySnapshot = await _firestore
        .collection('artigos')
        .where('grupo', isEqualTo: 'avisos')
        .get();
    return querySnapshot.docs.map((doc) {
      // ignore: avoid_print
      print(doc.data());
      print(doc.get('titulo'));
      return ArtigosModel.fromfirestoresnapshot(doc);
    }).toList();
  }

  DateTime dateTimeFromTimestamp(Timestamp timestamp) {
  return timestamp.toDate();
}
}
