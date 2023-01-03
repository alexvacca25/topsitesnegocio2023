

import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:topsitesnegocio/app/controllers/form_horario_excepciones_controller.dart';
import 'package:topsitesnegocio/app/data/models/sede/horario_sede.dart';

import '../../theme/colores.dart';
import '../../widgets/boton.dart';
import '../../widgets/date_picker.dart';
import '../../widgets/time_picker.dart';

// ignore: must_be_immutable
class FormExcepcion extends StatelessWidget {

  List diasSemana = [
    'L',
    'M',
    'M',
    'J',
    'V',
    'S',
    'D',
  ];

  final cambiaDiaSemana = false.obs;
  final cambiaTipoExcepcion = false.obs;
  final cambiaHoraInicio = false.obs;
  final cambiaHoraFin = false.obs;
  final cambiaFechaInicio = false.obs;
  final cambiaFechaFin = false.obs;

  final Excepcion excepcion;
  final int? index;

  FormExcepcion({
    super.key, 
    required this.excepcion, 
    this.index,
  });
  

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FormHorariosExcepcionesController>(
      builder: (_){
        return Scaffold(
          appBar: AppBar(
            title: Text('${index == null ? 'Agregar' : 'Editar'} excepción'),
            backgroundColor: Colores.negro,
            automaticallyImplyLeading: false,
            actions: [
              IconButton(onPressed: ()=>Get.back(), icon: const Icon(BootstrapIcons.x))
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
                accion: (){
                  Get.back();
                  _.agregarEditarExcepcion(excepcion, index);
                },
                color: Colores.verde,
                child: const Text('Guardar'),
              ),
              ],
          ),
          body: ListView(
            padding: EdgeInsets.all(20),
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Excepcion por:'
                    ),
                  ),
                  Expanded(
                    child: tipoExepcion(1, 'Dia'),
                  ),
                  Expanded(
                    child: tipoExepcion(0, 'Fecha'),
                  ),
                ],
              ),
              Obx(
                () {
                  cambiaTipoExcepcion.value;
                  return excepcion.excepcionPor == 0 ? fechaSelect(context) : diaSemanaSelect();
                }
              ),
              
              const SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: ()async{
                          excepcion.horaInicio = await TimePicker().porDefecto(context, hour: excepcion.horaInicio) ?? excepcion.horaInicio;
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
                                    '${excepcion.strHoraInicio}',
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
                          excepcion.horaFin = await TimePicker().porDefecto(context, hour: excepcion.horaFin) ?? excepcion.horaFin;
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
                              Obx(
                                (){
                                  cambiaHoraFin.value;
                                  return Text(
                                  '${excepcion.strHoraFin}',
                                  style: const TextStyle(
                                    fontSize: 20,  
                                    color: Colores.blanco                        
                                  ),
                                );
                                }
                              ),
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

  Column fechaSelect(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10,),
        const Text('Fecha'),
        const SizedBox(height: 10,),
        Row(
          children: [
            Expanded(
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: ()async{
                    excepcion.fechaInicio = await DatePicker().porDefecto(context) ?? excepcion.fechaInicio;
                    cambiaFechaInicio.value = !cambiaFechaInicio.value;
                  },
                  child: Container(    
                    padding: EdgeInsets.all(9),                          
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colores.negro,
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Obx(
                          (){
                            cambiaFechaInicio.value;
                            return Text(
                            '${excepcion.strFechaInicio}',
                            style: const TextStyle(
                              fontSize: 15,  
                              color: Colores.blanco                        
                            ),
                          );
                          }
                        ),
                        const Text(
                          'Fecha inicio',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colores.blanco
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10,),
            Expanded(
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: ()async{
                    excepcion.fechaFin = await DatePicker().porDefecto(context) ?? excepcion.fechaFin;
                    cambiaFechaFin.value = !cambiaFechaFin.value;
                  },
                  child: Container(    
                    padding: const EdgeInsets.all(9),                          
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colores.negro,
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Obx((){
                          cambiaFechaFin.value;
                          return Text(
                            '${excepcion.strFechaFin}',
                            style: const TextStyle(
                              fontSize: 15,  
                              color: Colores.blanco                        
                            ),
                          );
                        }),
                        const Text(
                          'Fecha fin',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colores.blanco
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column diaSemanaSelect() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10,),
        const Text('Dia de la semana'),
        const SizedBox(height: 10,),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colores.negro,
            borderRadius: BorderRadius.circular(5)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for(int i = 0; i < excepcion.diasSemana.length; i++)
              Expanded(
                child: Obx(
                  (){
                    cambiaDiaSemana.value;
                    return ChoiceChip(
                      padding: const EdgeInsets.all(5),
                      label: Text('${diasSemana[i]}'),
                      selected: excepcion.diasSemana[i],
                      onSelected: (value){
                        excepcion.diasSemana[i] = value;
                        cambiaDiaSemana.value = !cambiaDiaSemana.value;
                      },
                      selectedColor: excepcion.diasSemana[i] ? Colores.verde : Colores.grisClaro,
                    );
                  }
                )
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row tipoExepcion(tipo, texto) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx((){
          cambiaTipoExcepcion.value;
          return Radio(
            value: '$tipo',
            groupValue: '${excepcion.excepcionPor}',
            onChanged: (value) {
              excepcion.excepcionPor = int.parse(value!);
              cambiaTipoExcepcion.value = !cambiaTipoExcepcion.value;
            },
          );
        }),
        Expanded(child: Text(texto))
      ],
    );
  }
}
