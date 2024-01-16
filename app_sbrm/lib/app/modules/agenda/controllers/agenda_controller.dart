import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:santa_barbara/model/avisos.interface.dart';
import 'package:santa_barbara/modules/avisos/avisos.repository.dart';

class AgendaController extends GetxController {
  //TODO: Implement AgendaController

  RxList<AvisoInterface> listaAgendas = <AvisoInterface>[].obs;
  var selectedMes = 0.obs;
  var x = ''.obs;
  final count = 0.obs;

  setMes(int mes) {
    selectedMes.value = mes;
  }




  RxList<AvisoInterface> getData(BuildContext context, int mes) {
    print('pegando valores de agenda $mes');
    late AvisoRepository avisoRepository;
    avisoRepository = Provider.of<AvisoRepository>(context);
    print('vai pegar os dados');
    avisoRepository
        .recuperarAgenda(mes)
        .then((value) => {listaAgendas.value = value});
    // print('LISTA AGENDAS RETORNADA ${listaAgendas[0].dtInclusao}');
    x.value = 'teste';
    listaAgendas.refresh();
    return listaAgendas;
  }

  void increment() => count.value++;
}
