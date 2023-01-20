import 'package:get/get.dart';
import 'package:topsitesnegocio/app/controllers/sede_controller.dart';
import 'package:topsitesnegocio/app/data/models/sede/combo_plan.dart';

import '../data/repository/sede_repository.dart';
import '../ui/widgets/snackbar.dart';

class FormComboPlanController extends GetxController {

  SedeRepository repository = SedeRepository();
  SedeController sedeController = Get.find();  

  Future<bool> agregar()async{
    return false;

  }

  Future<bool> actualizar(ComboPlan comboPlan)async{
    try {
      sedeController.cargarDatosSede();
      return true;
    } catch (e) {
      MensajeInferior.porDefecto(titulo: 'Error', mensaje: e.toString());
      return false;
    }
  }
}