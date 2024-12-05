import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/photo_lista_controller.dart';

class PhotoListaView extends GetView<PhotoListaController> {
  const PhotoListaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PhotoListaView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PhotoListaView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
