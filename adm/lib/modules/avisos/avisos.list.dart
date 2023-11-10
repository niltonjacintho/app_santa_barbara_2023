// ignore_for_file: invalid_use_of_protected_member, avoid_print

import 'package:adm/model/artigo.model.dart';
import 'package:adm/modules/avisos/avisos.service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AvisosLista extends StatelessWidget {
  const AvisosLista({super.key}); // Get the data controller
  @override
  Widget build(BuildContext context) {
    final AvisoService avisoService = Get.put(AvisoService());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data List with PlutoGrid'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 2, left: 40, right: 40),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(
                  16.0), // Espaçamento interno do Container
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.grey), // Adiciona uma borda cinza
                  borderRadius: BorderRadius.circular(
                      5.0), // Opcional: Adiciona cantos arredondados
                ),
                child: const Row(
                  children: <Widget>[
                    Icon(Icons.search), // Ícone de pesquisa
                    SizedBox(
                        width: 10.0), // Espaçamento entre o ícone e o texto
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Digite sua pesquisa...',
                          border: InputBorder
                              .none, // Remove a borda padrão do TextField
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //),
            // Outros widgets abaixo, como a lista de resultados da pesquisa

            Expanded(
              child: grid(context, avisoService),
            ),
          ],
        ),
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
        itemCount: avisoService.entradas.length ?? 0,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          var data = avisoService.entradas.isEmpty
              ? artigosModel.init()
              : avisoService.entradas[index];
          return Card(
            elevation: 20,
            child: ListTile(
              leading: SizedBox(
                width: 80, // Adjust the width as needed
                height: 80, // Adjust the height as needed
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      10), // Optional: Add rounded corners
                  child: Image.network(
                    data.image!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(
                data.titulo!,
                style: const TextStyle(fontSize: 20),
              ),
              subtitle:
                  Text(data.subtitulo!, style: const TextStyle(fontSize: 15)),
              trailing: Text(data.dataCriacao.toString()),
            ),
            // ),
          );
        },
      ),
    );
  }
}
