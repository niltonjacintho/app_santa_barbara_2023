import 'package:santa_barbara/model/paroquias.model.dart';
import 'package:get/get.dart';

class ParoquiasController extends GetxController {
  //TODO: Implement ParoquiasController

  ParoquiaInterface paroquias = ParoquiaInterface();

  final count = 0.obs;

  void increment() => count.value++;
}
