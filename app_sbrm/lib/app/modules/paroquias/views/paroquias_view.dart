import 'package:app_sbrm/app/modules/paroquias/controllers/paroquias.repository.dart';
import 'package:app_sbrm/model/paroquias.model.dart';
import 'package:flutter/material.dart';
import 'package:material_text_fields/material_text_fields.dart';
import 'package:material_text_fields/theme/material_text_field_theme.dart';

import 'package:provider/provider.dart';

class ParoquiasView extends StatelessWidget {
  const ParoquiasView({super.key});
  @override
  Widget build(BuildContext context) {
    late ParoquiasRepository paroquiaRepository;
    paroquiaRepository = Provider.of<ParoquiasRepository>(context);
    paroquiaRepository.getData();
    print('passou na carga');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Paroquias Paroquiais',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Paroquias paroquiais'),
        ),
        body: ChangeNotifierProvider<ParoquiasRepository>(
          create: (_) => ParoquiasRepository(),
          child: Consumer<ParoquiasRepository>(
              builder: (context, model, child) =>
                  cardlist(context, paroquiaRepository)),
        ),
      ),
    );
  }

  Widget cardlist(
      BuildContext context, ParoquiasRepository paroquiaRepository) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MaterialTextField(
            keyboardType: TextInputType.text,
            labelText: 'Digite o nome da paróquia desejada!',
            theme: FilledOrOutlinedTextTheme(
              enabledColor: Colors.grey,
              focusedColor: Colors.green,
              fillColor: Colors.transparent,
              // You can use all properties of FilledOrOutlinedTextTheme
              // to decor text field
            ),
            prefixIcon: const Icon(Icons.search),
            onChanged: (value) => paroquiaRepository.filtrarLista(value),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: paroquiaRepository.lista.length,
            itemBuilder: (context, index) {
              ParoquiaInterface item = paroquiaRepository.lista[index];
              return Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        item.nome!,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 25),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pároco: ${item.paroco!}',
                            style: const TextStyle(fontSize: 18),
                          ),
                          Text(
                            'Vigário: ${item.vigario!}',
                            style: const TextStyle(fontSize: 18),
                          ),
                          Text(
                            'Endereço: ${item.endereco!} ${item.endereco2!}',
                            style: const TextStyle(fontSize: 18),
                          ),
                          Text(
                            'Telefones: ${item.telefones!}',
                            style: const TextStyle(fontSize: 18),
                          ),
                          Text(
                            'Forania: ${item.forania!}',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    ButtonBar(
                      children: [
                        TextButton(
                            onPressed: () {}, child: const Text('Capelas')),
                        TextButton(onPressed: () {}, child: const Text('Mapa')),
                        TextButton(
                            onPressed: () {}, child: const Text('detalhes')),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
