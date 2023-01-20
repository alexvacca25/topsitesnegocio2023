import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:topsitesnegocio/app/ui/widgets/input.dart';
import 'package:topsitesnegocio/app/ui/widgets/input_hora.dart';

import '../../theme/colores.dart';
import '../../widgets/boton.dart';
import '../../widgets/modal.dart';

class FormValoresUbicacionPage extends GetView{

  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
              },
              color: Colores.verde,
              child: const Text('Guardar'),
            ),
          ],
      ),
    appBar: AppBar(
      title: const Text('Asignar valores'),
      backgroundColor: Colores.negro,
      automaticallyImplyLeading: false,
      actions: [
        IconButton(onPressed: (){
          Modal.porDefecto(
            context, 
            child: const Text('¿Seguro que quieres cerrar?'), 
            onAceptar: (){
              Get.back();
              Get.back();
            }
          );
        }, icon: const Icon(BootstrapIcons.x))
      ],
    ),

      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Ubicaciones'),
              IconButton(
                onPressed: (){

                },
                icon: Icon(BootstrapIcons.plus),
              ),
            ],
          ),
          const SizedBox(height:10),
          Container(
            decoration: BoxDecoration(
              color: Colores.blancoOscuro,
              borderRadius: BorderRadius.circular(5)
            ),
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Column(
                  children: [
                    Wrap(
                      children: [

                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: InputsHora(getHora: (value){}, horaInicial: TimeOfDay.now(), hora: '12:00 p.m',)),
                    Text('-'),
                    Expanded(child: InputsHora(getHora: (value){}, horaInicial: TimeOfDay.now(), hora: '12:00 p.m')),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: Inputs(controller: TextInputController(), titulo: 'Valor',tipoTeclado: TextInputType.number,)),
                    SizedBox(width: 10,),
                    Expanded(
                      child: DropdownButton(
                          items: List.generate(
                              101,
                              (index) => DropdownMenuItem(
                              value: '$index',
                              child: Text(
                                '$index% descuento'
                              ), 
                            )
                          ),
                          value: '0',
                          onChanged: (value) {

                          }),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      )
    );
  }
}