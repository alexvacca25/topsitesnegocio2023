
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/colores.dart';
import 'date_picker.dart';

class InputsFecha extends StatelessWidget {

  final mostrarClave = true.obs;
  final estaEnfocado = false.obs;

  final String? titulo;
  final String? fecha;
  final DateTime fechaInicial;
  final Function(DateTime?) getFecha;

  InputsFecha({
    super.key, 
    this.titulo, 
    this.fecha, 
    required this.getFecha, 
    required this.fechaInicial,
  });

  final FocusNode myFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(titulo ?? ''),
        Container(
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colores.negro, width: 1))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('$fecha'),
              IconButton(
                onPressed: ()async{
                  DatePicker().porDefecto(context, fechaInicial: fechaInicial).then((value) => getFecha(value));
                }, 
                icon: Icon(BootstrapIcons.calendar)
              )
            ],
          ),
        ),
      ],
    );
  }  
}