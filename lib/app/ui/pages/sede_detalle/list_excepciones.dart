
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:topsitesnegocio/app/controllers/form_horario_excepciones_controller.dart';

import '../../../data/models/sede/horario_sede.dart';
import '../../theme/colores.dart';
import '../../widgets/boton.dart';
import '../../widgets/modal.dart';
import 'form_excepcion.dart';

class ListExcepcion extends StatelessWidget {
  
  const ListExcepcion({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FormHorariosExcepcionesController>(
      builder: (_){
        return Container(
          margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 5),
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
                    const Text('Excepciones'),
                    IconButton(onPressed: (){
                      Modal.child(
                        context,
                        child: FormExcepcion(excepcion: Excepcion.construir(),)
                      );
                    },icon: Icon(BootstrapIcons.plus))
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  primary: false,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Obx(
                      ()=>Column(
                        children: List.generate(
                          _.horario.value.excepciones.length, 
                          (index) => ItemExcepcion(excepcion: _.horario.value.excepciones[index], index: index)
                        ),
                      ),
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

class ItemExcepcion extends StatelessWidget {
  
  ItemExcepcion({
    Key? key,
    required this.index, 
    required this.excepcion,
  }) : super(key: key);

  final int index;
  final Excepcion excepcion;

  List diasSemana = [
    'L',
    'M',
    'M',
    'J',
    'V',
    'S',
    'D',
  ];

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
                child: excepcion.excepcionPor == 0 ? Text('${excepcion.strFechaInicio} - ${excepcion.strFechaFin}', style: const TextStyle(fontSize: 10),) : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for(int i = 0; i < diasSemana.length; i++)
                      CircleAvatar(
                        radius: 10,
                        backgroundColor: excepcion.diasSemana[i] ? Colores.verde : Colores.gris,
                        child: Text('${diasSemana[i]}', style: const TextStyle(fontSize: 8, color: Colores.blanco)),
                      ),
                    //end for
                  ],
                )
              ),
              const SizedBox(width: 5,),
              Expanded(
                child: Text('${excepcion.strHoraInicio} - ${excepcion.strHoraFin}', style: const TextStyle(fontSize: 10))
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Boton(
                    accion: (){
                      Modal.porDefecto(
                        context,
                        child: const Text('¿Quieres eliminar esta excepcion?'),
                        onAceptar: (){
                          Get.back();
                          _.eliminarExcepcion(index);
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
                        child: FormExcepcion(excepcion: excepcion, index: index,)
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
