import 'package:get/get.dart';
import '../../../simulacionbackend/backend_negocio.dart';
import '../models/negocio.dart';

class NegocioRepository {
  
  BackendNegocio backend = Get.find();

  getId(id){
    backend.getId(id);
  }
  getCorreo(correo){
    backend.getCorreo(correo);
  }
  delete(id){
    backend.delete(id);
  }
  edit(Negocio obj){
    backend.edit(obj);
  }
  add(Negocio obj){
    try {
      backend.add(obj);
      return true;
    } catch (e) {
      throw e.toString();
    }
  }

}