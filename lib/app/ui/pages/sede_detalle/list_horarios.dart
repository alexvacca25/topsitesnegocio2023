
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:topsitesnegocio/app/data/models/sede/horario_sede.dart';
import 'package:topsitesnegocio/app/ui/widgets/modal.dart';

import '../../../controllers/form_horario_excepciones_controller.dart';
import '../../theme/colores.dart';
import '../../widgets/boton.dart';
import 'form_horario.dart';

class HorariosList extends StatelessWidget {
  
  const HorariosList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FormHorariosExcepcionesController>(
      builder: (_){
        return Container(
          margin: const EdgeInsets.only(bottom: 5, left: 10, right: 10, top: 10),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colores.blancoOscuro,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Horarios'),
                    IconButton(onPressed: (){
                      Modal.child(
                        context,
                        child: FormHorario(horarioAtencion:  HorarioAtencion.construir(), index: null,)
                      );
                    }, icon: const Icon(BootstrapIcons.plus))
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Obx(
                      ()=> _.horario.value.horarioAtencion.isEmpty ? 
                      const SizedBox(height: 300,child: Center(child: Text('No hay horarios'))) : 
                      Column(
                        children: List.generate(
                          _.horario.value.horarioAtencion.length, 
                          (index) => HorarioItem(horarioAtencion: _.horario.value.horarioAtencion[index], index: index)
                        ),
                      )
                    )
                  ),
                ),
              )
            ],
          ),
        );
      }
    );
  }
}

// ignore: must_be_immutable
class HorarioItem extends StatelessWidget {
  
  List diasSemana = [
    'L',
    'M',
    'M',
    'J',
    'V',
    'S',
    'D',
  ];

  final HorarioAtencion horarioAtencion;
  final int index;

  HorarioItem({super.key, required this.horarioAtencion, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FormHorariosExcepcionesController>(
      builder: (_){
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colores.blanco,
          ),
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for(int i = 0; i < diasSemana.length; i++)
                      CircleAvatar(
                        radius: 10,
                        backgroundColor: horarioAtencion.diasSemana[i] ? Colores.verde : Colores.gris,
                        child: Text('${diasSemana[i]}', style: const TextStyle(fontSize: 8, color: Colores.blanco)),
                      ),
                    //end for
                  ],
                )
              ),
              const SizedBox(width: 5,),
              Expanded(
                child: Text(
                  '${horarioAtencion.strHoraInicio} - ${horarioAtencion.strHoraFin}  \n ${horarioAtencion.cantidadMaxPersonas} personas máx', 
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12),
                )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Boton(
                    accion: (){
                      Modal.porDefecto(
                        context,
                        child: const Text('¿Quieres eliminar este horario?'),
                        onAceptar: (){
                          Get.back();
                          _.eliminarHorario(index);
                        }
                      );
                    },
                    color: Colores.rojo,
                    child: const Icon(BootstrapIcons.trash, color: Colores.blanco,),
                  ),
                  const SizedBox(width: 10,),
                  Boton(
                    accion: (){
                      Modal.child(
                        context,
                        child: FormHorario(horarioAtencion:  horarioAtencion,index:  index,)
                      );
                    },
                    color: Colores.verde,
                    child: const Icon(BootstrapIcons.pencil, color: Colores.blanco,),
                  )
                ],
              ),
            ],
          ),
        );
      }
    );
  }
}


