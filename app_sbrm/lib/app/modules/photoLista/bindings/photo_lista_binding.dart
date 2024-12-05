import 'package:get/get.dart';

import '../controllers/photo_lista_controller.dart';

class PhotoListaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PhotoListaController>(
      () => PhotoListaController(),
    );
  }
}
