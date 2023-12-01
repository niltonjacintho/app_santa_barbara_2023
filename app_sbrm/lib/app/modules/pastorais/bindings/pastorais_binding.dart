import 'package:get/get.dart';

import '../controllers/pastorais_controller.dart';

class PastoraisBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PastoraisController>(
      () => PastoraisController(),
    );
  }
}
