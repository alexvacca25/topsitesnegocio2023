
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:topsitesnegocio/app/ui/pages/sede_detalle/list_combo_planes.dart';
import 'package:topsitesnegocio/app/ui/pages/sede_detalle/list_evento.dart';
import 'package:topsitesnegocio/app/ui/pages/sede_detalle/list_renta.dart';
import 'package:topsitesnegocio/app/ui/pages/sede_detalle/list_termino_condicion.dart';
import 'package:topsitesnegocio/app/ui/pages/sede_detalle/list_ticket.dart';
import 'package:topsitesnegocio/app/ui/theme/colores.dart';
import 'package:topsitesnegocio/app/ui/widgets/input.dart';
import 'widgets/boton_flotante.dart';
import 'widgets/bottom_bar_sede.dart';
import 'widgets/imagenes_nombre_descripcion.dart';

// ignore: must_be_immutable
class DetallesSede extends GetResponsiveView {
  
  DetallesSede({super.key});

  final seleccionado = 0.obs;

  List vistas = [
    'Combos / planes',
    'Eventos',
    'Renta',
    'Tickets',
    'Terminos y condiciones',
  ];

  @override
  Widget builder() {
    return Builder(
      builder: (BuildContext context) => DefaultTabController(
        length: 5,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(screen.isDesktop ? 5 : 0),
          ),
          clipBehavior: Clip.hardEdge,
          child: Scaffold(
            backgroundColor: Colores.crema,
            floatingActionButton: const BotonFlotanteSede(),
            bottomNavigationBar: BottomBarSede(seleccionarTab: seleccionarTab),
            body: ListView(
              children: [
                ImagenesNombreDescripcion(),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Inputs(controller: TextInputController(), titulo: 'Buscar en ${vistas[seleccionado.value]}',),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Obx(
                    () => Column(
                      children: [
                        seleccionado.value == 0 ?
                          ListComboPlanesPage() : 
                        seleccionado.value == 1 ?
                          ListEventoPage() :
                        seleccionado.value == 2 ?
                          ListRentaPage() :
                        seleccionado.value == 3 ?
                          ListTicketsPage() :
                        seleccionado.value == 4 ?
                          ListTerminoCondicionPage() : Container()
                      ],
                    )
                  ),
                ),
                
                SizedBox(height: 200,)
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  seleccionarTab(value) {
    seleccionado.value = value;
  }
}




