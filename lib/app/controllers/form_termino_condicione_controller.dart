import 'package:get/get.dart';
import 'package:topsitesnegocio/app/controllers/sede_controller.dart';
import 'package:topsitesnegocio/app/data/models/sede/termino_condicion.dart';

import '../data/models/tipo_termino_condicion.dart';
import '../data/repository/termino_condicion_repository.dart';
import '../ui/widgets/snackbar.dart';

class FormTerminoCondicionController extends GetxController {
  

  TerminoCondicionRepository terminoCondicionRepository = TerminoCondicionRepository();
  final tipoTerminosCondiciones = <TipoTerminoCondicion>[].obs;

  @override
  void onInit() {
    //obternet terminos condiciones del backend
    tipoTerminosCondiciones.value = [
      TipoTerminoCondicion(id: '0', nombre: 'Tipo termino condicion'),
      TipoTerminoCondicion(id: '1', nombre: 'Tipo 1'),
    ];

    super.onInit();
  }
  
  Future<bool> actualizar(TerminoCondicion terminoCondicion)async{
    SedeController sedeController = Get.find();  
    try {
      await terminoCondicionRepository.edit(sedeController.sede.value.id, terminoCondicion, sedeController.token!);
      sedeController.cargarDatosSede();
      return true;
    } catch (e) {
      MensajeInferior.porDefecto(titulo: 'Error', mensaje: e.toString());
      return false;
    }
  }

  Future<bool> agregar(TerminoCondicion terminoCondicion)async{
    SedeController sedeController = Get.find();  
    try {
      await terminoCondicionRepository.add(sedeController.sede.value.id, sedeController.token!, terminoCondicion);
      sedeController.cargarDatosSede();
      return true;
    } catch (e) {
      MensajeInferior.porDefecto(titulo: 'Error', mensaje: e.toString());
      return false;
    }
  }

  Future<bool> eliminar(id)async{
    SedeController sedeController = Get.find();  
    try {
      await terminoCondicionRepository.delete(sedeController.sede.value.id, id,sedeController.token!);
      sedeController.cargarDatosSede();
      return true;
    } catch (e) {
      MensajeInferior.porDefecto(titulo: 'Error', mensaje: e.toString());
      return false;
    }
  }


  obtenerTipoTerminoCondicion(id){
    for (var item in tipoTerminosCondiciones.value) {
      if(id == item.id){
        return item.nombre;
      }
    }
    return '';
  }

}