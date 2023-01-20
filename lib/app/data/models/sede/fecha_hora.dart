
import 'package:flutter/material.dart';

import '../metodos.dart';

class FechaHora {
  dynamic id;
  DateTime fechaInicio;
  DateTime fechaFin;
  TimeOfDay horaInicio;
  TimeOfDay horaFin;
  double valor;
  bool? aplicaDescuento;
  int descuento;

  get strFechaInicio{
    return fechaToString(fechaInicio);
  }
  get strFechaFin{
    return fechaToString(fechaFin);
  }
  get strHoraInicio{
    return horaToString(horaInicio);
  }
  get strHoraFin{
    return horaToString(horaFin);
  }

  FechaHora({
    this.id,
    required this.fechaInicio,
    required this.horaInicio,
    required this.fechaFin,
    required this.horaFin,
    required this.valor,
    this.aplicaDescuento,
    required this.descuento,
  });

  factory FechaHora.construir({
      id,
      fechaInicio,
      horaInicio,
      fechaFin,
      horaFin,
      valor,
      aplicaDescuento,
      descuento,
    }){
    return FechaHora(
      id: id,
      fechaInicio: fechaInicio ?? DateTime.now(),
      fechaFin: fechaFin ?? DateTime.now(),
      horaInicio: horaInicio ?? TimeOfDay.now(),
      horaFin: horaFin ?? TimeOfDay.now(),
      valor: valor ?? 0,
      aplicaDescuento: aplicaDescuento,
      descuento: descuento ?? 0,
    );
  }
}