import 'package:get/get.dart';

import '../controllers/sede_controller.dart';

class SedeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SedeController>(SedeController(), permanent: false);
  }
}