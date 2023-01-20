
import 'package:badges/badges.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:topsitesnegocio/app/controllers/form_imagenes_controller.dart';

import '../../../data/models/sede/imagenes_sede.dart';
import '../../theme/colores.dart';
import '../../widgets/boton.dart';
import '../../widgets/imagen.dart';
import '../../widgets/snackbar.dart';

class FormImagenes extends GetResponsiveView {

  
  FormImagenesController formImagenesController = Get.put(FormImagenesController());

  FormImagenes({super.key});

  @override
  Widget builder() {
    return GetBuilder<FormImagenesController>(
      builder: (_){
        return Scaffold(
          appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colores.negro,
          title: const Text('Imágenes'),
          actions: [
            IconButton(onPressed: ()=>Get.back(), icon: const Icon(BootstrapIcons.x))
          ],
        ),
          floatingActionButton: Wrap(
            direction: Axis.horizontal, 
              children: [
                Boton(
                  accion: ()async{
                    Get.back();
                  },
                  color: Colores.gris,
                  child: const Text('Cancelar'),
                ),
                const SizedBox(width: 10,),
                Boton(
                  accion: ()async{
                    bool respuesta = await _.actualizar();
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
          backgroundColor: Colores.crema,
          body: ListView(
          children: [
            Obx(
              ()=>Container(
                width: Get.width,
                height: 300,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colores.negro,
                  image:  DecorationImage(
                    image: imagenWidget(tipo: _.fotoPrincipal.value.tipo, imagen: _.fotoPrincipal.value.imagen),
                    onError: (exception, stackTrace) {},
                    fit: BoxFit.cover
                  )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Boton(
                          accion: ()=>_.actualizarFotoPrincipal(),
                          child: const Icon(BootstrapIcons.camera, color: Colores.blanco,),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap:()=>_.actualizarFotoLogo(),
                            child: Badge(
                              position: BadgePosition.topEnd(top: 60, end: -10),
                              badgeContent: const Padding(
                                padding: EdgeInsets.all(5),
                                child: Icon(BootstrapIcons.camera, color: Colores.blanco,size: 15,),
                              ),
                              badgeColor: Colores.azulOscuro,
                              child:  CircleAvatar(
                                backgroundImage: imagenWidget(tipo:_.fotoLogo.value.tipo, imagen:  _.fotoLogo.value.imagen),
                                onBackgroundImageError: (exception, stackTrace) {},
                                backgroundColor: Colores.blanco,
                                radius: 50,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5,),
                        Container(
                          color: Colores.blanco.withOpacity(0.5),
                          padding: const EdgeInsets.all(3),
                          child: const Text(
                            'Logo', 
                            style: TextStyle(color: Colores.negro),
                          )
                        )
                      ],
                    )
                  ],
                ),
              )
            ),
            Container(
              width: Get.width,
              color: Colores.blanco,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Text('Imágenes adicionales')
                      ),
                      IconButton(
                        onPressed: ()=>_.agregarImagenAdicional(),
                        icon: const Icon(BootstrapIcons.plus),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Obx(
                    (){
                      if(_.fotosAdicionales.value.isEmpty){
                        return const SizedBox(
                          height: 200,
                          child:  Center(
                            child: Text('Aun no hay imagenes adicionales')
                          ),
                        );
                      }
                      return Column(
                        children: [
                          Wrap(
                            spacing: 5,
                            runSpacing: 5,
                            children: List.generate(
                            _.fotosAdicionales.value.length, 
                            (index) => Container(
                              width: 150,  
                              height: 150,
                              color: Colores.crema,  
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colores.negro.withOpacity(0.5),
                                  image: _.fotosAdicionales.value[index].tipo == Imagen.URL ? DecorationImage(
                                    image: NetworkImage(_.fotosAdicionales.value[index].imagen),
                                    fit: BoxFit.cover,
                                    onError: (exception, stackTrace) {},
                                  ):DecorationImage(
                                    image: MemoryImage(_.fotosAdicionales.value[index].imagen),
                                    fit: BoxFit.cover,
                                    onError: (exception, stackTrace) {},
                                  ),
                                  borderRadius: BorderRadius.circular(5)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Boton(
                                      color: Colores.gris.withOpacity(0.5),
                                      radio: 25,
                                      accion: () => _.quitarImagenAdicional(index),
                                      child: const Icon(BootstrapIcons.x, color: Colores.blanco,),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        index == 0 ? Container() : 
                                        IconButton(
                                          onPressed: (){
                                            if(index!=0){
                                              dynamic aux = _.fotosAdicionales.value[index];
                                              _.fotosAdicionales.value[index] = _.fotosAdicionales.value[index - 1];
                                              _.fotosAdicionales.value[index - 1] = aux;
                                              _.fotosAdicionales.refresh();
                                            }
                                          }, 
                                          icon: const Icon(BootstrapIcons.caret_left_fill, color: Colores.blanco,)
                                        ),
                                        index == _.fotosAdicionales.value.length - 1 ? Container() : 
                                        IconButton(
                                          onPressed: (){
                                            dynamic aux = _.fotosAdicionales.value[index];
                                              _.fotosAdicionales.value[index] = _.fotosAdicionales.value[index + 1];
                                              _.fotosAdicionales.value[index + 1] = aux;
                                              _.fotosAdicionales.refresh();
                                          }, 
                                          icon: const Icon(BootstrapIcons.caret_right_fill, color: Colores.blanco,),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )  
                            )
                          ),
                          )
                        ],
                      );
                    }
                  )
                ],
              )
            ),
            const SizedBox(height: 100,)
          ],
        ));
      }
    );
  }
  
  
}