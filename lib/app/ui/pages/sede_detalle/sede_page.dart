
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:topsitesnegocio/app/controllers/sede_controller.dart';
import 'package:topsitesnegocio/app/ui/theme/colores.dart';
import 'detalles_sede.dart';

class SedePage extends GetView {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SedeController>(
      builder: (_){        
        return Obx(
          () => _.buscando.value ? cargando() : Contenedor()
        );
      }
    );
  }

  Scaffold cargando() {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

class Contenedor extends GetResponsiveView {
  
  Contenedor({super.key});

  @override
  Widget builder() {
    return Builder(
      builder:(context) => Scaffold(
        backgroundColor: Colores.grisClaro,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colores.blanco,
            elevation: 2,
            leading: IconButton(onPressed: ()=>Get.back(), icon: const Icon(BootstrapIcons.arrow_left_short, color: Colores.negro,),),
          ),
        ),
        body: LayoutBuilder(
          builder: (context,constraints){
            double widthActual = constraints.maxWidth;
            dynamic ancho = widthActual > 600.0 ? 600.0 : Get.width;
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: screen.isDesktop ? 10 : 0),
                  width: ancho,
                  child: DetallesSede()
                ),
                // Get.width < 1100 ? Container() : HorariosExcepciones()
              ],
            );
          },
        ),
      ),
    );
  }
}
