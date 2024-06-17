import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:santa_barbara/app/modules/velario/controllers/velario_repository.dart';
import 'package:santa_barbara/app/modules/velario/vela.Interface.dart';
import 'package:sz_fancy_bottom_navigation/sz_fancy_bottom_navigation.dart';

import '../controllers/velario_controller.dart';

class VelarioView extends GetView<VelarioController> {
  const VelarioView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        title: const Text(
          'Bem vindo ao nosso Velário',
          style: TextStyle(color: Colors.white, fontSize: 35),
        ),
        centerTitle: true,
      ),
      extendBody: true,
      bottomNavigationBar: FancyBottomNavigation(
          barBackgroundColor: const Color.fromARGB(255, 143, 8, 8),
          circleColor: const Color.fromARGB(243, 243, 241, 0),
          textColor: const Color.fromARGB(250, 248, 248, 246),
          tabs: [
            TabData(iconData: Icons.home, title: "Voltar"),
            TabData(
                iconData: Icons.wb_incandescent_outlined,
                title: "Acender Vela"),
            TabData(iconData: Icons.list_outlined, title: "Velas acesas"),
            TabData(
                iconData: Icons.local_fire_department_outlined,
                title: "Suas Velas"),
          ],
          onTabChangedListener: (position) {
            switch (position.toString()) {
              case '0':
                GoRouter.of(context).go('/home');
              case '1':
                _dialogBuilder(context);

              default:
                print(position);
            }
          }),
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/gifs/velaAcesa.gif"),
              fit: BoxFit.cover,
            ),
          ),
          child: null),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    final intencaoKey = GlobalKey<FormBuilderFieldState>();
    final destinatarioKey = GlobalKey<FormBuilderFieldState>();
    // final textoKey = GlobalKey<FormBuilderFieldState>();
    VelarioRepository velarioRepository = VelarioRepository();
    VelaInterface vela = VelaInterface();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Acenda a vela!'),
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          elevation: 10,
          backgroundColor: const Color.fromARGB(255, 223, 218, 205),
          content: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: FormBuilder(
              key: formKey,
              child: Column(
                children: [
                  FormBuilderTextField(
                    key: destinatarioKey,
                    name: 'destinatario',
                    decoration: const InputDecoration(
                        labelText: 'Para quem será esta vela?'),
                    onSaved: (value) => vela.destinatario = value,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FormBuilderTextField(
                    key: intencaoKey,
                    name: 'intencao',
                    maxLines: 3,
                    decoration: const InputDecoration(
                        labelText: 'Qual a intenção desta vela'),
                    onSaved: (value) => vela.intencao = value,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Sair'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Acender'),
              onPressed: () async {
                formKey.currentState?.save();
                await velarioRepository.acenderVela(vela, context);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
