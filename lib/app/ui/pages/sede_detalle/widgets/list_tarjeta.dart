
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/tarjeta.dart';

class ListTarjeta extends StatelessWidget {

  final List lista;
  final String textoListaVacia;

  const ListTarjeta({super.key, required this.lista, required this.textoListaVacia});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraints){
        dynamic width = constraints.maxWidth;
        dynamic widthTarjeta = width < 600 ? Get.width : ((600 / 2)-10);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            lista.isEmpty ? Text(textoListaVacia) : Wrap(
              spacing: 5,
              runSpacing: 5,
              children: [
                for(int i=0; i<lista.length; i++)
                Tarjeta(
                  width: widthTarjeta,
                  imagen: 'https://picsum.photos/536/354',                                    
                  titulo: 'asd',
                  subtitulo: 'asd',
                  opciones: Icon(BootstrapIcons.plus),
                  numeroEstrellas: 0,
                )
              ],
            ),
          ],
        );
      }
    );
  }
}