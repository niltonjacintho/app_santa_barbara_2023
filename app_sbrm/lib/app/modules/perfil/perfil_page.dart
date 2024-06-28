import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './perfil_controller.dart';

class PerfilPage extends GetView<PerfilController> {
    
    const PerfilPage({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: const Text('PerfilPage'),),
            body: Container(),
        );
    }
}