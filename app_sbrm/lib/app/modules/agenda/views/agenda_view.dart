import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:santa_barbara/model/avisos.interface.dart';
import 'package:santa_barbara/modules/avisos/avisos.repository.dart';
import 'package:santa_barbara/modules/avisos/avisoview.details.dart';
import '../controllers/agenda_controller.dart';

class AgendaView extends GetView<AgendaController> {
  const AgendaView({super.key});

  @override
  Widget build(BuildContext context) {
    late AvisoRepository avisoRepository;
    avisoRepository = Provider.of<AvisoRepository>(context);
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

    List<DropdownMenuItem<int>> mesesList = [
      for (var i = 0; i < meses.length; i++)
        DropdownMenuItem<int>(
          value: i,
          child: Text(meses[i]),
        ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Agenda Paroquial',
          style: TextStyle(
              fontWeight: FontWeight.w900, color: Colors.white, fontSize: 30),
        ),
        leading: IconButton(
          color: Colors.black,
          icon: const Icon(Icons.arrow_back_ios),
          iconSize: 20.0,
          onPressed: () {
            GoRouter.of(context).go('/home');
          },
        ),
        backgroundColor:
            Colors.redAccent, // Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: DropdownButton(
                style: const TextStyle(fontSize: 30, color: Colors.black),
                isExpanded: true,
                hint: const Text(
                    'Selecione um mês'), // Not necessary for Option 1
                value: agendaController.selectedMes.value,
                onChanged: (newValue) {
                  agendaController.setMes(newValue as int);
                  avisoRepository.recuperarAgenda(newValue).then(
                      (value) => {agendaController.listaAgendas.value = value});
                },
                items: mesesList),
          ),

          Expanded(
            child: ChangeNotifierProvider<AvisoRepository>(
              create: (_) => AvisoRepository(),
              child: Consumer<AvisoRepository>(
                builder: (context, model, child) => ListView.builder(
                  itemCount: avisoRepository.avisos.length,
                  itemBuilder: (context, index) {
                    AvisoInterface item = avisoRepository.avisos[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        horizontalTitleGap: 10,
                        dense: true,
                        minVerticalPadding: 0,
                        contentPadding: EdgeInsets.zero,
                        visualDensity:
                            const VisualDensity(horizontal: 0, vertical: 4),
                        leading: Container(
                          color: const Color.fromARGB(255, 110, 10, 2),
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
                        trailing: item.conteudo!.isNotEmpty
                            ? ElevatedButton(
                                child: const Text('Detalhes'),
                                onPressed: () {
                                  avisoRepository.avisoAtual = item;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AvisoviewDetails()),
                                  );
                                })
                            : const Text(''),

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
                          side:
                              const BorderSide(color: Colors.grey, width: 1.0),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          //),
          //)
        ],
      ),
    );
  }
}
