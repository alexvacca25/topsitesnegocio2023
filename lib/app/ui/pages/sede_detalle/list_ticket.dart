import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:topsitesnegocio/app/ui/widgets/boton.dart';
import 'package:topsitesnegocio/app/ui/widgets/input.dart';

import '../../../controllers/sede_controller.dart';
import '../../theme/colores.dart';
import '../../widgets/modal.dart';
import '../../widgets/tarjeta.dart';
import 'form_ticket.dart';
class ListTicketsPage extends GetView {
  
  const ListTicketsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SedeController>(
      builder: (_){
        return LayoutBuilder(
          builder: (context,constraints){
            dynamic width = constraints.maxWidth;
            dynamic widthTarjeta = width < 580 ? Get.width : ((600 / 2) - 20);
            return Column(
              children: [
                TiempoPermitidoCompra(),
                Row(
                  children: [
                    Expanded(child: Inputs(controller: TextInputController(), titulo: 'Tiempo permitido para cancelación en horas',)),
                    SizedBox(width: 10,),
                    Boton(
                      accion: (){},
                      color: Colores.verde,
                      child: Text('Cambiar', textAlign: TextAlign.center,),
                    )
                  ],
                ),

                ///operador ternario que valida que hayan elementos en la lista de tiquetes
                ///si la lista es vacia retorna el mensaje
                ///en caso contrario muestra la lista
                _.sede.value.tickets.isEmpty ? const Text('Aun no se agregan tickets') : 
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: [            
                      //aqui se muestran la lista de tiquetes guardados        
                      for(int i=0; i<_.sede.value.tickets.length; i++)
                      Tarjeta(
                        width: widthTarjeta,
                        imagen: _.sede.value.tickets[i].imagen.imagen,
                        titulo: _.sede.value.tickets[i].valor.toString(),
                        subtitulo: _.sede.value.tickets[i].strFecha,
                        opciones: opcionesItemTicket(_.sede.value.tickets[i]),
                        numeroEstrellas: _.sede.value.tickets[i].numeroEstrellas,
                      )
                    ],
                  ),
                  ],
                )
              ],
            );
          }
        );
      }
    );
  }
  
  opcionesItemTicket(ticket) {
    return PopupMenuButton(
      padding: const EdgeInsets.all(0),
      tooltip: 'Opciones',
      icon: const Icon(
        Icons.more_horiz,
        color: Colores.negro,
      ),
      itemBuilder: (BuildContext context) =>
          <PopupMenuEntry>[
        PopupMenuItem(
          padding: const EdgeInsets.all(0),
          child: ListTile(
            onTap: () {
              Get.back();
              Modal.child(
                context,
                barrierDismissible: false,
                child: FormTicket(ticket: ticket,)
              );
            },
            leading: const Icon(BootstrapIcons.pen),
            title: const Text('Editar'),
          ),
        ),
        PopupMenuItem(
          padding: const EdgeInsets.all(0),
          child: ListTile(
            onTap: (){
              Get.back();
              Modal.porDefecto(
                context,
                child: const Text('¿Quieres eliminar este ticket?'),
                onAceptar: (){
                  /**
                   * aqui va la accion que se debe realizar si se quiere eliminar el ticket
                   */
                }
              );
            },
            leading: const Icon(BootstrapIcons.trash),
            title: const Text('Eliminar'),
          ),
        ),
      ],
    );
  }
}



class TiempoPermitidoCompra extends StatelessWidget {

  List<int> minutos = [15, 30, 60];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colores.blancoOscuro,
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(child: Text('Permitir comprar cada:')),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                for(int i=0; i<minutos.length; i++)
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: (){
                        /**
                         * qui se escribe el codigo para modificar el tiempo permitido para cancelacion de compra de tickcets
                         */
                      },
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colores.grisClaro,
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
                      )
                    ),
                  ),
                //end for
              ],
            ),
          )
        ],
      ),
    );
  }
}