// ignore_for_file: unused_local_variable

import 'package:app_sbrm/model/avisos.interface.dart';
import 'package:app_sbrm/modules/avisos/avisos.repository.dart';
import 'package:app_sbrm/modules/avisos/avisos.service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

/// This example shows the basic usage of the [StickyGroupedListView].
// void main() => runApp(const AvisosView());

class AvisosView extends StatelessWidget {
  const AvisosView({super.key});
  @override
  Widget build(BuildContext context) {
    late AvisoRepository avisoRepository;
    avisoRepository = Provider.of<AvisoRepository>(context);
    context.read<AvisoRepository>().recuperarAvisos();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Avisos Paroquiais',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Avisos paroquiais'),
        ),
        body: MyListView(),
      ),
    );
  }
}

// ignore: use_key_in_widget_constructors
class MyListView extends StatelessWidget {
  late AvisoRepository avisoRepository;

  @override
  Widget build(BuildContext context) {
    avisoRepository = Provider.of<AvisoRepository>(context);
    return FutureBuilder(
      future: avisoRepository.recuperarAvisos(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('No data available'));
        }
        final avisoList = snapshot.data;
        // ignore: avoid_print, prefer_interpolation_to_compose_strings
        // print('AVISO ' + snapshot.data[0].titulo);
        return ListView.builder(
          itemCount: avisoList.length,
          itemBuilder: (context, index) {
            final aviso =
                avisoList[index] as AvisoInterface; // as Map<String, dynamic>;
            return SizedBox(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Card(
                    elevation: 20,
                    color: Colors.white,
                    margin: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child:
                                Image.network(aviso.imagem!, fit: BoxFit.fill,
                                    errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/images/default.jpg',
                              );
                            }),
                          ),
                          Expanded(
                            flex: 8,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    aviso.titulo!,
                                    style: const TextStyle(fontSize: 30),
                                  ),
                                  Text(
                                    aviso.subtitulo!,
                                    style: const TextStyle(fontSize: 20),
                                    maxLines: 1,
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    aviso.dtInclusao.toString(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
              ),
            );
          },
        );
      },
    );
  }
}
