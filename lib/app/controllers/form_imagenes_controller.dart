import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:topsitesnegocio/app/controllers/sede_controller.dart';
import 'package:topsitesnegocio/app/data/models/sede/imagenes_sede.dart';

import '../data/repository/sede_repository.dart';
import '../ui/widgets/file_picker.dart';
import '../ui/widgets/snackbar.dart';

class FormImagenesController extends GetxController {
  
  
  SedeRepository repository = SedeRepository();
  SedeController sedeController = Get.find();  

  final fotoPrincipal = Imagen().obs;
  final fotoLogo = Imagen().obs;
  final fotosAdicionales = <Imagen>[].obs;


  @override
  void onInit() {
    fotoPrincipal.value = sedeController.sede.value.imagenesSede.fotoPrincipal;
    fotoLogo.value = sedeController.sede.value.imagenesSede.fotoLogo;
    fotosAdicionales.value = sedeController.sede.value.imagenesSede.fotosAdicionales;

    super.onInit();
  }

  actualizarFotoPrincipal()async{
    PlatformFile? result = await Files.obtenerImagen();
    if (result != null) {
      if(GetPlatform.isWeb){
        fotoPrincipal.value.imagen = result.bytes;
      }else{
        fotoPrincipal.value.imagen = result.path;
      }
      fotoPrincipal.value.tipo = Imagen.FILE;
      fotoPrincipal.refresh();
    } 
  }

  actualizarFotoLogo ()async{
    PlatformFile? result = await Files.obtenerImagen();
    if (result != null) {
      fotoLogo.value.imagen = result.bytes!;
      fotoLogo.value.tipo = Imagen.FILE;
      fotoLogo.refresh();
    } 
  }
  agregarImagenAdicional()async{
    PlatformFile? result = await Files.obtenerImagen();
    if (result != null) {
      fotosAdicionales.value.add(Imagen(imagen:result.bytes!, tipo: Imagen.FILE));
      fotosAdicionales.refresh();
    } 
  }

  quitarImagenAdicional(index){
    fotosAdicionales.value.removeAt(index);
    fotosAdicionales.refresh();  
  }

  Future<bool> actualizar()async{
    try {
      ImagenesSede imagenesSede = ImagenesSede.construir(fotoLogo: fotoLogo.value, fotoPrincipal: fotoPrincipal.value, fotosAdicionales: fotosAdicionales.value);
      dynamic response = await repository.actualizarImagenes(sedeController.token!, sedeController.sede.value.id, imagenesSede);
      sedeController.sede.value.imagenesSede = response;
      sedeController.sede.refresh();
      return true;
    } catch (e) {
      MensajeInferior.porDefecto(titulo: 'Error', mensaje: e.toString());
      return false;
    }
  }
}