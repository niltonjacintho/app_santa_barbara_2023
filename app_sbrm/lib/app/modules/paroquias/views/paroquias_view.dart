import 'package:go_router/go_router.dart';
import 'package:santa_barbara/app/modules/paroquias/controllers/paroquias.repository.dart';
import 'package:santa_barbara/app/modules/paroquias/views/paroquias_mapa.dart';
import 'package:santa_barbara/model/paroquias.model.dart';
import 'package:flutter/material.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/shared/types.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
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
    // print('passou na carga');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Paroquias Paroquiais',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Paroquias paroquiais'),
          leading: IconButton(
            color: Colors.black,
            icon: const Icon(Icons.arrow_back_ios),
            iconSize: 20.0,
            onPressed: () {
              GoRouter.of(context).go('/home');
            },
          ),
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
                            onPressed: () => {
                                  Dialogs.materialDialog(
                                    title: "Capelas da paróquia ${item.nome!}",
                                    color: const Color.fromARGB(
                                        255, 144, 147, 192),
                                    customView: item.capelas!.length > 2
                                        ? capelaslist(context, item)
                                        : const Text(
                                            'Esta paróquia não possui capelas',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                    customViewPosition:
                                        CustomViewPosition.BEFORE_MESSAGE,
                                    context: context,
                                    // ignore: dead_code
                                    dialogWidth: true ? 0.8 : null,
                                    onClose: (value) =>
                                        print("returned value is '$value'"),
                                    actions: [
                                      Visibility(
                                        visible: item.capelas!.length > 2,
                                        child: IconsOutlineButton(
                                          onPressed: () {},
                                          text: 'Voltar',
                                          iconData: Icons.cancel_outlined,
                                          textStyle: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 23, 70, 4)),
                                          iconColor: const Color.fromARGB(
                                              255, 206, 233, 200),
                                        ),
                                      ),
                                    ],
                                  ),
                                },
                            child: const Text(
                              'Capelas',
                              style: TextStyle(fontSize: 15),
                            )),
                        TextButton(
                            onPressed: () {
                              // print('pressed');
                              paroquiaRepository.paroquiaAtual = item;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ParoquiasMap()),
                              );
                            },
                            child: const Text('Mapa')),
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

//
  Widget capelaslist(BuildContext context, ParoquiaInterface paroquia) {
    // print('entrou ');
    List<CapelasInterface>? c = [];
    // print(paroquia.capelas);
    for (var i = 0; i < paroquia.capelas!.length; i++) {
      if (i > 1) {
        c.add(paroquia.capelas![i]);
      }
    }
    paroquia.capelas = c;
    // print(paroquia.capelas);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: paroquia.capelas!.length,
          itemBuilder: (context, index) {
            CapelasInterface item = paroquia.capelas![index];
            return Card(
                elevation: 12,
                color: const Color.fromARGB(255, 229, 247, 215),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.nome!,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        item.endereco!.trim() + item.endereco2!.trim(),
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        item.telefone!,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ));
          },
        ),
      ),
    );
    // ]);
  }
}
