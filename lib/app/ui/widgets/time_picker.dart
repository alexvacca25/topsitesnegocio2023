
import '../theme/colores.dart';
import 'package:flutter/material.dart';

class TimePicker {
  Future<TimeOfDay?> porDefecto(context, {TimeOfDay? hour})async {
    TimeOfDay? hora = await showTimePicker(
      context: context,
        initialTime: hour ?? TimeOfDay.now(),
        builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colores.rosa,
              onSurface: Colores.rosa,
            ),
          ),
          child: child!,
          );
        },
    );
    return hora;
  }
}