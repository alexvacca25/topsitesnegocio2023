
import 'package:get/get.dart';
import 'package:topsitesnegocio/app/controllers/sede_controller.dart';
import 'package:topsitesnegocio/app/data/models/sede/pago_cobro.dart';

import '../data/repository/sede_repository.dart';
import '../ui/widgets/input.dart';
import '../ui/widgets/snackbar.dart';

class FormPagosCobrosController extends GetxController {

  
  SedeRepository repository = SedeRepository();
  SedeController sedeController = Get.find();

  final pagoCobro = PagoCobro().obs;

  final tipoDocumento = ''.obs;
  final tipoBanco = ''.obs;
  final tipoCuenta = ''.obs;

  final errorTipoDocumento = false.obs;
  final errorTipoBanco = false.obs;
  final errorTipoCuenta = false.obs;

  TextInputController txtNumeroDocumento = TextInputController();
  TextInputController txtNumeroCuenta = TextInputController();
  
  @override
  void onInit() {
    
    pagoCobro.value = sedeController.sede.value.pagoCobro;

    tipoDocumento.value = pagoCobro.value.tipoDocumento == '' ? '0' : pagoCobro.value.tipoDocumento ;
    tipoBanco.value = pagoCobro.value.tipoBanco == '' ? '0' : pagoCobro.value.tipoBanco ;
    tipoCuenta.value = pagoCobro.value.tipoCuenta == '' ? '0' : pagoCobro.value.tipoCuenta ;

    txtNumeroDocumento.controlador.text = pagoCobro.value.documento;
    txtNumeroCuenta.controlador.text = pagoCobro.value.numeroCuenta;


    super.onInit();
  }

  Future<bool> actualizar()async{

    if(!validarCampos()){
      return false;
    }

    try {

      pagoCobro.value.tipoDocumento = tipoDocumento.value;
      pagoCobro.value.tipoBanco = tipoBanco.value;
      pagoCobro.value.tipoCuenta = tipoCuenta.value;

      pagoCobro.value.documento = txtNumeroDocumento.controlador.text;
      pagoCobro.value.numeroCuenta = txtNumeroCuenta.controlador.text;

      dynamic response = await repository.actualizarPagoCobro(sedeController.token!, sedeController.sede.value.id, pagoCobro.value);
      sedeController.sede.value.pagoCobro = response;
      sedeController.sede.refresh();
      return true;
    } catch (e) {
      MensajeInferior.porDefecto(titulo: 'Error', mensaje: e.toString());
      return false;
    }
  }

  validarCampos(){

    txtNumeroDocumento.error.value = txtNumeroDocumento.error.value.isEmpty ? txtNumeroDocumento.controlador.text.isEmpty ? 'Campo requerido'  : '' : txtNumeroDocumento.error.value;
    txtNumeroCuenta.error.value = txtNumeroCuenta.error.value.isEmpty ? txtNumeroCuenta.controlador.text.isEmpty ? 'Campo requerido'  : '' : txtNumeroCuenta.error.value;

    bool isError = false;

    if(tipoDocumento.value=='0'){
      errorTipoDocumento.value = true;
      isError = true;
    }
    if(tipoBanco.value=='0'){
      errorTipoBanco.value = true;
      isError = true;
    }
    if(tipoCuenta.value=='0'){
      errorTipoCuenta.value = true;
      isError = true;
    }

    if(txtNumeroCuenta.error.value.isNotEmpty){
      isError = true;
    }

    if(txtNumeroDocumento.error.value.isNotEmpty){
      isError = true;
    }

    return !isError;
  }

}