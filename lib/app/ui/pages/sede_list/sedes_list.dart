import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:topsitesnegocio/app/ui/pages/sede_list/sede_list_controller.dart';

import '../../../data/models/sede/horario_sede.dart';
import '../../../data/models/sede/sede.dart';
import '../../../routes/app_pages.dart';
import '../../theme/colores.dart';
import '../../widgets/input.dart';
import '../../widgets/modal.dart';
import '../../widgets/tarjeta.dart';

class SedesList extends GetResponsiveView {

  SedeListController sedeListController = Get.put(SedeListController());

  SedesList({super.key});

  @override
  Widget builder() {
    return Builder(
      builder: (context) => Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            agregarNuevaSede(context);
          },
          label: const Text('Agregar sede'),
          icon: const Icon(BootstrapIcons.plus),
          backgroundColor: Colores.azulOscuro,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        body: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  (){
                    if(sedeListController.sedes.isEmpty){
                      return Container(
                        width: Get.width,
                        height: Get.height - 50,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('Aun no agregas sedes'),
                          ],
                        ),
                      );
                    }
                    return Wrap(
                      spacing: 5,
                      runSpacing: 5,
                      children: List.generate(
                        sedeListController.sedes.length,
                        (index) => Tarjeta(
                          titulo: sedeListController.sedes[index].informacionGeneral.nombre,
                          subtitulo: sedeListController.sedes[index].informacionGeneral.descripcion.isEmpty ? 'Aun no hay descripción' : sedeListController.sedes[index].informacionGeneral.descripcion,
                          foto: sedeListController.sedes[index].imagenesSede.fotoLogo.imagen,
                          imagen: sedeListController.sedes[index].imagenesSede.fotoPrincipal.imagen,
                          width: !screen.isDesktop ? Get.width : 300,
                          onTap: () => Get.toNamed(Routes.SEDE, parameters: { 'id' : '${sedeListController.sedes[index].id ?? 0}' })!.then((value) => sedeListController.cargarLista()),
                          opciones: 
                            PopupMenuButton(
                            padding: EdgeInsets.all(0),
                            tooltip: 'Opciones',
                            icon: const Icon(
                              Icons.more_vert,
                              color: Colores.blanco,
                            ),
                            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                              PopupMenuItem(
                                padding: EdgeInsets.all(0),
                                child: ListTile(
                                  onTap: () {
                                    Get.back();
                                    agregarNuevaSede(
                                      context,
                                      sede:sedeListController.sedes.value[index]
                                    );
                                  },
                                  leading: Icon(BootstrapIcons.files),
                                  title: Text('Duplicar'),
                                ),
                              ),
                              PopupMenuItem(
                                padding: EdgeInsets.all(0),
                                child: ListTile(
                                  onTap: (){},
                                  leading: Icon(BootstrapIcons.flag),
                                  title: Text('Publicar'),
                                ),
                              ),
                              PopupMenuItem(
                                padding: EdgeInsets.all(0),
                                child: ListTile(
                                  onTap: (){},
                                  leading: Icon(BootstrapIcons.trash),
                                  title: Text('Eliminar'),
                                ),
                              ),
                            ],
                          ),
                        )
                      ),
                    );
                  }
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  agregarNuevaSede(context, { Sede? sede }) {
    TextInputController txtNombreSede = TextInputController();
    final informacionGeneral = true.obs;
    final imagenes = false.obs;
    final horarios = false.obs;
    final combos = false.obs;
    final tickets = false.obs;
    final terminos = false.obs;
    final pagos = false.obs;

    Modal.porDefecto(
      context,
      titulo: sede==null ? 'Agregar' : 'Duplicar',
      barrierDismissible: false,
      onAceptar: () {
        
        if(txtNombreSede.controlador.text.trim().isEmpty){
          txtNombreSede.error.value = 'debe ingresar el nombre de la sede';
          return;
        }

        Sede nuevaSede = Sede.construir();

        if(sede==null){
          nuevaSede.informacionGeneral.nombre = txtNombreSede.controlador.text;
          sedeListController.agregarNuevaSede(nuevaSede);
          Get.back();
          return;
        }

        if(informacionGeneral.value){
          nuevaSede.informacionGeneral.telefono = sede.informacionGeneral.telefono;
          nuevaSede.informacionGeneral.celular = sede.informacionGeneral.celular;
          nuevaSede.informacionGeneral.direccion = sede.informacionGeneral.direccion;
          nuevaSede.informacionGeneral.correo = sede.informacionGeneral.correo;
          nuevaSede.informacionGeneral.descripcion = sede.informacionGeneral.descripcion;
        }
        if(imagenes.value){
          nuevaSede.imagenesSede = sede.imagenesSede;
        }
        if(horarios.value){
          nuevaSede.horario = Horario.construir();
        }
        nuevaSede.informacionGeneral.nombre = txtNombreSede.controlador.text;
        sedeListController.agregarNuevaSede(nuevaSede);
        Get.back();
      },
      onCancelar: () {
        Get.back();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Inputs(titulo: 'Nombre de la sede', controller: txtNombreSede),
          const SizedBox(
            height: 10,
          ),
          sede==null? Container() : const Text('¿Qué información desea duplicar?'),
          const SizedBox(
            height: 10,
          ),
          sede == null ? Container() :  Wrap(spacing: 6.0, runSpacing: 6.0, children: [
            itemDuplicar(informacionGeneral,'Información general'),
            itemDuplicar(imagenes,'Imágenes del negocio'),
            itemDuplicar(horarios,'Horarios de atención'),
            itemDuplicar(combos,'Combos y planes'),
            itemDuplicar(tickets,'Tickets'),
            itemDuplicar(terminos,'Términos y condiciones'),
            itemDuplicar(pagos,'Pagos / Cobros'),
          ])
        ],
      ),
    );
  }

    Obx itemDuplicar(RxBool estado, texto) {
    return Obx(
      () => ChoiceChip(
        padding: const EdgeInsets.all(5),
        label: Text(texto),
        avatar: estado.value ? Icon(BootstrapIcons.check, color: Colores.blanco,) : null,
        labelStyle: TextStyle(
          color: estado.value ? Colores.blanco : Colores.negro
        ),
        elevation: estado.value ? 5 : 0,
        selected: estado.value,
        selectedColor: Colores.verde,
        backgroundColor: Colores.grisClaro,
        onSelected: (val) {
          estado.value = !estado.value;
        },
      )
    );
  }


}
