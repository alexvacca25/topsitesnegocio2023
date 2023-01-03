
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/form_horario_excepciones_controller.dart';
import '../../../theme/colores.dart';
import '../../../widgets/boton.dart';
import '../../../widgets/snackbar.dart';
import '../form_horario.dart';
import '../list_excepciones.dart';
import '../list_horarios.dart';

class HorariosExcepciones extends StatelessWidget {

  FormHorariosExcepcionesController formHorariosExcepcionesController = Get.put(FormHorariosExcepcionesController());
  

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FormHorariosExcepcionesController>(
      builder: (_){
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            floatingActionButton: Wrap(
              direction: Axis.horizontal, 
                children: [
                  Boton(
                    accion: ()=>Get.back(),
                    colorHover: Colores.grisClaro,
                    color: Colores.gris,
                    child: const Text('Cancelar'),
                  ),
                  const SizedBox(width: 10,),
                  Boton(
                    accion: ()async{
                      bool response = await _.actualizar();
                      if(response){
                        Get.back();
                        MensajeInferior.porDefecto(titulo: 'Ok', mensaje: 'Cambios guardados correctamente');
                      }
                    },
                    color: Colores.verde,
                    colorHover: Colores.verdeOscuro,
                    child: const Text('Guardar'),
                  ),
                ],
            ),
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const Text('Horarios y Excepciones'),
              backgroundColor: Colores.negro,
              actions: [
                IconButton(onPressed: ()=>Get.back(), icon: const Icon(BootstrapIcons.x))
              ],
              bottom: const TabBar(
                tabs: [
                  Tab(text: 'Información general',),
                  Tab(text: 'Horarios',),
                  Tab(text: 'Excepciones',),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                Column(
                  children: [
                    TiempoPermitidoReserva(),
                    TiempoMinimoReserva(),
                    TiempoPermitidoCancelacion(),
                  ],
                ),
                const HorariosList(),
                const ListExcepcion(),
              ],
            ),
          ),
        );
      }
    );
  }
}

