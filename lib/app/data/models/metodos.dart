import 'package:flutter/material.dart';

horaToString(TimeOfDay hora){
  return '${hora.hourOfPeriod}:${hora.minute < 10 ? '0${hora.minute}' : hora.minute } ${hora.period == DayPeriod.am ? 'a.m.' : 'p.m.'}';
}

fechaToString(DateTime fecha){
  return '${fecha.day}/${fecha.month}/${fecha.year}';
}

