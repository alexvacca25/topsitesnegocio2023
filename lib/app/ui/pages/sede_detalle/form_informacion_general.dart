
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:topsitesnegocio/app/ui/theme/fonts.dart';

import '../../../controllers/form_informacion_general_controller.dart';
import '../../theme/colores.dart';
import '../../widgets/boton.dart';
import '../../widgets/input.dart';
import '../../widgets/snackbar.dart';

// ignore: must_be_immutable
class FormInformacionGeneral extends GetResponsiveView {

  FormImformacionGeneralController formImformacionGeneralController = Get.put(FormImformacionGeneralController(), permanent: false);

  FormInformacionGeneral({super.key});
  
  @override
  Widget builder() {
    return GetBuilder<FormImformacionGeneralController>(
      builder: (_){        
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colores.negro,
            title: const Text('Información general'),
            actions: [
              IconButton(onPressed: ()=>Get.back(), icon: const Icon(BootstrapIcons.x))
            ],
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
                  bool respuesta = await _.actualizarImformacionGeneral();
                  if(respuesta){
                    Get.back();
                    MensajeInferior.porDefecto(titulo: 'Ok', mensaje: 'Cambios guardados correctamente');
                  }
                },
                color: Colores.verde,
                child: const Text('Guardar'),
              ),
            ],
          ),
            body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Inputs(
                icon: BootstrapIcons.pin_map,
                titulo: 'Nombre',
                controller: _.txtNombreSede,
              ),
              Inputs(
                icon: BootstrapIcons.pin_map,
                titulo: 'Descripción',
                controller: _.txtDescripcion,
                maxLines: 3,
              ),
              Row(
                children: [
                  Expanded(
                    child: Inputs(
                      icon: BootstrapIcons.telephone,
                      titulo: 'Teléfono',
                      controller: _.txtTelefono,
                      tipoTeclado: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: Inputs(
                      icon: BootstrapIcons.telephone,
                      titulo: 'Celular',
                      controller: _.txtCelular,
                      tipoTeclado: TextInputType.number,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Obx(
                    ()=>Expanded(
                      child: DropdownButton(
                        isExpanded: true,
                        style: TextStyle(
                          color: _.errorPais.value ? Colores.rojo : Colores.negro,
                          fontFamily: Fuentes.ztgrafton,
                          fontSize: 16
                        ),
                        items: List.generate(
                          _.negocioController.paises.value.length, 
                          (index) => DropdownMenuItem(
                            value: '${_.negocioController.paises.value[index].id}',
                            child: Text(
                              _.negocioController.paises.value[index].nombre,
                              overflow: TextOverflow.clip,
                              maxLines: 1,
                            ),
                          )
                        ),
                        value: _.pais.value,
                        onChanged: (value) => _.pais.value = value!
                      )
                    )
                  ),
                  const SizedBox(width: 10,),
                  Obx(
                    ()=>Expanded(
                      child: DropdownButton(
                        isExpanded: true,
                        items: List.generate(
                          _.negocioController.departamentos.value.length, 
                          (index) => DropdownMenuItem(
                            value: '${_.negocioController.departamentos.value[index].id}',
                            child: Text(
                              _.negocioController.departamentos.value[index].nombre,
                              overflow: TextOverflow.clip,
                              maxLines: 1,
                            ),
                          )
                        ),
                        value: _.departamento.value,
                        onChanged: (value)=>_.departamento.value = value!
                      )
                    )
                  ),
                  const SizedBox(width: 10,),
                  Obx(
                    () => Expanded(
                      child: DropdownButton(
                        isExpanded: true,
                        items: List.generate(
                          _.negocioController.ciudades.value.length, 
                          (index) => DropdownMenuItem(
                            value: _.negocioController.ciudades.value[index].id,
                            child: Text(
                              _.negocioController.ciudades.value[index].nombre,
                              overflow: TextOverflow.clip,
                              maxLines: 1,
                            ),
                          )
                        ),
                        value: _.ciudad.value,
                        onChanged: (value) => _.ciudad.value = value!
                      )
                    )
                  )
                  
                ],
              ),
              Row(                
                children: <Widget>[
                  Expanded(
                    child: Inputs(
                      icon: BootstrapIcons.pin_map,
                      titulo: 'Dirección',
                      controller: _.txtDireccion,
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: Inputs(
                      icon: BootstrapIcons.pin_map,
                      titulo: 'Correo electrónico',
                      controller: _.txtCorreo,
                    ),
                  ),
                ],
              ), 
              const SizedBox(height: 100,)
            ],
          )
        );
      }
    );
  }
}

