import 'package:get/get.dart';
import './util_controller.dart';

class UtilBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(UtilController());
    }
}