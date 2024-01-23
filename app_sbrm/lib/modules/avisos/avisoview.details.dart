import 'package:go_router/go_router.dart';
import 'package:santa_barbara/model/avisos.interface.dart';
import 'package:santa_barbara/modules/avisos/avisos.repository.dart';
import 'package:drop_cap_text/drop_cap_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            leading: IconButton(
              color: Colors.black,
              icon: const Icon(Icons.arrow_back_ios),
              iconSize: 20.0,
              onPressed: () {
                GoRouter.of(context).go('/home');
              },
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
          body: SizedBox.expand(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/fundo.jpg"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: DropCapText(
                      dropCapPosition: DropCapPosition.end,
                      dropCap: DropCap(
                        width: MediaQuery.of(context).size.width * 0.92,
                        height: 500,
                        child: Image.network(avisoRepository.avisoAtual.imagem!,
                            height: 400, fit: BoxFit.scaleDown,
                            errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/default.jpg',
                          );
                        }),
                      ),
                      avisoRepository.avisoAtual.conteudo!,
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: model.fontSize,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
