
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:topsitesnegocio/app/data/models/sede/termino_condicion.dart';
import 'package:topsitesnegocio/app/ui/widgets/boton.dart';
import 'package:topsitesnegocio/app/ui/widgets/input.dart';
import 'package:topsitesnegocio/app/ui/widgets/snackbar.dart';

import '../../../controllers/form_termino_condicione_controller.dart';
import '../../theme/colores.dart';
import '../../theme/fonts.dart';
import '../../widgets/modal.dart';

class FormTerminosCondiciones extends GetView {
  
  
  final TerminoCondicion terminoCondicion;

  TextInputController txtTitulo = TextInputController();
  TextInputController txtDescripcion = TextInputController();

  final cambiaTipoTermino = false.obs;
  final errorCombo = false.obs;
  final esObtener;
  
  FormTerminosCondiciones({super.key, required this.terminoCondicion, this.esObtener = false});

  @override
  Widget build(BuildContext context) {

    txtTitulo.controlador.text = terminoCondicion.titulo;
    txtDescripcion.controlador.text = terminoCondicion.descripcion;
    terminoCondicion.tipo = terminoCondicion.tipo == '' ? '0' : terminoCondicion.tipo;

    return GetBuilder<FormTerminoCondicionController>(
      builder: (_){
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colores.negro,
            title: Text('${terminoCondicion.id == null ? 'Agregar' : 'Editar'} termino y condición'),
            actions: [
              IconButton(
                onPressed: (){
                  Modal.porDefecto(
                    context, 
                    child: const Text('¿Seguro que quieres cerrar?'), 
                    onAceptar: (){
                      Get.back();
                      Get.back();
                    }
                  );
                }, icon: const Icon(BootstrapIcons.x)
              )
            ]
          ),
          floatingActionButton: Wrap(
            direction: Axis.horizontal, 
            children: [
              Boton(
                accion: ()=>Get.back(),
                color: Colores.gris,
                child: const Text('Cancelar'),
              ),
              const SizedBox(width: 10,),
              Boton(
                accion: ()async{
                  terminoCondicion.titulo = txtTitulo.controlador.text;
                  terminoCondicion.descripcion = txtDescripcion.controlador.text;
                  
                  if(terminoCondicion.tipo=='0'){
                    errorCombo.value = true;
                    return;
                  }

                  if(terminoCondicion.titulo.isEmpty){
                    txtTitulo.error.value = 'Debe ingresar el titulo';
                    return;
                  }

                  if(terminoCondicion.descripcion.isEmpty){
                    txtDescripcion.error.value = 'Debe ingresar la descripcion';
                    return;
                  }


                  if(esObtener){
                    Get.back(result: terminoCondicion);
                    return;
                  }
                  
                  bool respuesta = false;

                  if(terminoCondicion.id == null){
                    respuesta = await _.agregar(terminoCondicion);
                  }else{
                    respuesta = await _.actualizar(terminoCondicion);
                  }

                  if(respuesta){
                    Get.back();
                    MensajeInferior.porDefecto(titulo: 'Ok', mensaje: 'Guardado correctamente');
                  }

                },
                color: Colores.verde,
                child: const Text('Guardar'),
              ),
            ],
          ),
          backgroundColor: Colores.crema,
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Obx(
                (){
                  cambiaTipoTermino.value;
                  return DropdownButton(
                    style: TextStyle(
                      color: errorCombo.value ? Colores.rojo : Colores.negro,
                      fontFamily: Fuentes.ztgrafton,
                      fontSize: 16
                    ),
                    items: List.generate(
                      _.tipoTerminosCondiciones.value.length,
                      (index) => DropdownMenuItem(
                        value: _.tipoTerminosCondiciones.value[index].id,
                        child: Text(_.tipoTerminosCondiciones.value[index].nombre),
                      )
                    ),
                    value: terminoCondicion.tipo, 
                    onChanged: (value){
                      terminoCondicion.tipo = value;
                      cambiaTipoTermino.value = !cambiaTipoTermino.value;
                    }
                  );
                }
              ),
              const SizedBox(width: 10,),
              Inputs(controller: txtTitulo, titulo: 'Título',),
              const SizedBox(width: 10,),
              Inputs(controller: txtDescripcion, titulo: 'Descripción', maxLines: 5),
              const SizedBox(width: 10,),
            ],
          )
        );
      }
    );
  }
}