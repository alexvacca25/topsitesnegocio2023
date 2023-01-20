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
  
  ///se obtene el id pasado por parametros
  dynamic id = Get.parameters['id'];

  final sede = Sede.construir().obs;
  ///buscando es usado para saber si aun se esta buscando la sede y se pueda visalizar la vista de carga
  final buscando = true.obs;
  final encontrado = false.obs;
  String? token = '';

  @override
  void onInit() async{

    ///se valida que el id no sea nulo, en caso de serlo se regresa a la vista home
    if(id == null){
      Get.offAllNamed(Routes.HOME);
    }

    token = await TokenRepository().getToken();

    ///se procede a cargar los datos de la sede
    await cargarDatosSede();
    super.onInit();
  }

  Future<void> cargarDatosSede() async{
    try {
      ///se realiza la peticion al backend y se espera la respuesta
      sede.value = await sedeRepository.getId(token,id);
      sede.refresh();
      buscando.value = false;
      encontrado.value = true;
    } catch (e) {
      ///en caso de no ser encontrada u ocurra un error se redidigira al home y se mostrara un mensaje con el error
      Get.offAllNamed(Routes.HOME);
      MensajeInferior.porDefecto(mensaje: 'Error', titulo: e.toString());
    }
  }


}