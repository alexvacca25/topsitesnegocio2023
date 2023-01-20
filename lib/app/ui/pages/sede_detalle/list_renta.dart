import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:topsitesnegocio/app/ui/pages/sede_detalle/form_renta.dart';

import '../../../controllers/sede_controller.dart';
import '../../theme/colores.dart';
import '../../widgets/modal.dart';
import '../../widgets/tarjeta.dart';
class ListRentaPage extends GetView {
  
  const ListRentaPage({super.key});

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
                _.sede.value.rentas.isEmpty ? const Text('Aun no se agrega renta') : 
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: [            
                      //aqui se muestran la lista de rentas guardadas        
                      for(int i=0; i<_.sede.value.rentas.length; i++)
                      Tarjeta(
                        width: widthTarjeta,
                        imagen: _.sede.value.rentas[i].imagenPrincipal.imagen,
                        titulo: _.sede.value.rentas[i].nombre,
                        subtitulo: _.sede.value.rentas[i].descripcion,
                        opciones: opcionesItemRenta(_.sede.value.rentas[i]),
                        numeroEstrellas: _.sede.value.rentas[i].numeroEstrellas,
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

  opcionesItemRenta(renta) {
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
                child: FormRenta(renta: renta,)
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
                   * aqui va la accion que se debe realizar si se quiere eliminar la renta
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