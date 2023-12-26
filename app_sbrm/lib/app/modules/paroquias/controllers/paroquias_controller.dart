import 'package:app_sbrm/model/paroquias.model.dart';
import 'package:get/get.dart';

class ParoquiasController extends GetxController {
  //TODO: Implement ParoquiasController

  ParoquiaInterface paroquias = ParoquiaInterface();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
