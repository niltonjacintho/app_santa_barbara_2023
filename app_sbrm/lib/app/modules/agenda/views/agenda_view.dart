import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/agenda_controller.dart';

class AgendaView extends GetView<AgendaController> {
  const AgendaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AgendaView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AgendaView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
