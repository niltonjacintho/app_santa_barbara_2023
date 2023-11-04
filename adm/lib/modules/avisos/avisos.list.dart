// ignore_for_file: invalid_use_of_protected_member, avoid_print

import 'package:adm/model/artigo.model.dart';
import 'package:adm/modules/avisos/avisos.service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

class AvisosLista extends StatelessWidget {
  const AvisosLista({super.key}); // Get the data controller
  @override
  Widget build(BuildContext context) {
    final AvisoService avisoService = Get.put(AvisoService());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data List with PlutoGrid'),
      ),
      body: Column(
        children: [
          Expanded(
            child: grid(context, avisoService),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          avisoService.getPlutoGridRows();
          avisoService.getEntradas(); // Fetch or update data
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Widget grid(BuildContext context, AvisoService avisoService) {
    ArtigosModel artigosModel = ArtigosModel();
    return Obx(
      () => ListView.builder(
        itemCount: avisoService.rows.length ?? 0,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          var data = avisoService.entradas.isEmpty
              ? artigosModel.init()
              : avisoService.entradas[index];
          return Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 2),
            child: Card(
              elevation: 20,
              child: ListTile(
                title: Text(data.titulo!),
                subtitle: Text(data.subtitulo!),
              ),
            ),
          );
        },
      ),
    );
    // Obx(() {
    //   return PlutoGrid(
    //     noRowsWidget: const Text('nada'),
    //     columns: [
    //       PlutoColumn(
    //         title: 'Título',
    //         field: 'titulo',
    //         type: PlutoColumnType.text(),
    //       ),
    //       PlutoColumn(
    //         title: 'Subtítulo',
    //         field: 'subtitulo',
    //         type: PlutoColumnType.text(),
    //       ),
    //       PlutoColumn(
    //         title: 'Conteúdo ${avisoService.d}',
    //         field: 'conteudo',
    //         type: PlutoColumnType.text(),
    //       ),
    //       // Adicione mais colunas para outros campos
    //     ],
    //     //rows: avisoService.rows.map((item) => PlutoRow(cells: item).asMap()).toList(),
    //     rows: avisoService.rows.value,
    //   );
//    });
  }
}
