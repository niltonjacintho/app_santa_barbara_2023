import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
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
    final textoKey = GlobalKey<FormBuilderFieldState>();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Basic dialog title'),
          content: FormBuilder(
            key: formKey,
            child: Column(
              children: [
                FormBuilderTextField(
                  key: destinatarioKey,
                  name: 'destinatario',
                  decoration: const InputDecoration(labelText: 'Para quem será esta vela?'),
                ),
                                FormBuilderTextField(
                  key: intencaoKey,
                  name: 'intencao',
                  decoration: const InputDecoration(labelText: 'QUal a intenção desta vela'),
                ),
                const SizedBox(height: 10),
                MaterialButton(
                  color: Theme.of(context).colorScheme.secondary,
                  onPressed: () {
                    // Validate and save the form values
                    formKey.currentState?.saveAndValidate();
                    debugPrint(formKey.currentState?.value.toString());

                    // On another side, can access all field values without saving form with instantValues
                    formKey.currentState?.validate();
                    debugPrint(formKey.currentState?.instantValue.toString());
                  },
                  child: const Text('Login'),
                )
              ],
            ),
          ),

          // const Text(
          //   'A dialog is a type of modal window that\n'
          //   'appears in front of app content to\n'
          //   'provide critical information, or prompt\n'
          //   'for a decision to be made.',
          // ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Disable'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Enable'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
