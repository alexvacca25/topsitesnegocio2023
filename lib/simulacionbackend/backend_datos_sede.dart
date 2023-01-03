import 'dart:math';

import 'package:get/get.dart';
import 'package:topsitesnegocio/simulacionbackend/backend_negocio.dart';

import '../app/data/models/sede/imagenes_sede.dart';

class BackendDatosSede extends GetxController {

  editInfo(id, data, token){
    BackendNegocio backendNegocio = Get.find();    
    for (var i = 0; i < backendNegocio.negocios.length; i++) {
      if(backendNegocio.negocios[i].id == token){
        for (var j = 0; j < backendNegocio.negocios[i].sedes.length; j++) {
          if(backendNegocio.negocios[i].sedes[j].id == id){
            backendNegocio.negocios[i].sedes[j].informacionGeneral = data;
            return data;
          }
        }
        throw 'sede no encontrada';
      }
    }
    throw 'token no valido';
  }
  editPagoCobro(id, data, token){
    BackendNegocio backendNegocio = Get.find();    
    for (var i = 0; i < backendNegocio.negocios.length; i++) {
      if(backendNegocio.negocios[i].id == token){
        for (var j = 0; j < backendNegocio.negocios[i].sedes.length; j++) {
          if(backendNegocio.negocios[i].sedes[j].id == id){
            backendNegocio.negocios[i].sedes[j].pagoCobro = data;
            return data;
          }
        }
        throw 'sede no encontrada';
      }
    }
    throw 'token no valido';
  }

  editImagenes(id, data, token){

    for (var i = 0; i < data.fotosAdicionales.length; i++) {
      data.fotosAdicionales[i].imagen = 'https://picsum.photos/id/870/200/300';
      data.fotosAdicionales[i].tipo = Imagen.URL;
    }

    if(data.fotoLogo != null){
      data.fotoLogo.imagen = 'https://picsum.photos/200/300.jpg';
      data.fotoLogo.tipo = Imagen.URL;
    }

    if(data.fotoPrincipal != null){
      data.fotoPrincipal.imagen = 'https://picsum.photos/536/354';
      data.fotoPrincipal.tipo = Imagen.URL;
    }

    BackendNegocio backendNegocio = Get.find();    
    for (var i = 0; i < backendNegocio.negocios.length; i++) {
      if(backendNegocio.negocios[i].id == token){
        for (var j = 0; j < backendNegocio.negocios[i].sedes.length; j++) {
          if(backendNegocio.negocios[i].sedes[j].id == id){
            backendNegocio.negocios[i].sedes[j].imagenesSede = data;
            return data;
          }
        }
        throw 'sede no encontrada';
      }
    }
    throw 'token no valido';
  }
  
  editHorario(id, data, token){
    BackendNegocio backendNegocio = Get.find();    
    for (var i = 0; i < backendNegocio.negocios.length; i++) {
      if(backendNegocio.negocios[i].id == token){
        for (var j = 0; j < backendNegocio.negocios[i].sedes.length; j++) {
          if(backendNegocio.negocios[i].sedes[j].id == id){
            backendNegocio.negocios[i].sedes[j].horario = data;
            return data;
          }
        }
        throw 'sede no encontrada';
      }
    }
    throw 'token no valido';
  }

  agregarTerminoCondicion(id, data, token){
    BackendNegocio backendNegocio = Get.find();    
    for (var i = 0; i < backendNegocio.negocios.length; i++) {
      if(backendNegocio.negocios[i].id == token){
        for (var j = 0; j < backendNegocio.negocios[i].sedes.length; j++) {
          if(backendNegocio.negocios[i].sedes[j].id == id){
            data.id = '${Random().nextInt(500)}';
            backendNegocio.negocios[i].sedes[j].terminosCondiciones.add(data);
            return data;
          }
        }
        throw 'sede no encontrada';
      }
    }
    throw 'token no valido';
  }
  editarTerminoCondicion(id, data, token){
    BackendNegocio backendNegocio = Get.find();    
    for (var i = 0; i < backendNegocio.negocios.length; i++) {
      if(backendNegocio.negocios[i].id == token){
        for (var j = 0; j < backendNegocio.negocios[i].sedes.length; j++) {
          if(backendNegocio.negocios[i].sedes[j].id == id){
            for (var k = 0; k < backendNegocio.negocios[i].sedes[j].terminosCondiciones.length; k++) {
              if(backendNegocio.negocios[i].sedes[j].terminosCondiciones[k].id == data.id){
                backendNegocio.negocios[i].sedes[j].terminosCondiciones[k] = data;
                return true;
              }
            }
            throw 'no encontrado';
          }
        }
        throw 'sede no encontrada';
      }
    }
    throw 'token no valido';
  }
  eliminarTerminoCondicion(idSede, idTermino, token){
    BackendNegocio backendNegocio = Get.find();    
    for (var i = 0; i < backendNegocio.negocios.length; i++) {
      if(backendNegocio.negocios[i].id == token){
        for (var j = 0; j < backendNegocio.negocios[i].sedes.length; j++) {
          if(backendNegocio.negocios[i].sedes[j].id == idSede){
            for (var k = 0; k < backendNegocio.negocios[i].sedes[j].terminosCondiciones.length; k++) {
              if(backendNegocio.negocios[i].sedes[j].terminosCondiciones[k].id == idTermino){
                backendNegocio.negocios[i].sedes[j].terminosCondiciones.removeAt(k);
                return true;
              }
            }
            throw 'no encontrado';
          }
        }
        throw 'sede no encontrada';
      }
    }
    throw 'token no valido';
  }
}