import 'package:app_sbrm/model/avisos.interface.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_sbrm/modules/avisos/avisos.repository.dart';
import 'package:provider/provider.dart';

class AgendaController extends GetxController {
  //TODO: Implement AgendaController

  RxList<AvisoInterface> listaAgendas = <AvisoInterface>[].obs;
  var selectedMes = 0.obs;
  var x = ''.obs;
  final count = 0.obs;

  setMes(int mes) {
    selectedMes.value = mes;
  }

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

  RxList<AvisoInterface> getData(BuildContext context, int mes) {
    print('pegando valores de agenda');
    late AvisoRepository avisoRepository;
    avisoRepository = Provider.of<AvisoRepository>(context);
    avisoRepository
        .recuperarAgenda(mes)
        .then((value) => listaAgendas.value = value);
    // print('LISTA AGENDAS RETORNADA ${listaAgendas[0].dtInclusao}');
    x.value = 'teste';
    listaAgendas.refresh();
    return listaAgendas;
  }

  void increment() => count.value++;
}
