
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:topsitesnegocio/app/ui/widgets/time_picker.dart';

import '../theme/colores.dart';
import 'date_picker.dart';

class InputsHora extends StatelessWidget {

  final mostrarClave = true.obs;
  final estaEnfocado = false.obs;

  final String? titulo;
  final String? hora;
  final TimeOfDay horaInicial;
  final Function(TimeOfDay?) getHora;

  InputsHora({
    super.key, 
    this.titulo, 
    this.hora, 
    required this.getHora, 
    required this.horaInicial,
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
              Text('$hora'),
              IconButton(
                onPressed: ()async{
                  TimePicker().porDefecto(context,hour: horaInicial).then((value) => getHora(value));
                }, 
                icon: const Icon(BootstrapIcons.clock)
              )
            ],
          ),
        ),
      ],
    );
  }  
}