import 'package:get/get.dart';
import 'package:topsitesnegocio/app/data/models/sede/imagenes_sede.dart';
import 'package:topsitesnegocio/app/data/models/sede/sede.dart';
import 'package:topsitesnegocio/simulacionbackend/backend_datos_sede.dart';
import 'package:topsitesnegocio/simulacionbackend/backend_sedes.dart';
import 'package:topsitesnegocio/simulacionbackend/backend_usuario.dart';

import '../app/data/models/negocio.dart';
import '../app/data/models/sede/informacion_general.dart';

class BackendNegocio extends GetxController {

  BackendUsuarios backendUsuarios = Get.put(BackendUsuarios());
  BackendSede backendSede = Get.put(BackendSede());
  BackendDatosSede backendDatosSede = Get.put(BackendDatosSede());

  final negocios = <Negocio>[
    Negocio.construir(
      id: '1',
      numeroIdentificacion: '123456789',
      correo:'negocio@correo.com',
      estado: true,
      cuentaVerificada: false,
      sedes: <Sede> [
        Sede.construir(id: '0', informacionGeneral: InformacionGeneral.construir(nombre: 'sede 1',), imagenesSede: ImagenesSede.construir(fotoLogo: Imagen(imagen:'https://picsum.photos/200/300.jpg',tipo: Imagen.URL), fotoPrincipal: Imagen(imagen:'https://picsum.photos/536/354', tipo: Imagen.URL), 
        fotosAdicionales: [
          Imagen(imagen:'https://i.picsum.photos/id/1/5000/3333.jpg?hmac=Asv2DU3rA_5D1xSe22xZK47WEAN0wjWeFOhzd13ujW4', tipo: Imagen.URL),
          Imagen(imagen:'https://i.picsum.photos/id/0/5000/3333.jpg?hmac=_j6ghY5fCfSD6tvtcV74zXivkJSPIfR9B8w34XeQmvU', tipo: Imagen.URL),
          Imagen(imagen:'https://i.picsum.photos/id/10/2500/1667.jpg?hmac=J04WWC_ebchx3WwzbM-Z4_KC_LeLBWr5LZMaAkWkF68', tipo: Imagen.URL),
          Imagen(imagen:'https://i.picsum.photos/id/16/2500/1667.jpg?hmac=uAkZwYc5phCRNFTrV_prJ_0rP0EdwJaZ4ctje2bY7aE', tipo: Imagen.URL),
          Imagen(imagen:'https://i.picsum.photos/id/17/2500/1667.jpg?hmac=HD-JrnNUZjFiP2UZQvWcKrgLoC_pc_ouUSWv8kHsJJY', tipo: Imagen.URL),
          Imagen(imagen:'https://i.picsum.photos/id/1/5000/3333.jpg?hmac=Asv2DU3rA_5D1xSe22xZK47WEAN0wjWeFOhzd13ujW4', tipo: Imagen.URL),
          Imagen(imagen:'https://i.picsum.photos/id/0/5000/3333.jpg?hmac=_j6ghY5fCfSD6tvtcV74zXivkJSPIfR9B8w34XeQmvU', tipo: Imagen.URL),
          Imagen(imagen:'https://i.picsum.photos/id/10/2500/1667.jpg?hmac=J04WWC_ebchx3WwzbM-Z4_KC_LeLBWr5LZMaAkWkF68', tipo: Imagen.URL),
          Imagen(imagen:'https://i.picsum.photos/id/16/2500/1667.jpg?hmac=uAkZwYc5phCRNFTrV_prJ_0rP0EdwJaZ4ctje2bY7aE', tipo: Imagen.URL),
          Imagen(imagen:'https://i.picsum.photos/id/17/2500/1667.jpg?hmac=HD-JrnNUZjFiP2UZQvWcKrgLoC_pc_ouUSWv8kHsJJY', tipo: Imagen.URL),
          Imagen(imagen:'https://i.picsum.photos/id/1/5000/3333.jpg?hmac=Asv2DU3rA_5D1xSe22xZK47WEAN0wjWeFOhzd13ujW4', tipo: Imagen.URL),
          Imagen(imagen:'https://i.picsum.photos/id/0/5000/3333.jpg?hmac=_j6ghY5fCfSD6tvtcV74zXivkJSPIfR9B8w34XeQmvU', tipo: Imagen.URL),
          Imagen(imagen:'https://i.picsum.photos/id/10/2500/1667.jpg?hmac=J04WWC_ebchx3WwzbM-Z4_KC_LeLBWr5LZMaAkWkF68', tipo: Imagen.URL),
          Imagen(imagen:'https://i.picsum.photos/id/16/2500/1667.jpg?hmac=uAkZwYc5phCRNFTrV_prJ_0rP0EdwJaZ4ctje2bY7aE', tipo: Imagen.URL),
          Imagen(imagen:'https://i.picsum.photos/id/17/2500/1667.jpg?hmac=HD-JrnNUZjFiP2UZQvWcKrgLoC_pc_ouUSWv8kHsJJY', tipo: Imagen.URL),
          Imagen(imagen:'https://i.picsum.photos/id/1/5000/3333.jpg?hmac=Asv2DU3rA_5D1xSe22xZK47WEAN0wjWeFOhzd13ujW4', tipo: Imagen.URL),
          Imagen(imagen:'https://i.picsum.photos/id/0/5000/3333.jpg?hmac=_j6ghY5fCfSD6tvtcV74zXivkJSPIfR9B8w34XeQmvU', tipo: Imagen.URL),
          Imagen(imagen:'https://i.picsum.photos/id/10/2500/1667.jpg?hmac=J04WWC_ebchx3WwzbM-Z4_KC_LeLBWr5LZMaAkWkF68', tipo: Imagen.URL),
          Imagen(imagen:'https://i.picsum.photos/id/16/2500/1667.jpg?hmac=uAkZwYc5phCRNFTrV_prJ_0rP0EdwJaZ4ctje2bY7aE', tipo: Imagen.URL),
          Imagen(imagen:'https://i.picsum.photos/id/17/2500/1667.jpg?hmac=HD-JrnNUZjFiP2UZQvWcKrgLoC_pc_ouUSWv8kHsJJY', tipo: Imagen.URL),
        ]))
      ]
    ),
  ];

  getAll(){
    return negocios;
  }
  getId(id){
    for (Negocio item in negocios) {
      if(item.id == id){
        return item;
      }
    }
    return null;
  }
  getCorreo(correo){
    for (Negocio item in negocios) {
      if(item.correo == correo){
        return item;
      }
    }
    return null;
  }
  delete(id){
    for (Negocio item in negocios) {
      if(item.id == id){
        negocios.remove(item);
        return true;
      }
    }
    return false;
  }
  edit(Negocio obj){
    for (var i = 0; i < negocios.length; i++) {
      if(negocios[i].id == obj.id){
        negocios[i] = obj;
        return negocios[i];
      }
    }
    return null;
  }
  add(Negocio obj){
    obj.id = '${int.parse(negocios[negocios.length - 1].id) + 1}';
    if(getCorreo(obj.correo)==null){
      negocios.add(obj);
      backendUsuarios.add(obj.correo,obj.numeroIdentificacion,obj.id);
      return true;
    }else{
      return false;
    }
  }
}