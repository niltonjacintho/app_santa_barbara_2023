import 'package:get/get.dart';

import '../controllers/velario_lista_controller.dart';

class VelarioListaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VelarioListaController>(
      () => VelarioListaController(),
    );
  }
}
