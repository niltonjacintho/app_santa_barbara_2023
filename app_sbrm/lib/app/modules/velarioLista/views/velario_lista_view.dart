import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/velario_lista_controller.dart';

class VelarioListaView extends GetView<VelarioListaController> {
  const VelarioListaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VelarioListaView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'VelarioListaView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
