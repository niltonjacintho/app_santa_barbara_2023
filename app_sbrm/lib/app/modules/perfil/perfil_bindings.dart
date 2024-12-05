import 'package:get/get.dart';
import './perfil_controller.dart';

class PerfilBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(PerfilController());
    }
}