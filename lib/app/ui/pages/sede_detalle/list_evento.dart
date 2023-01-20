import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:topsitesnegocio/app/ui/pages/sede_detalle/form_evento.dart';

import '../../../controllers/sede_controller.dart';
import '../../theme/colores.dart';
import '../../widgets/modal.dart';
import '../../widgets/tarjeta.dart';

class ListEventoPage extends GetView {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SedeController>(
      builder: (_){
        return LayoutBuilder(
          builder: (context,constraints){
            dynamic width = constraints.maxWidth;
            dynamic widthTarjeta = width < 600 ? Get.width : ((600 / 2)-10);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _.sede.value.eventos.isEmpty ? const Text('Aun no se agrega evento') : 
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: [            
                      //aqui se muestran la lista de eventos guardados        
                      for(int i=0; i<_.sede.value.eventos.length; i++)
                      Tarjeta(
                        width: widthTarjeta,
                        imagen: _.sede.value.eventos[i].imagenPrincipal.imagen,
                        titulo: _.sede.value.eventos[i].nombre,
                        subtitulo: _.sede.value.eventos[i].descripcion,
                        opciones: opcionesItemEvento(_.sede.value.eventos[i]),
                        numeroEstrellas: _.sede.value.eventos[i].numeroEstrellas,
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

  opcionesItemEvento(evento) {
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
                child: FormEvento(evento: evento,)
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
                child: const Text('¿Quieres eliminar este combo?'),
                onAceptar: (){
                  /**
                   * aqui va la accion que se debe realizar si se quiere eliminar el evento
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