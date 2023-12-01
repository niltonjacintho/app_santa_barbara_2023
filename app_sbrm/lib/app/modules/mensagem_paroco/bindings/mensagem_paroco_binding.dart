import 'package:get/get.dart';

import '../controllers/mensagem_paroco_controller.dart';

class MensagemParocoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MensagemParocoController>(
      () => MensagemParocoController(),
    );
  }
}
