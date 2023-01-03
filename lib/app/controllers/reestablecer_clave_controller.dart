import 'package:get/get.dart';
import 'package:topsitesnegocio/app/routes/app_pages.dart';

import '../data/repository/sesion_repository.dart';
import '../ui/widgets/input.dart';

class ReestablecerClaveController extends GetxController {

  
  TextInputController txtNuevaClave = TextInputController();
  TextInputController txtConfirmacionNuevaClave = TextInputController();

  // SesionRepository sesionRepository = Get.find();
  String? token = '';

  @override
  void onReady() async{
    token = Get.parameters['token'];
    if(token==null){
      Get.offAllNamed(Routes.LOGIN);
      return;
    }

    // bool respuesta = await sesionRepository.tokenValido(token!);

    // if(!respuesta){
    //   Get.offAllNamed(Routes.LOGIN);
    //   return;
    // }

    super.onReady();
  }

  Future<bool?> actualizarCLave() async {
    if(!validar()){
      return null;
    }
    return true;
  }

  validar(){
    bool correcto = true;
    if(txtNuevaClave.controlador.text.isEmpty){
      txtNuevaClave.error.value = 'Debe ingresar la contraseña';
      correcto = false;
    }
    if(txtConfirmacionNuevaClave.controlador.text.isEmpty){
      txtConfirmacionNuevaClave.error.value = 'Debe ingresar la confirmacion de contraseña';
      correcto = false;
    }
    if(txtNuevaClave.controlador.text != txtConfirmacionNuevaClave.controlador.text){
      txtConfirmacionNuevaClave.error.value = 'Las contraseñas no coinciden';
      correcto = false;
    }
    return correcto;
  }




}