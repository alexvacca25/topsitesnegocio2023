import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:topsitesnegocio/app/controllers/reestablecer_clave_controller.dart';
import 'package:topsitesnegocio/app/controllers/sesion_controller.dart';
import 'package:topsitesnegocio/app/routes/app_pages.dart';
import 'package:topsitesnegocio/app/ui/widgets/boton.dart';
import 'package:topsitesnegocio/app/ui/widgets/input.dart';
import 'package:topsitesnegocio/app/ui/widgets/modal.dart';
import 'package:topsitesnegocio/app/ui/widgets/titulo.dart';

import '../../theme/colores.dart';
import '../../theme/imagenes.dart';

class ReestablecerClavePage extends GetView{

  SesionController sesionController = Get.find();
  ReestablecerClaveController reestablecerClaveController = Get.find();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          width: Get.width,
          height: Get.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft, // 10% of the width, so there are ten blinds.
              end: Alignment.bottomRight,
              colors: <Color>[
                Colores.rosa,
                Colores.azul,
              ],
              tileMode: TileMode.repeated, // repeats the gradient over the canvas
            ),
            image: DecorationImage(
              image: AssetImage(Imagenes.fondoLogin,),
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
              opacity: 0.1
            )
          ),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                color: Colores.blanco,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colores.negro.withOpacity(0.5),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20,),
                  const TituloWidget(),
                  const SizedBox(height: 10,),
                  const Text('Recuperar contraseña '),
                  const SizedBox(height: 30,),
                  Inputs(controller: reestablecerClaveController.txtNuevaClave, titulo: 'Nueva contraseña', esClave: true,),
                  const SizedBox(height: 10,),
                  Inputs(controller: reestablecerClaveController.txtConfirmacionNuevaClave, titulo: 'Confirmacion nueva contraseña', esClave: true,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BotonTexto(texto: 'Prefiero iniciar sesion',accion: (){
                        Get.offAllNamed(Routes.LOGIN);
                      },),
                      Boton(
                        color: Colores.verdeOscuro,
                        colorHover: Colores.verde,
                        child: const Text('Reestablecer', style: TextStyle(color: Colores.blanco),),
                        accion: ()async{
                          bool? response = await reestablecerClaveController.actualizarCLave();
                          if(response==null){
                            return;
                          }
                          Modal.porDefecto(
                            context, 
                            titulo: 'Correcto',
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Se actualizo la contraseña'),
                              ],
                            ), 
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                ],
              ),
            ),
          )
        ),
      )
    );
  }
}