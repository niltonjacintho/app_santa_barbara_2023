import 'package:flutter/material.dart';

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
              default:
                print(position);
            }
          }),
      //   },

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
}
