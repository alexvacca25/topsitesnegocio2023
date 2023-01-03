
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:topsitesnegocio/app/controllers/form_pagos_cobros_controller.dart';
import 'package:topsitesnegocio/app/ui/widgets/input.dart';
import 'package:topsitesnegocio/app/ui/widgets/snackbar.dart';

import '../../theme/colores.dart';
import '../../theme/fonts.dart';
import '../../widgets/boton.dart';

class FormPagosCobros extends GetView {

  FormPagosCobrosController formPagosCobrosController = Get.put(FormPagosCobrosController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FormPagosCobrosController>(
      builder: (_){
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colores.negro,
            title: const Text('Pagos / cobros'),
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
                colorHover: Colores.grisClaro,
                child: const Text('Cancelar'),
              ),
              const SizedBox(width: 10,),
              Boton(
                accion: ()async{
                  dynamic response = await _.actualizar();
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
          backgroundColor: Colores.crema,
          body: Center(
            child: Container(
              color: Colores.blanco,
              width: 500,
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Obx(
                    ()=>DropdownButton(
                      items: const [
                        DropdownMenuItem(value: '0', child:  Text('Tipo de documento')),
                        DropdownMenuItem(value: '1', child:  Text('Cedula de ciudadania')),
                        DropdownMenuItem(value: '2', child:  Text('Cedula extrangeria')),
                        DropdownMenuItem(value: '3', child:  Text('Nit')),
                        DropdownMenuItem(value: '4', child:  Text('Targeta de identidad')),
                        DropdownMenuItem(value: '5', child:  Text('Pasaporte')),
                        DropdownMenuItem(value: '6', child:  Text('Registro civil')),
                      ], 
                      style: ponerColorErrorCombo(_.errorTipoDocumento.value),
                      value: _.tipoDocumento.value, 
                      onChanged: (value)=>_.tipoDocumento.value = value!,
                      onTap: () => _.errorTipoDocumento.value = false,
                    ),
                  ),
                  Inputs(controller: _.txtNumeroDocumento, titulo: 'Número de documento', tipoTeclado: TextInputType.number,),
                  Obx(
                    ()=>Row(
                      children: [
                        Expanded(
                          child: DropdownButton(
                            isExpanded: true,
                            items: const [
                              DropdownMenuItem(value: '0', child: Text('Banco')),
                              DropdownMenuItem(value: '1', child: Text('Banco 1')),
                              DropdownMenuItem(value: '2', child: Text('Banco 2')),
                            ], 
                            value: _.tipoBanco.value,
                            onChanged: (value)=>_.tipoBanco.value = value!,
                            style: ponerColorErrorCombo(_.errorTipoBanco.value),
                            onTap: () => _.errorTipoBanco.value = false,
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Expanded(
                          child: DropdownButton(
                            isExpanded: true,
                            items: const [
                              DropdownMenuItem(value: '0', child: Text('Tipo de cuenta')),
                              DropdownMenuItem(value: '1', child: Text('Ahorro')),
                              DropdownMenuItem(value: '3', child: Text('Corriente')),
                              DropdownMenuItem(value: '4', child: Text('Nomina')),
                            ], 
                            value: _.tipoCuenta.value,
                            onChanged: (value) => _.tipoCuenta.value = value!,
                            style: ponerColorErrorCombo(_.errorTipoCuenta.value),
                            onTap: () => _.errorTipoCuenta.value = false,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Inputs(controller: _.txtNumeroCuenta, titulo: 'Número de cuenta', tipoTeclado: TextInputType.number,),
                  const SizedBox(height: 100,),
                ],
              ),
            ),
          )
        );
      }
    );
  }

  TextStyle ponerColorErrorCombo(bool poner) {
    return TextStyle(
      color: poner ? Colores.rojo : Colores.negro,
      fontFamily: Fuentes.ztgrafton,
      fontSize: 16
    );
  }
}