import 'package:get/get.dart';
import 'package:topsitesnegocio/app/data/models/sede/sede.dart';
import 'package:topsitesnegocio/app/routes/app_pages.dart';

import '../data/repository/sede_repository.dart';
import '../data/repository/token_repository.dart';
import '../ui/widgets/snackbar.dart';
import 'form_termino_condicione_controller.dart';

class SedeController extends GetxController {

  SedeRepository sedeRepository = SedeRepository();
  FormTerminoCondicionController formTerminoCondicionController = Get.put(FormTerminoCondicionController());
  

  dynamic id = Get.parameters['id'];

  final sede = Sede.construir().obs;
  final buscando = true.obs;
  final encontrado = false.obs;
  String? token = '';

  @override
  void onInit() async{

    if(id == null){
      Get.offAllNamed(Routes.HOME);
    }

    token = await TokenRepository().getToken();
    await cargarDatosSede();
    super.onInit();
  }

  Future<void> cargarDatosSede() async{
    try {
      sede.value = await sedeRepository.getId(token,id);
      sede.refresh();
      buscando.value = false;
      encontrado.value = true;
    } catch (e) {
      Get.offAllNamed(Routes.HOME);
      MensajeInferior.porDefecto(mensaje: 'Error', titulo: 'Sede no encontrada');
    }
  }


}