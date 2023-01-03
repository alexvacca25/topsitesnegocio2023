
// import 'dart:html';

import 'package:get/get.dart';
import 'package:topsitesnegocio/app/data/models/sede/imagenes_sede.dart';
import 'package:topsitesnegocio/app/data/models/sede/sede.dart';

import 'backend_negocio.dart';

class BackendSede  extends GetxController  {


  getAll(token){
    BackendNegocio backendNegocio = Get.find();
    for (var item in backendNegocio.negocios) {
      if(token == item.id){
        return item.sedes;
      }
    }
    throw 'token no valido';
  }
  getId(token,id){
    BackendNegocio backendNegocio = Get.find();
    for (var item in backendNegocio.negocios) {
      if(token == item.id){
        for (var sede in item.sedes) {
          if(id==sede.id)
          return sede;
        }
        return null;
      }
    }
    throw 'token no valido';
  }
  delete(token,id){
    deleteEdit(token, id, 0);
  }
  edit(token, Sede sede){
    for (var i = 0; i < sede.imagenesSede.fotosAdicionales.length; i++) {
      sede.imagenesSede.fotosAdicionales[i].imagen = 'https://picsum.photos/id/870/200/300';
      sede.imagenesSede.fotosAdicionales[i].tipo = Imagen.URL;
    }

    if(sede.imagenesSede.fotoLogo != null){
      sede.imagenesSede.fotoLogo.imagen = 'https://picsum.photos/200/300.jpg';
      sede.imagenesSede.fotoLogo.tipo = Imagen.URL;
    }

    if(sede.imagenesSede.fotoPrincipal != null){
      sede.imagenesSede.fotoPrincipal.imagen = 'https://picsum.photos/536/354';
      sede.imagenesSede.fotoPrincipal.tipo = Imagen.URL;
    }

    return deleteEdit(token, sede, 1);
  }
  add(token, sede)async{  
    BackendNegocio backendNegocio = Get.find();
    for (var i = 0; i < backendNegocio.negocios.length; i++) {
      if(backendNegocio.negocios[i].id == token){
        sede.id = backendNegocio.negocios[i].sedes.isEmpty ? '0' : '${int.parse(backendNegocio.negocios[i].sedes[backendNegocio.negocios[i].sedes.length-1].id) + 1}';
        backendNegocio.negocios[i].sedes.add(sede);
        return true;
      }
    }
    throw 'token no valido';
  }

  deleteEdit(token, sede, data){
    BackendNegocio backendNegocio = Get.find();
    for (var i = 0; i < backendNegocio.negocios.length; i++) {
      if(backendNegocio.negocios[i].id == token){
        for (var j = 0; j < backendNegocio.negocios[i].sedes.length; j++) {
          if(backendNegocio.negocios[i].sedes[j].id == sede.id){
            if(data==0){
              backendNegocio.negocios[i].sedes.removeAt(j);
              return true;
            }else if(data==1){
              backendNegocio.negocios[i].sedes[j] = sede;
              print(sede);
              return backendNegocio.negocios[i].sedes[j];
            }
          }
        }
        return false;
      }
    }
    throw 'token no valido';
  }

}