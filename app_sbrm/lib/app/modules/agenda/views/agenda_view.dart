import 'package:app_sbrm/modules/avisos/avisos.repository.dart';
import 'package:flutter/material.dart';
import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:clickable_list_wheel_view/measure_size.dart';
import 'package:get/get.dart';
import 'package:grock/grock.dart';
import 'package:provider/provider.dart';
import 'package:z_grouped_list/z_grouped_list.dart';
import '../controllers/agenda_controller.dart';

class AgendaView extends GetView<AgendaController> {
  const AgendaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final agendaController = Get.put(AgendaController());
    final meses = [
      'Janeiro',
      'Fevereiro',
      'Março',
      'Abril',
      'Maio',
      'Junho',
      'Julho',
      'Agosto',
      'Setembro',
      'Outubro',
      'Novembro',
      'Dezembro'
    ];

    late AvisoRepository avisoRepository;
    avisoRepository = Provider.of<AvisoRepository>(context);

    List<DropdownMenuItem<int>> mesesList = [
      for (var i = 0; i < meses.length; i++)
        DropdownMenuItem<int>(
          value: i,
          child: Text(meses[i]),
        ),
    ];
    int mesId = 0;
    String? _selectedMes = "1";
    return Scaffold(
      appBar: AppBar(
        title: const Text('AgendaView'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Obx(
            () => DropdownButton(
                style: TextStyle(fontSize: 30, color: Colors.black),
                isExpanded: true,
                hint: const Text(
                    'Selecione um mês'), // Not necessary for Option 1
                value: agendaController.selectedMes.value,
                onChanged: (newValue) {
                  agendaController.setMes(newValue as int);
                  // agendaController.getData(context, newValue);
                  avisoRepository.recuperarAgenda(newValue).then(
                      (value) => agendaController.listaAgendas.value = value);
                },
                items: mesesList),
          ),
          Expanded(
            child: ZGroupedList(
              items: agendaController.listaAgendas, // .getData(context),
              sortBy: (item) {
                int mes = item.data.isEmpty ? 0 : item.data!.month;
                return mes;
              },
              itemBuilder: (context, item) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    horizontalTitleGap: 10,
                    dense: true,
                    minVerticalPadding: 0,
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity(horizontal: 0, vertical: 4),
                    leading: Container(
                      color: Color.fromARGB(255, 110, 10, 2),
                      width: 100,
                      child: Center(
                        child: Text(
                          item.data!.day.toString(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 40),
                        ),
                      ),
                    ),
                    //  ),
                    title: Text(
                      item.titulo ?? agendaController.x.value,
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      item.subtitulo ?? "empty",
                      style: const TextStyle(fontSize: 20),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: Colors.grey, width: 1.0),
                    ),
                  ),
                );
              },
              groupSeparatorBuilder: (mes) {
                return Text(
                  meses[mes - 1],
                  style: const TextStyle(
                      fontSize: 32.0, fontWeight: FontWeight.w800),
                );
              },
            ),
          ),
          //),
          //)
        ],
      ),
    );
  }
}
