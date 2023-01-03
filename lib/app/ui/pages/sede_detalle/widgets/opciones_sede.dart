
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:topsitesnegocio/app/controllers/form_pagos_cobros_controller.dart';
import 'package:topsitesnegocio/app/controllers/sede_controller.dart';

import '../../../../controllers/form_horario_excepciones_controller.dart';
import '../../../../controllers/form_imagenes_controller.dart';
import '../../../../controllers/form_informacion_general_controller.dart';
import '../../../theme/colores.dart';
import '../../../widgets/modal.dart';
import '../form_pago_cobro.dart';
import '../form_imagenes.dart';
import '../form_informacion_general.dart';
import 'horarios_excepciones.dart';

class OpcionesSede extends StatelessWidget {
  const OpcionesSede({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SedeController>(
      builder: (_){
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
                    child: FormInformacionGeneral()
                  ).then((value) => Get.delete<FormImformacionGeneralController>());
                },
                leading: const Icon(BootstrapIcons.info),
                title: const Text('Informacion general'),
              ),
            ),
            PopupMenuItem(
              padding: const EdgeInsets.all(0),
              child: ListTile(
                onTap: (){
                  Get.back();
                  Modal.child(
                    context,
                    barrierDismissible: false,
                    child: FormPagosCobros()
                  ).then((value) => Get.delete<FormPagosCobrosController>());
        
                },
                leading: const Icon(BootstrapIcons.coin),
                title: const Text('Pagos y cobros'),
              ),
            ),
            PopupMenuItem(
              padding: const EdgeInsets.all(0),
              child: ListTile(
                onTap: (){
                  Get.back();
                  Modal.child(
                    context,
                    barrierDismissible: false,
                    child: FormImagenes()
                  ).then((value) => Get.delete<FormImagenesController>());
                },
                leading: const Icon(BootstrapIcons.image),
                title: const Text('Imágenes'),
              ),
            ),
            PopupMenuItem(
              padding: const EdgeInsets.all(0),
              child: ListTile(
                onTap: (){
                  Get.back();
                  Modal.child(
                    context,
                    barrierDismissible: false,
                    child: HorariosExcepciones()
                  ).then((value) => Get.delete<FormHorariosExcepcionesController>());
                },
                leading: const Icon(BootstrapIcons.clock),
                title: const Text('Horarios y excepciones'),
              ),
            ),
          ],
        );
      }
    );
  }
}