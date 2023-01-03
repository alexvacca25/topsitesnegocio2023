import 'package:get/get.dart';
import 'package:topsitesnegocio/app/controllers/sede_controller.dart';
import 'package:topsitesnegocio/app/data/models/sede/horario_sede.dart';

import '../data/repository/sede_repository.dart';
import '../ui/widgets/input.dart';
import '../ui/widgets/snackbar.dart';

class FormHorariosExcepcionesController extends GetxController {
  
  SedeRepository repository = SedeRepository();
  SedeController sedeController = Get.find();  
  final horario = Horario.construir() .obs;

  TextInputController txtDias = TextInputController();
  TextInputController txtHorasReserva = TextInputController();
  TextInputController txtHorasCancalacion = TextInputController();


  @override
  void onInit() {
    
    horario.value = sedeController.sede.value.horario;

    txtDias.controlador.text = horario.value.tempoMinimoReservarDias.toString();
    txtHorasReserva.controlador.text = horario.value.tempoMinimoReservarHoras.toString();
    txtHorasCancalacion.controlador.text = horario.value.tiempoCancelacion.toString();

    super.onInit();
  }


  Future<bool> actualizar()async{
    try {
      horario.value.tempoMinimoReservarDias = int.parse(txtDias.controlador.text);
      horario.value.tempoMinimoReservarHoras = int.parse(txtHorasReserva.controlador.text);
      horario.value.tiempoCancelacion = int.parse(txtHorasCancalacion.controlador.text);

      dynamic response = await repository.actualizarHorario(sedeController.token!, sedeController.sede.value.id, horario.value);
      sedeController.sede.value.horario = response;
      sedeController.sede.refresh();
      return true;

    } catch (e) {
      MensajeInferior.porDefecto(titulo: 'Error', mensaje: e.toString());
      return false;
    }
  }

  agregarEditarHorario(HorarioAtencion horarioAtencion, int? index){
    if(index==null){
      horario.value.horarioAtencion.add(horarioAtencion);
    }else{
      horario.value.horarioAtencion[index] = horarioAtencion;
    }
    horario.refresh();
  }
  eliminarHorario(index){
    horario.value.horarioAtencion.removeAt(index);
    horario.refresh();
  }
  agregarEditarExcepcion(Excepcion excepcion, int? index){
    if(index==null){
      horario.value.excepciones.add(excepcion);
    }else{
      horario.value.excepciones[index] = excepcion;
    }
    horario.refresh();
  }
  eliminarExcepcion(index){
    horario.value.excepciones.removeAt(index);
    horario.refresh();
  }
}