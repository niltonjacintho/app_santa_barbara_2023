import 'package:app_sbrm/model/avisos.interface.dart';
import 'package:app_sbrm/modules/avisos/avisos.repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    // avisoRepository.initialize();
    return ChangeNotifierProvider<AvisoRepository>(
      create: (_) => AvisoRepository(),
      child: Consumer<AvisoRepository>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            elevation: 10,
            title: Text(
              avisoRepository.avisoAtual.titulo!,
              style: const TextStyle(
                fontSize: 30,
                color: Colors.black,
                decoration: TextDecoration.none,
              ),
            ),
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  model.fontSize = model.fontSize + 1;
                  model.incFontSize();
                },
                icon: const Icon(
                  Icons.text_increase,
                ),
              ),
              IconButton(
                onPressed: () {
                  model.decFontSize();
                },
                icon: const Icon(
                  Icons.text_decrease,
                ),
              ),
            ],
          ),
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/fundo.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 5,
                    child: Image.network(avisoRepository.avisoAtual.imagem!,
                        height: 400, fit: BoxFit.scaleDown,
                        errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/default.jpg',
                      );
                    }),
                  ),
                  Expanded(
                    flex: 8,
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SimpleRichText(
                                avisoRepository.avisoAtual.conteudo!,
                                style: TextStyle(
                                    fontSize: model.fontSize,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  //),
                ]),
          ),
        ),
      ),
    );
  }
}
