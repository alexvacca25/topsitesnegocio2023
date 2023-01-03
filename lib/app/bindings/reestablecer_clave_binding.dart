import 'package:get/get.dart';

import '../controllers/reestablecer_clave_controller.dart';

class ReestablecerClaveBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ReestablecerClaveController>(ReestablecerClaveController());
  }
}