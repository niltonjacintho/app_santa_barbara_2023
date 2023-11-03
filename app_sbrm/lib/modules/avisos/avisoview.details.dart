import 'package:app_sbrm/model/avisos.interface.dart';
import 'package:app_sbrm/modules/avisos/avisos.repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_rich_text/simple_rich_text.dart';

class AvisoviewDetails extends StatefulWidget {
  const AvisoviewDetails({super.key});
//
  @override
  // ignore: library_private_types_in_public_api
  _AvisoviewDetailsState createState() => _AvisoviewDetailsState();
}

class _AvisoviewDetailsState extends State<AvisoviewDetails> {
  late AvisoRepository avisoRepository;
  @override
  Widget build(BuildContext context) {
    avisoRepository = Provider.of<AvisoRepository>(context);
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/fundo.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text(avisoRepository.avisoAtual.titulo!),
        Image.network(avisoRepository.avisoAtual.imagem!,
            height: 400,
            fit: BoxFit.fill, errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            'assets/images/default.jpg',
          );
        }),
        // Text(),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SimpleRichText(
              avisoRepository.avisoAtual.conteudo!,
              style: const TextStyle(fontSize: 26.0, color: Colors.black),
            ),
          ),
        ),
      ]),
    );
  }
}
