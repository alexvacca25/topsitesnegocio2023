
import 'package:get/get.dart';
import 'package:topsitesnegocio/app/data/models/sede/horario_sede.dart';
import 'package:topsitesnegocio/app/data/models/sede/imagenes_sede.dart';
import 'package:topsitesnegocio/app/data/models/sede/pago_cobro.dart';
import 'package:topsitesnegocio/simulacionbackend/backend_sedes.dart';

import '../../../simulacionbackend/backend_datos_sede.dart';
import '../models/sede/informacion_general.dart';

class SedeRepository {

  BackendSede backendSede = Get.find();
  BackendDatosSede backendDatosSede = Get.find();

  getAll(token)async{
    try {
      return await backendSede.getAll(token);
    } catch (e) {
      throw e.toString();
    }
  }
  getId(token,id){
    try {
      return backendSede.getId(token, id);
    } catch (e) {
      throw e.toString();
    }
  }
  delete(token,id){
    try {
      return backendSede.delete(token,id);
    } catch (e) {
      throw e.toString();
    }
  }
  edit(token, sede){
    try {
      return backendSede.edit(token, sede);
    } catch (e) {
      throw e.toString();
    }
  }
  add(token, sede)async{
    try {
      return await backendSede.add(token, sede);
    } catch (e) {
      throw e.toString();
    }
  }

  //informacion de la sede


  actualizarInformacionGeneral(String token, id, InformacionGeneral informacionGeneral){
    return backendDatosSede.editInfo(id, informacionGeneral, token);
  }

  actualizarPagoCobro(String token, id, PagoCobro pagoCobro){
    return backendDatosSede.editPagoCobro(id, pagoCobro, token);
  }

  actualizarImagenes(String token, id, ImagenesSede imagenes){
    return backendDatosSede.editImagenes(id, imagenes, token);
  }

  actualizarHorario(String token, id, Horario horario){
    return backendDatosSede.editHorario(id, horario, token);
  }
}
