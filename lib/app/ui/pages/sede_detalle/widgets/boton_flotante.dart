
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:topsitesnegocio/app/data/models/sede/combo_plan.dart';
import 'package:topsitesnegocio/app/data/models/sede/evento.dart';
import 'package:topsitesnegocio/app/data/models/sede/renta.dart';
import 'package:topsitesnegocio/app/data/models/sede/termino_condicion.dart';
import 'package:topsitesnegocio/app/data/models/sede/ticket.dart';
import 'package:topsitesnegocio/app/ui/pages/sede_detalle/form_combo_plan.dart';

import '../../../theme/colores.dart';
import '../../../widgets/boton.dart';
import '../../../widgets/modal.dart';
import '../form_evento.dart';
import '../form_renta.dart';
import '../form_terminos_condiciones.dart';
import '../form_ticket.dart';

class BotonFlotanteSede extends StatelessWidget {
  
  const BotonFlotanteSede({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: (){
        Modal.porDefecto(
          context,
          mostrarAcciones: false,
          titulo: 'Selecciona la accion a realizar',
          child: Column(
            children: [
              Wrap(
                runSpacing: 10,
                spacing: 10,
                children: [
                  Boton(
                    accion: (){
                      Get.back();
                      Modal.child(
                        context,
                        barrierDismissible: false,
                        child: FormComboPlan(comboPlan: ComboPlan.construir(),)
                      );
                    },
                    color: Colores.verde,
                    colorHover: Colores.verdeOscuro,
                    child: const Text('Agregar Combo / plan'),
                  ),
                  Boton(
                    accion: (){
                      Get.back();
                      Modal.child(
                        context,
                        barrierDismissible: false,
                        child: FormEvento(evento: Evento.construir(),)
                      );
                    },
                    color: Colores.verde,
                    colorHover: Colores.verdeOscuro,
                    child: const Text('Agregar nuevo evento'),
                  ),
                  Boton(
                    accion: (){
                      Get.back();
                      Modal.child(
                        context,
                        barrierDismissible: false,
                        child: FormRenta(renta: Renta.construir(),)
                      );
                    },
                    color: Colores.verde,
                    colorHover: Colores.verdeOscuro,
                    child: const Text('Agregar nueva renta'),
                  ),
                  Boton(
                    accion: (){
                      Get.back();
                      Modal.child(
                        context,
                        barrierDismissible: false,
                        child: FormTicket(ticket: Ticket.construir(),)
                      );
                    },
                    color: Colores.verde,
                    colorHover: Colores.verdeOscuro,
                    child: const Text('Agregar nuevo ticket'),
                  ),
                  Boton(
                    accion: (){
                      Get.back();
                      Modal.child(
                        context,
                        barrierDismissible: false,
                        child: FormTerminosCondiciones(terminoCondicion: TerminoCondicion(),)
                      );
                    },
                    color: Colores.verde,
                    colorHover: Colores.verdeOscuro,
                    child: const Text('Agregar nuevo Termino y condicion'),
                  ),
                ],
              )
            ],
          )
        );
      },
      backgroundColor: Colores.rosa,
      child: const Icon(BootstrapIcons.plus),
    );
  }
}

