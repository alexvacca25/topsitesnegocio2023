
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:topsitesnegocio/app/controllers/sede_controller.dart';
import 'package:topsitesnegocio/app/ui/theme/colores.dart';
import 'package:topsitesnegocio/app/ui/theme/fonts.dart';
import 'package:topsitesnegocio/app/ui/widgets/modal.dart';

import '../../../widgets/visor_imagenes.dart';
import 'opciones_sede.dart';
class ImagenesNombreDescripcion extends StatelessWidget {

  ImagenesNombreDescripcion({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SedeController>(
      builder: (_){
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Obx(() => MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: (){
                        Modal.child(context, child: VisorImagenes(imagenes: [_.sede.value.imagenesSede.fotoPrincipal],));
                      },
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colores.negro,
                          image: DecorationImage(
                            image: NetworkImage(_.sede.value.imagenesSede.fotoPrincipal.imagen),
                            fit: BoxFit.cover,
                            onError: (exception, stackTrace) {},
                          )
                        ),
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(() => MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: (){
                                  Modal.child(context, child: VisorImagenes(imagenes: [_.sede.value.imagenesSede.fotoLogo],));
                                },
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colores.blanco,
                                  backgroundImage: NetworkImage(_.sede.value.imagenesSede.fotoLogo.imagen),
                                  onBackgroundImageError: (exception, stackTrace) {},
                                ),
                              ),
                            ),)
                          ],
                        ),
                      ),
                    ),
                  ),)
                ),
              ],
            ),
            Padding(                  
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(()=>Row(
                    children: [
                      Expanded(
                        child: Text(
                          _.sede.value.informacionGeneral.nombre,
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: Fuentes.ztgrafton
                          ),
                        ),
                      ),
                      const OpcionesSede(),
                    ],
                  )),
                  SizedBox(height: 10,),
                  Obx(
                    ()=>Text(
                      _.sede.value.informacionGeneral.descripcion.isEmpty ? 'Agrega una descripción' : _.sede.value.informacionGeneral.descripcion,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: Fuentes.ztgraftonThin
                      )
                    ),
                  ),
                  SizedBox(height: 10,),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                      child: Obx(
                        () => Row(
                        children: List.generate(
                          _.sede.value.imagenesSede.fotosAdicionales.length, 
                          (index) => MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: (){
                                Modal.child(context, child: VisorImagenes(imagenes: _.sede.value.imagenesSede.fotosAdicionales,inicial: index,));
                              },
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                width: 80,height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colores.blancoOscuro,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      _.sede.value.imagenesSede.fotosAdicionales[index].imagen
                                    ),
                                    fit: BoxFit.cover
                                  )
                                ),
                                        
                              ),
                            ),
                          )
                        ),
                      )
                    )
                  ),
                ],
              ),
            ),
          ],
        );
      }
    );
  }
}