import 'package:adm/model/artigo.model.dart';
import 'package:adm/modules/avisos/avisos.service.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

class AvisosLista extends StatefulWidget {
  const AvisosLista({super.key});

  @override
  _AvisosListaState createState() => _AvisosListaState();
}

class _AvisosListaState extends State<AvisosLista> {
  AvisoService avisoService = AvisoService();
  List<ArtigosModel> entradas = [];

  @override
  void initState() {
    super.initState();
    avisoService.getEntradas().then((value) => setState(() {
          entradas = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Entradas'),
      ),
      body: Center(
        child: PlutoGrid(
          columns: [
            PlutoColumn(
              title: 'Título',
              field: 'titulo',
              type: PlutoColumnType.text(),
            ),
            PlutoColumn(
              title: 'Subtítulo',
              field: 'subtitulo',
              type: PlutoColumnType.text(),
            ),
            PlutoColumn(
              title: 'Conteúdo',
              field: 'conteudo',
              type: PlutoColumnType.text(),
            ),
            // Adicione mais colunas para outros campos
          ],
          rows: entradas
              .map((entrada) => PlutoRow(
                    cells: {
                      'titulo': PlutoCell(value: entrada.titulo),
                      'subtitulo': PlutoCell(value: entrada.subtitulo),
                      'texto': PlutoCell(value: entrada.texto),
                      // Adicione mais células para outros campos
                    },
                  ))
              .toList(),
        ),
      ),
    );
  }
}
