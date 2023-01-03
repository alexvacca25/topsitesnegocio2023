import 'package:get/get.dart';
import 'package:topsitesnegocio/app/controllers/sede_controller.dart';
import 'package:topsitesnegocio/app/data/models/sede/informacion_general.dart';
import 'package:topsitesnegocio/app/data/repository/sede_repository.dart';

import '../ui/widgets/input.dart';
import '../ui/widgets/snackbar.dart';
import 'negocio_registro_controller.dart';

class FormImformacionGeneralController extends GetxController {


  RegistroNegocioController negocioController = Get.put(RegistroNegocioController());
  SedeRepository sedeRepository = SedeRepository();
  final informacionGeneral = InformacionGeneral.construir().obs;
  SedeController sedeController = Get.find();

  TextInputController txtNombreSede = TextInputController();
  TextInputController txtTelefono = TextInputController();
  TextInputController txtCelular = TextInputController();
  TextInputController txtDireccion = TextInputController();
  TextInputController txtCorreo = TextInputController();
  TextInputController txtDescripcion = TextInputController();

  final pais = ''.obs;
  final departamento = ''.obs;
  final ciudad = ''.obs;
  
  final errorPais = false.obs;
  final errorDepartamento = false.obs;
  final errorCiudad = false.obs;

  @override
  void onInit() {

    informacionGeneral.value = sedeController.sede.value.informacionGeneral;

    txtNombreSede.controlador.text = informacionGeneral.value.nombre;
    txtTelefono.controlador.text = informacionGeneral.value.telefono;
    txtCelular.controlador.text = informacionGeneral.value.celular;
    txtDireccion.controlador.text = informacionGeneral.value.direccion;
    txtCorreo.controlador.text = informacionGeneral.value.correo;
    txtDescripcion.controlador.text = informacionGeneral.value.descripcion;

    pais.value = informacionGeneral.value.pais.id == '' ? '0' : informacionGeneral.value.pais.id;
    departamento.value = informacionGeneral.value.departamento.id == '' ? '0' : informacionGeneral.value.departamento.id;
    ciudad.value = informacionGeneral.value.ciudad.id == '' ? '0' : informacionGeneral.value.ciudad.id;

    super.onInit();
  }
  

  Future<bool> actualizarImformacionGeneral()async{

    if(!validarCampos()){
      return false;
    }

    try {
      informacionGeneral.value.nombre = txtNombreSede.controlador.text;
      informacionGeneral.value.telefono = txtTelefono.controlador.text;
      informacionGeneral.value.celular = txtCelular.controlador.text;
      informacionGeneral.value.direccion = txtDireccion.controlador.text;
      informacionGeneral.value.correo = txtCorreo.controlador.text;
      informacionGeneral.value.descripcion = txtDescripcion.controlador.text;

      dynamic response = sedeRepository.actualizarInformacionGeneral(sedeController.token!, sedeController.sede.value.id,informacionGeneral.value);
      sedeController.sede.value.informacionGeneral = response;
      sedeController.sede.refresh();
      return true;
    } catch (e) {
      MensajeInferior.porDefecto(titulo: 'Error', mensaje: e.toString());
      return false;
    }
  }
  
  bool validarCampos() {
    if(txtNombreSede.controlador.text.isEmpty){
      txtNombreSede.error.value = 'Debe ingresar el nombre de la sede';
      return false;
    }

    if(txtCelular.error.value.isNotEmpty){
      return false;
    }
    
    if(txtTelefono.error.value.isNotEmpty){
      return false;
    }
    
    if(txtCorreo.controlador.text.isNotEmpty && !txtCorreo.controlador.text.isEmail){
      txtCorreo.error.value = 'Debe ingresar un correo valido';
      return false;
    }

    return true;
  }

}