import 'package:flutter/material.dart';

import 'package:topsitesnegocio/app/data/models/metodos.dart';
import 'package:topsitesnegocio/app/data/models/sede/imagenes_sede.dart';
import 'package:topsitesnegocio/app/data/models/sede/termino_condicion.dart';

class Ticket {
  dynamic id;
  double valor;
  Imagen imagen;
  double cantidadMaximaTicket;
  double cantidadMaximaLugar;
  int diasVencimiento;
  int descuento;
  DateTime fechaVencimiento;
  TimeOfDay horaInicio;
  TimeOfDay horaFin;
  int numeroEstrellas;

  List<TerminoCondicion> terminosCondiciones;

  Ticket({
    this.id,
    required this.valor,
    required this.imagen,
    required this.cantidadMaximaTicket,
    required this.cantidadMaximaLugar,
    required this.diasVencimiento,
    required this.descuento,
    required this.fechaVencimiento,
    required this.horaInicio,
    required this.horaFin,
    required this.numeroEstrellas,
    required this.terminosCondiciones,
  });

  get strFecha{
    return fechaToString(fechaVencimiento);
  }

  get strHoraInicio{
    return horaToString(horaInicio);
  }

  get strHoraFin{
    return horaToString(horaFin);
  }

  factory Ticket.construir({
    id,
    valor,
    imagen,
    cantidadMaximaTicket,
    cantidadMaximaLugar,
    diasVencimiento,
    descuento,
    fechaVencimiento,
    horaInicio,
    horaFin,
    numeroEstrellas,
    terminosCondiciones
  }){
    return Ticket(
      id: id,
      valor: valor ?? 0,
      imagen: imagen ?? Imagen(),
      cantidadMaximaTicket: cantidadMaximaTicket ?? 0,
      cantidadMaximaLugar: cantidadMaximaLugar ?? 0,
      diasVencimiento: diasVencimiento ?? 0,
      descuento: descuento ?? 0,
      fechaVencimiento: fechaVencimiento ?? DateTime.now(),
      horaInicio: horaInicio ?? const TimeOfDay(hour: 8, minute: 0),
      horaFin: horaFin ?? const TimeOfDay(hour: 8, minute: 0),
      numeroEstrellas: numeroEstrellas ?? 0,
      terminosCondiciones: terminosCondiciones ?? []
    );
  }

}
