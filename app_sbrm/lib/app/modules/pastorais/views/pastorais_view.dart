import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pastorais_controller.dart';

class PastoraisView extends GetView<PastoraisController> {
  const PastoraisView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PastoraisView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PastoraisView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
