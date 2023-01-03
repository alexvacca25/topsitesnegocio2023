import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:topsitesnegocio/app/ui/theme/colores.dart';
import 'package:topsitesnegocio/app/ui/widgets/boton.dart';
import 'package:topsitesnegocio/app/ui/widgets/input.dart';
import 'package:topsitesnegocio/app/ui/widgets/modal.dart';

import '../../../data/models/sede/combo_plan.dart';


class FormTicket extends StatelessWidget {
  FormTicket({super.key, this.comboPlan});
  final ComboPlan? comboPlan;

  @override
  Widget build(BuildContext context) {
    return Responsive(comboPlan: comboPlan ?? ComboPlan());
  }
}
class Responsive extends GetResponsiveView {

  final cambia = false.obs;
  final ComboPlan comboPlan;
  
  Responsive({
    required this.comboPlan,
  });

  @override
  Widget builder() {
    return Builder(
      builder: (BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Ticket'),
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
            }, icon: Icon(BootstrapIcons.x))
          ],
        ),
        floatingActionButton: Wrap(
          direction: Axis.horizontal, 
            children: [
              Container(child: Boton(
                accion: ()=>Get.back(),
                child: Text('Cancelar'),color: Colores.gris,)
              ),
              SizedBox(width: 10,),
              Container(child: Boton(
                accion: ()=>Get.back(result: comboPlan),
                child: Text('Guardar'),color: Colores.verde,)),
            ],
        ),
        body: Obx(
          () {
            cambia.value;
            return ListView(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                color: Colores.blancoOscuro,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Inputs(controller: TextInputController().init(comboPlan.nombre), titulo: 'Valor',onChanged: (str){comboPlan.nombre = str!;},),
                    Row(
                      children: [
                        Expanded(child: Inputs(controller: TextInputController().init(comboPlan.descripcion), titulo: 'Cantidad máx por ticket',onChanged: (str){comboPlan.descripcion = str!;},)),
                        SizedBox(width: 10,),
                        Expanded(child: Inputs(controller: TextInputController().init(comboPlan.descripcion), titulo: 'Cantidad máx por lugar',onChanged: (str){comboPlan.descripcion = str!;},)),
                      ],
                    ),
                    
                    Row(
                      children: [
                        Expanded(child: DropdownButton(isExpanded: true, items: List.generate(101, (index) => DropdownMenuItem(child: Text('$index% de descuento'),value: '$index')), value: '0', onChanged: (value){})),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 100,),
            ],
          );
        }
        )
      ),
    );
  }
}
