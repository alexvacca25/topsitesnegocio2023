import 'package:flutter/material.dart';

import '../theme/colores.dart';

/**
 * es un showDatePicker
 * con estilos personalizados
 * el cual retorna una fecha
 */

class DatePicker {
  Future<DateTime?> porDefecto(context, {DateTime? fechaInicial })async{
    DateTime? fecha = await showDatePicker(
      context: context,
      initialDate: fechaInicial ?? DateTime.now(),
      firstDate:DateTime.now(),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colores.rosa, // <-- SEE HERE
              onPrimary: Colores.blanco, // <-- SEE HERE
              onSurface: Colores.gris, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colores.rosa, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    return fecha;
  }
}