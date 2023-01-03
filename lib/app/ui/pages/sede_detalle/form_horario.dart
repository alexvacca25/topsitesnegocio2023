
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:topsitesnegocio/app/data/models/sede/horario_sede.dart';
import 'package:topsitesnegocio/app/ui/widgets/time_picker.dart';

import '../../../controllers/form_horario_excepciones_controller.dart';
import '../../theme/colores.dart';
import '../../widgets/boton.dart';
import '../../widgets/input.dart';

class FormHorario extends StatelessWidget {

  List diasSemana = [
    'L',
    'M',
    'M',
    'J',
    'V',
    'S',
    'D',
  ];

  final cambiaDiasSeleccionados = false.obs;

  final cambiaHoraInicio = false.obs;
  final cambiaHoraFin = false.obs;

  final HorarioAtencion horarioAtencion;
  final int? index;

  TextInputController txtCantidad = TextInputController();


  FormHorario({super.key, required this.horarioAtencion, required this.index});

  @override
  Widget build(BuildContext context) {

    txtCantidad.controlador.text = '${horarioAtencion.cantidadMaxPersonas == 0 ? '' : horarioAtencion.cantidadMaxPersonas}';

    return GetBuilder<FormHorariosExcepcionesController>(
      builder: (_){
        return Scaffold(
          appBar: AppBar(
            title: Text('${index == null ? 'Agregar' : 'Editar'} horario'),
            backgroundColor: Colores.negro,
            automaticallyImplyLeading: false,
            actions: [
              IconButton(onPressed: ()=>Get.back(), icon: Icon(BootstrapIcons.x))
            ],
          ),
          floatingActionButton: Wrap(
            direction: Axis.horizontal, 
              children: [
                Boton(
                  accion: ()=>Get.back(),
                  color: Colores.gris,
                  child: const Text('Cancelar'),
                ),
                const SizedBox(width: 10,),
                Boton(
                  accion: ()async{
                    if(txtCantidad.error.isNotEmpty){
                      return;
                    }
                    
                    try {
                      horarioAtencion.cantidadMaxPersonas = int.parse(txtCantidad.controlador.text.isEmpty ? '0' : txtCantidad.controlador.text);
                      if(horarioAtencion.cantidadMaxPersonas < 0){
                        throw '';
                      }
                    } catch (e) {
                      txtCantidad.error.value = 'número no valido';
                      return;
                    }

                    _.agregarEditarHorario(horarioAtencion, index);
                    Get.back();
                  },
                  color: Colores.verde,
                  colorHover: Colores.verdeOscuro,
                  child: const Text('Guardar'),
                ),
              ],
          ),
          body: ListView(
            padding: EdgeInsets.all(20),
            children: [
              Inputs(
                titulo: 'Cantidad máxima de personas',
                controller: txtCantidad,
                tipoTeclado: TextInputType.number,
              ),
              const SizedBox(height: 10,),
              const Text('Dia de la semana'),
              const SizedBox(height: 10,),
              Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colores.negro,
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for(int i = 0; i < diasSemana.length; i++)
                      Expanded(
                        child: Obx(
                          () {
                            cambiaDiasSeleccionados.value;
                            return ChoiceChip(
                              padding: const EdgeInsets.all(5),
                              label: Text('${diasSemana[i]}'),
                              selected: horarioAtencion.diasSemana[i],
                              onSelected: (bool){
                                horarioAtencion.diasSemana[i] = bool;
                                cambiaDiasSeleccionados.value = !cambiaDiasSeleccionados.value;
                              },
                              selectedColor: horarioAtencion.diasSemana[i] ? Colores.verde : Colores.grisClaro,
                            );
                          }
                        )
                      ),
                      
                    ],
                  ),
                ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: ()async{
                          horarioAtencion.horaInicio = await TimePicker().porDefecto(context, hour: horarioAtencion.horaInicio) ?? horarioAtencion.horaInicio;
                          cambiaHoraInicio.value = !cambiaHoraInicio.value;
                        },
                        child: Container(                  
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colores.amarillo,
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Obx(
                                (){
                                  cambiaHoraInicio.value;
                                  return Text(
                                    horarioAtencion.strHoraInicio,
                                    style: const TextStyle(
                                      fontSize: 20,                          
                                    ),
                                  );
                                }
                              ),
                              const Text('Hora inicio'),
                            ],
                          ),
                        ),
                      ),
                    )
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: ()async{
                          horarioAtencion.horaFin = await TimePicker().porDefecto(context, hour: horarioAtencion.horaFin) ?? horarioAtencion.horaFin;
                          cambiaHoraFin.value = !cambiaHoraFin.value;
                        },
                        child: Container(                  
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colores.negro,
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Obx((){
                                cambiaHoraFin.value;
                                return Text(
                                  horarioAtencion.strHoraFin,
                                  style: const TextStyle(
                                    fontSize: 20,  
                                    color: Colores.blanco                        
                                  ),
                                );
                              }),
                              const Text(
                                'Hora fin',
                                style: TextStyle(
                                  color: Colores.blanco
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ),
                ],
              )
            ],
          ),
        );
      }
    );
  }
}


class TiempoPermitidoReserva extends StatelessWidget {

  List<int> minutos = [15, 30, 60];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FormHorariosExcepcionesController>(
      builder: (_){
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colores.blancoOscuro,
          ),
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              const Expanded(child: Text('Permitir reserva cada:')),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      for(int i=0; i<minutos.length; i++)
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: ()async{
                              if(_.horario.value.permitirReservarCada != minutos[i]){
                                _.horario.value.permitirReservarCada = minutos[i];
                                _.horario.refresh();
                              }
                            },
                            child: Obx(() => Container(
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: _.horario.value.permitirReservarCada == minutos[i] ? Colores.verde : Colores.grisClaro,
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${minutos[i]} MIN', 
                                    style: const TextStyle(
                                      color: Colores.blanco,
                                      fontSize: 12
                                    ),
                                  ),
                                ],
                              ),
                            ))
                          ),
                        ),
                      //end for
                    ],
                  ),
                )
              )
            ],
          ),
        );
      }
    );
  }
}
class TiempoMinimoReserva extends StatelessWidget {

  List minutos = [15,30, 60];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FormHorariosExcepcionesController>(
      builder: (_){
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colores.blancoOscuro,
          ),
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              const Expanded(child: Text('Tiempo minimo para reservar:')),
              Expanded(child: Inputs(controller: _.txtDias, titulo: 'Dias', tipoTeclado: TextInputType.number,),),
              SizedBox(width: 5,),
              Expanded(child: Inputs(controller: _.txtHorasReserva, titulo: 'Horas', tipoTeclado: TextInputType.number),),
            ],
          ),
        );
      }
    );
  }
}
class TiempoPermitidoCancelacion extends StatelessWidget {

  List minutos = [15,30, 60];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FormHorariosExcepcionesController>(
      builder: (_){
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colores.blancoOscuro,
          ),
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              const Expanded(child: Text('Tiempo permitido para cancelación')),
              SizedBox(width: 5,),
              Expanded(child: Inputs(controller: _.txtHorasCancalacion, titulo: 'Horas', tipoTeclado: TextInputType.number),),
            ],
          ),
        );
      }
    );
  }
}
