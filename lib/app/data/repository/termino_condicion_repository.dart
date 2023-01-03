
import 'package:get/get.dart';
import 'package:topsitesnegocio/simulacionbackend/backend_sedes.dart';

import '../../../simulacionbackend/backend_datos_sede.dart';

class TerminoCondicionRepository {

  BackendSede backendSede = Get.find();
  BackendDatosSede backendDatosSede = Get.find();

  // getAll(token)async{
  //   try {
  //     return await backendDatosSede.agregarTerminoCondicion(id, data, token);
  //   } catch (e) {
  //     throw e.toString();
  //   }
  // }
  // getId(token,id){
  //   try {
  //     return backendSede.getId(token, id);
  //   } catch (e) {
  //     throw e.toString();
  //   }
  // }
  // delete(token,id){
  //   try {
  //     return backendSede.delete(token,id);
  //   } catch (e) {
  //     throw e.toString();
  //   }
  // }
  edit(id, data, token){
    try {
      return backendDatosSede.editarTerminoCondicion(id, data, token);
    } catch (e) {
      throw e.toString();
    }
  }
  delete(idsSde, idTermino, token){
    try {
      return backendDatosSede.eliminarTerminoCondicion(idsSde, idTermino, token);
    } catch (e) {
      throw e.toString();
    }
  }
  add(id, token, data)async{
    try {
      return await backendDatosSede.agregarTerminoCondicion(id, data, token);
    } catch (e) {
      throw e.toString();
    }
  }

  //informacion de la sede


}
