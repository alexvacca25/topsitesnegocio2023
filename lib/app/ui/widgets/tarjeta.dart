import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';

import '../theme/colores.dart';
import '../theme/fonts.dart';

class Tarjeta extends StatelessWidget {

  final double width;
  final String titulo;
  final String subtitulo;
  final int? numeroEstrellas;
  final String imagen;
  final String? foto;
  final dynamic opciones;
  final Function()? onTap;

  const Tarjeta({
    Key? key,
    required this.width,
    this.titulo = '',
    this.subtitulo = '',
    this.numeroEstrellas,
    this.imagen = '',
    this.foto,
    this.opciones, 
    this.onTap,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colores.grisClaro,
                image: DecorationImage(
                  image: NetworkImage(imagen),
                  onError: (exception, stackTrace) {},
                  fit: BoxFit.cover
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  opciones ?? Container(),
                  Row(
                    children: [
                      foto == null ? Container() : CircleAvatar(radius: 30, backgroundColor: Colores.blanco,backgroundImage: NetworkImage(foto!), onBackgroundImageError: (exception, stackTrace) {})
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              color: Colores.blancoOscuro,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titulo,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: Fuentes.ztgrafton
                    ),
                  ),
                  numeroEstrellas==null ? Container() : Wrap(
                    spacing: 3,
                    children: List.generate(5, (index) => Icon(BootstrapIcons.star_fill, size: 12, color: index < numeroEstrellas! ? Colores.amarillo : Colores.grisClaro)),
                  ),
                  SizedBox(height: numeroEstrellas==null ? 0 : 8),
                  Text(
                    subtitulo, 
                    textAlign: TextAlign.justify,
                    maxLines: 3,
                    style: const TextStyle(
                      fontSize: 10,
                      fontFamily: Fuentes.ztgraftonThin
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
