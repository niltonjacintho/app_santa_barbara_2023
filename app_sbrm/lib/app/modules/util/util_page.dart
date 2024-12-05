import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './util_controller.dart';

class UtilPage extends GetView<UtilController> {
    
    const UtilPage({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: const Text('UtilPage'),),
            body: Container(),
        );
    }
}