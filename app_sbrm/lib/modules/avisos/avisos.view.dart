// ignore_for_file: unused_local_variable

import 'package:app_sbrm/modules/avisos/avisos.repository.dart';
import 'package:app_sbrm/modules/avisos/avisos.service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

/// This example shows the basic usage of the [StickyGroupedListView].
void main() => runApp(const AvisosView());

// List<Element> _elements = <Element>[
//   Element(DateTime(2020, 6, 24, 18), 'Got to gym', Icons.fitness_center),
//   Element(DateTime(2020, 6, 24, 9), 'Work', Icons.work),
//   Element(DateTime(2020, 6, 25, 8), 'Buy groceries', Icons.shopping_basket),
//   Element(DateTime(2020, 6, 25, 16), 'Cinema', Icons.movie),
//   Element(DateTime(2020, 6, 25, 20), 'Eat', Icons.fastfood),
//   Element(DateTime(2020, 6, 26, 12), 'Car wash', Icons.local_car_wash),
//   Element(DateTime(2020, 6, 27, 12), 'Car wash', Icons.local_car_wash),
//   Element(DateTime(2020, 6, 27, 13), 'Car wash', Icons.local_car_wash),
//   Element(DateTime(2020, 6, 27, 14), 'Car wash', Icons.local_car_wash),
//   Element(DateTime(2020, 6, 27, 15), 'Car wash', Icons.local_car_wash),
//   Element(DateTime(2020, 6, 28, 12), 'Car wash', Icons.local_car_wash),
//   Element(DateTime(2020, 6, 29, 12), 'Car wash', Icons.local_car_wash),
//   Element(DateTime(2020, 6, 29, 12), 'Car wash', Icons.local_car_wash),
//   Element(DateTime(2020, 6, 30, 12), 'Car wash', Icons.local_car_wash),
// ];

class AvisosView extends StatelessWidget {
  const AvisosView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Grouped List View Example'),
        ),
        body: MyListView(),
      ),
    );
  }
}

// ignore: use_key_in_widget_constructors
class MyListView extends StatelessWidget {
  // final List<Map<String, dynamic>> items = [
  //   {
  //     'title': 'Item 1',
  //     'subtitle': 'Subtítulo 1',
  //     'date': '01/10/2023',
  //     'image': 'https://example.com/image1.jpg',
  //   },
  //   {
  //     'title': 'Item 2',
  //     'subtitle': 'Subtítulo 2',
  //     'date': '02/10/2023',
  //     'image': 'https://example.com/image2.jpg',
  //   },
  //   // Adicione mais itens aqui
  // ];

  @override
  Widget build(BuildContext context) {
    late AvisoRepository avisoRepository =
        Provider.of<AvisoRepository>(context);
    avisoRepository.recuperarAvisos();
    return ListView.builder(
      itemCount: avisoRepository.lista.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Image.network(avisoRepository.lista[index].imagem!),
            title: Text(
              avisoRepository.lista[index].titulo!,
              style: const TextStyle(fontSize: 30),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(avisoRepository.lista[index].subtitulo!,
                    style: const TextStyle(fontSize: 20)),
                Text(
                  avisoRepository.lista[index].autor as String,
                  style: const TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
