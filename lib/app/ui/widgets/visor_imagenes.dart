import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:topsitesnegocio/app/data/models/sede/imagenes_sede.dart';
import 'package:topsitesnegocio/app/ui/theme/colores.dart';
/**
 * sirve para ver las iganes que se le pase por parametros
 * debe enviarse una lista
 * y si se quiere que inicie en una posicion especifica
 * se le manda la posicion
 */
class VisorImagenes extends StatelessWidget {

  final currentIndex = 0.obs;
  final List<Imagen> imagenes;
  final int inicial;

  VisorImagenes({super.key, required this.imagenes, this.inicial = 0});

  @override
  Widget build(BuildContext context) {
    currentIndex.value = inicial;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colores.negro,
        elevation: 0,
        actions: [
          IconButton(onPressed: ()=>Get.back(), icon: const Icon(BootstrapIcons.x))
        ],
      ),
      backgroundColor: Colores.negro,
      body: Container(
        child: Obx(
          ()=>PhotoViewGallery.builder(
            itemCount: imagenes.length,
            onPageChanged: (int index) {
              currentIndex.value = index;
            },
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(
                  imagenes[index].imagen,
                ),
                minScale: PhotoViewComputedScale.contained * 0.8,
                maxScale: PhotoViewComputedScale.covered * 2,
              );
            },
            scrollPhysics: const BouncingScrollPhysics(),
            enableRotation: true,
            backgroundDecoration: const BoxDecoration(
              color: Colores.negro
            ),
            pageController: PageController(initialPage: currentIndex.value),
            loadingBuilder: (context, event) => const Center(
              child: SizedBox(
                width: 30.0,
                height: 30.0,
                child:  CircularProgressIndicator(
                  backgroundColor: Colores.blanco,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}