import 'package:get/get.dart';
import 'package:topsitesnegocio/app/data/models/cliente.dart';
import 'package:topsitesnegocio/app/data/models/locacion.dart';
import 'package:topsitesnegocio/app/data/models/negocio.dart';
import 'package:topsitesnegocio/app/data/models/red.dart';
import 'package:topsitesnegocio/app/ui/widgets/input.dart';
import 'package:topsitesnegocio/app/ui/widgets/snackbar.dart';

import '../data/models/promedio_venta_mes.dart';
import '../data/repository/negocio_repository.dart';

class RegistroNegocioController extends GetxController {

  // SesionController sesionController = Get.find();
  // TipoServicioRepository tipoServicio = Get.find();
  // NegocioRepository negocioRepository = Get.find();

  NegocioRepository negocioRepository = NegocioRepository();

  final paises = <Pais>[].obs;
  final departamentos = <Departamento>[].obs;
  final ciudades = <Ciudad>[].obs;
  final promedioVentaMes = <PromedioVentaMes>[].obs;

  @override
  void onInit() {
    paises.value = [Pais(id: '0',nombre: 'Pais'), Pais(id: '1',nombre: 'Pais 1')] ;
    departamentos.value = [Departamento(id:'0',nombre: 'Departamento'), Departamento(id:'1',nombre: 'Departamento 1')];
    ciudades.value = [Ciudad(id:'0',nombre: 'Ciudad'), Ciudad(id:'1',nombre: 'Ciudad 1')];
    promedioVentaMes.value = [PromedioVentaMes(id:'0',promedioVenta: 'Promedio de ventas al mes'), PromedioVentaMes(id:'1',promedioVenta: 'Promedio de ventas al mes 1')];
    super.onInit();
  }

  TextInputController txtNumeroIdentificacion = TextInputController();
  TextInputController txtNombreNegocio = TextInputController();
  TextInputController txtNombreContacto = TextInputController();
  TextInputController txtDireccion = TextInputController();
  TextInputController txtNumeroContacto = TextInputController();
  TextInputController txtCorreo = TextInputController();
  TextInputController txtConfirmacionCorreo = TextInputController();
  TextInputController txtInstagram = TextInputController();
  TextInputController txtMensaje = TextInputController();

  final tipoPersonaSeleccionado = 'Tipo de persona'.obs;
  final paisSeleccionado = 'Pais'.obs;
  final departamentoSeleccionado = 'Departamento'.obs;
  final ciudadSeleccionado = 'Ciudad'.obs;
  final promedioVentasSeleccionado = 'Promedio de ventas al mes'.obs;

  Future<void> registrarNegocio()async{
    
    /**
     * condicional para saber si continua el metodo
     * dependiendo de lo que retorne el validar campos negocio
     */
    if(validarComposRegistroNegocio()){
      return;
    }
    
    Negocio negocio = Negocio.construir(
      tipoPersona : tipoPersonaSeleccionado.value,
      numeroIdentificacion : txtNumeroContacto.controlador.text,
      nombreNegocio : txtNombreNegocio.controlador.text,
      nombreContacto : txtNombreContacto.controlador.text,
      pais : Pais(id: '',nombre: paisSeleccionado.value),
      departamento : Departamento(id: '', nombre: departamentoSeleccionado.value),
      ciudad : Ciudad(id:'', nombre: ciudadSeleccionado.value),
      direccion : txtDireccion.controlador.text,
      numeroContacto: txtNumeroContacto.controlador.text,
      correo: txtCorreo.controlador.text,
      promedioVentaMes: PromedioVentaMes(promedioVenta: promedioVentasSeleccionado.value),
      redesSociales: [Red(url: txtInstagram.controlador.text)],
      mensaje: txtMensaje.controlador.text,
      estado: true,
      cuentaVerificada: false,
      usuario: Usuario.construir(correo: txtCorreo.controlador.text, clave: txtNumeroIdentificacion.controlador.text)
    );

    try {
      await negocioRepository.add(negocio);
      Get.back();
      MensajeInferior.porDefecto(titulo: 'Registrado', mensaje: 'Registrado correctamente');
    } catch (e) {
      MensajeInferior.porDefecto(titulo: 'Error', mensaje: e.toString());
    }

  }

  /**
   * Metodo validarComposRegistroNegocio
   * valida todos los campos del formulario registro de negocio
   * y asigna los respectivos mensajes de error
   * si hay error retorna true sino retorna false
   */
  validarComposRegistroNegocio(){
    bool error = false;
    String requerido = 'Este campo es requerido';
    String esNumerico = 'Este campo es numerico';
    String esCorreo = 'Debe ingresar un correo valido';
    
    if(txtCorreo.controlador.text != txtConfirmacionCorreo.controlador.text){
      txtConfirmacionCorreo.error.value = 'Los correos no coinciden';
      error = true;
    }

    if(!txtNumeroIdentificacion.controlador.text.isNum){
      txtNumeroIdentificacion.error.value = esNumerico;
      error = true;
    }
    if(txtNumeroIdentificacion.controlador.text.isEmpty){
      txtNumeroIdentificacion.error.value = requerido;
      error = true;
    }
    if(txtNombreNegocio.controlador.text.isEmpty){
      txtNombreNegocio.error.value = requerido;
      error = true;
    }
    if(txtNombreContacto.controlador.text.isEmpty){
      txtNombreContacto.error.value = requerido;
      error = true;
    }
    if(txtDireccion.controlador.text.isEmpty){
      txtDireccion.error.value = requerido;
      error = true;
    }
    if(!txtNumeroContacto.controlador.text.isNum){
      txtNumeroContacto.error.value = esNumerico;
      error = true;
    }
    if(txtNumeroContacto.controlador.text.isEmpty){
      txtNumeroContacto.error.value = requerido;
      error = true;
    }
    if(!txtCorreo.controlador.text.isEmail){
      txtCorreo.error.value = esCorreo;
      error = true;
    }
    if(txtCorreo.controlador.text.isEmpty){
      txtCorreo.error.value = requerido;
      error = true;
    }
    if(!txtConfirmacionCorreo.controlador.text.isEmail){
      txtConfirmacionCorreo.error.value = esCorreo;
      error = true;
    }
    if(txtConfirmacionCorreo.controlador.text.isEmpty){
      txtConfirmacionCorreo.error.value = requerido;
      error = true;
    }
    if(txtInstagram.controlador.text.isEmpty){
      txtInstagram.error.value = requerido;
      error = true;
    }
    if(txtMensaje.controlador.text.isEmpty){
      txtMensaje.error.value = requerido;
      error = true;
    }
    return error;
  }

}