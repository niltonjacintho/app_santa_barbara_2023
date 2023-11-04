import 'package:adm/model/artigo.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pluto_grid/pluto_grid.dart';

class AvisoService extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList<ArtigosModel> entradas = <ArtigosModel>[].obs;
  var rows = [
    PlutoRow(
      cells: {
        'titulo': PlutoCell(value: 'element.titulo'),
        'subtitulo': PlutoCell(value: 'element.subtitulo'),
        'texto': PlutoCell(value: 'element.texto'),
        // Adicione mais células para outros campos
      },
    )
  ].obs;
  var d = 0.obs;

  void fechData() async {}

  void getPlutoGridRows() async {
    print('Entrou no GET');
    List<PlutoRow> r = [
      PlutoRow(
        cells: {
          'titulo': PlutoCell(value: 'element.titulo'),
          'subtitulo': PlutoCell(value: 'element.subtitulo'),
          'conteudo': PlutoCell(value: 'element.texto'),
          // Adicione mais células para outros campos
        },
      )
    ];
    await getEntradas().then(
      (value) {
        for (var element in value) {
          r.add(
            PlutoRow(
              cells: {
                'titulo': PlutoCell(value: element.titulo),
                'subtitulo': PlutoCell(value: element.subtitulo),
                'texto': PlutoCell(value: element.texto),
                // Adicione mais células para outros campos
              },
            ),
          );
        }
        rows.value = r;
        d.value++;
        rows.refresh();
        print('Rows Length ${rows.value.length}');
      },
    );

    update();
    print('notify no final ${rows.length}');
  }

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
    var data = querySnapshot.docs.map((doc) {
      return ArtigosModel.fromfirestoresnapshot(doc);
    }).toList();
    entradas.value = data;
    return data;
  }

  DateTime dateTimeFromTimestamp(Timestamp timestamp) {
    return timestamp.toDate();
  }
}
