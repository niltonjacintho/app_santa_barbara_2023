import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:santa_barbara/model/avisos.interface.dart';
import 'package:santa_barbara/modules/avisos/avisos.repository.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../controllers/photo_controller.dart';

class PhotoView extends GetView<PhotoController> {
  const PhotoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    late AvisoRepository avisoRepository;
    avisoRepository = Provider.of<AvisoRepository>(context);
    context.read<AvisoRepository>().recuperarAvisos();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Nossos albuns de fotos'),
          leading: IconButton(
            color: Colors.black,
            icon: const Icon(Icons.arrow_back_ios),
            iconSize: 20.0,
            onPressed: () {
              GoRouter.of(context).go('/home');
            },
          ),
        ),
        body: PhotosList());
  }
}

// ignore: must_be_immutable
class PhotosList extends StatelessWidget {
  late AvisoRepository avisoRepository;

  PhotosList({super.key});

  @override
  Widget build(BuildContext context) {
    avisoRepository = Provider.of<AvisoRepository>(context);
    return FutureBuilder(
      future: avisoRepository.recuperarAvisos(grupo: 'photos'),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('No data available'));
        }
        final avisoList = snapshot.data;
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
                    child: GestureDetector(
                      onTap: () => {
                        avisoRepository.avisoAtual = aviso,
                        GoRouter.of(context).go('/photoshow'),
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
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
                                      'Dia: ${aviso.dtInclusao?.day}/${aviso.dtInclusao?.month}/${aviso.dtInclusao?.year}',
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
