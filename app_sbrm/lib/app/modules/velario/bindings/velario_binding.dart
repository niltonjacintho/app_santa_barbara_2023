import 'package:get/get.dart';

import '../controllers/velario_controller.dart';

class VelarioBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VelarioController>(
      () => VelarioController(),
    );
  }
}
