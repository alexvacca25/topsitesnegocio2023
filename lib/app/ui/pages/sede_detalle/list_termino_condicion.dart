import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:topsitesnegocio/app/ui/theme/colores.dart';
import 'package:topsitesnegocio/app/ui/theme/fonts.dart';
import 'package:topsitesnegocio/app/ui/widgets/modal.dart';
import 'package:topsitesnegocio/app/ui/widgets/snackbar.dart';

import '../../../controllers/sede_controller.dart';
import 'form_terminos_condiciones.dart';
class ListTerminoCondicionPage extends GetView {
@override
  Widget build(BuildContext context) {
    return GetBuilder<SedeController>(
      builder: (_){
        return Obx(
          (){
            return Column(
              children: [
                _.sede.value.terminosCondiciones.isEmpty ? const Text('Aun no agregas terminos y condiciones') : 
                Column(
                  children: List.generate(
                    _.sede.value.terminosCondiciones.length,
                    (index) => Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: Colores.blancoOscuro,
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  _.sede.value.terminosCondiciones[index].titulo,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                )
                              ),
                              PopupMenuButton(
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
                                      onTap: (){
                                        Get.back();
                                        Modal.child(
                                          context,
                                          child: FormTerminosCondiciones(terminoCondicion: _.sede.value.terminosCondiciones[index],)
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
                                          child: Text('¿Quieres eliminar este Termino condición?'),
                                          onAceptar: ()async{
                                            Get.back();
                                            bool response = await _.formTerminoCondicionController.eliminar(_.sede.value.terminosCondiciones[index].id);
                                            if(response){
                                              MensajeInferior.porDefecto(titulo: 'Ok', mensaje: 'Se ha eliminado correctamente');
                                            }
                                          }
                                        );
                                      },
                                      leading: const Icon(BootstrapIcons.trash),
                                      title: const Text('Eliminar'),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Text(
                            _.formTerminoCondicionController.obtenerTipoTerminoCondicion(_.sede.value.terminosCondiciones[index].tipo),
                            style: const TextStyle(
                              fontFamily: Fuentes.ztgraftonThin
                            ),
                          ),
                          const SizedBox(height: 5,),
                          Text(
                            _.sede.value.terminosCondiciones[index].descripcion,
                            maxLines: 3,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 10
                            ),
                          ),
                        ],
                      ),
                    )
                  ),
                )
              ]
            );
          }
        );
      }
    );
  }
}