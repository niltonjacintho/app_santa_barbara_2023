import 'package:app_sbrm/model/avisos.interface.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_sbrm/modules/avisos/avisos.repository.dart';
import 'package:provider/provider.dart';

class AgendaController extends GetxController {
  //TODO: Implement AgendaController

  RxList<AvisoInterface> listaAgendas = new List<AvisoInterface>.empty().obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  RxList<AvisoInterface> getData(BuildContext context) {
    print('pegando valores');
    late AvisoRepository avisoRepository;
    avisoRepository = Provider.of<AvisoRepository>(context);
    avisoRepository
        .recuperarAvisos(grupo: 'agenda')
        .then((value) => listaAgendas.value = value);
    print(listaAgendas[0].dtInclusao);
    return listaAgendas;
  }

  void increment() => count.value++;
}
