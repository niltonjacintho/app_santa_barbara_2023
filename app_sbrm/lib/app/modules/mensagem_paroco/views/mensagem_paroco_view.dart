import 'package:app_sbrm/modules/avisos/avisos.repository.dart';
import 'package:drop_cap_text/drop_cap_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../controllers/mensagem_paroco_controller.dart';

class MensagemParocoView extends GetView<MensagemParocoController> {
  const MensagemParocoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late AvisoRepository avisoRepository;
    avisoRepository = Provider.of<AvisoRepository>(context);
    avisoRepository.recuperarAvisos(grupo: 'mensagem_paroco', limite: 1);
    return ChangeNotifierProvider<AvisoRepository>(
      create: (_) => AvisoRepository(),
      child: Consumer<AvisoRepository>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            elevation: 10,
            title: const Text(
              'Mensagem do Pároco',
              style: TextStyle(
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
          body: Expanded(
            flex: 8,
            child: Scrollbar(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: DropCapText(
                    dropCapPosition: DropCapPosition.end,
                    dropCap: DropCap(
                        width: 400,
                        height: 500,
                        child:
                            Image.asset('assets/images/paroco/padre_001.png')),
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
    );
  }
}
