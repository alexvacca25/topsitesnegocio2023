import 'package:flutter/material.dart';

import 'package:topsitesnegocio/app/data/models/sede/combo_plan.dart';
import 'package:topsitesnegocio/app/data/models/sede/termino_condicion.dart';

import '../metodos.dart';
import 'adicion.dart';
import 'imagenes_sede.dart';

class Evento {
  dynamic id;
  String nombre;
  dynamic tipoEvento;
  Imagen imagenPrincipal;
  int aforoPermitido;
  int cantidadMaxPersonas;
  String descripcion;
  bool estado;
  int numeroEstrellas;

  DateTime fechaInicio;
  TimeOfDay horaInicio;
  DateTime fechaFin;
  TimeOfDay horaFin;

  List<UbicacionEvento> ubicaciones;
  List<Adicion> adiciones;
  List<TerminoCondicion> terminosCondiciones;

  List<Imagen> imagenes;

  ComboPlan? comboPlan;
  int? tiempoPermitidoCancelar;

  agregarAdicion(Adicion adicion){
    adiciones.add(adicion);
  }
  agregarUbicacion(UbicacionEvento ubicacionEvento){
    ubicaciones.add(ubicacionEvento);
  }
  agregarImagen(Imagen imagen){
    imagenes.add(imagen);
  }

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
  Evento({
    required this.id,
    required this.nombre,
    required this.tipoEvento,
    required this.imagenPrincipal,
    required this.aforoPermitido,
    required this.cantidadMaxPersonas,
    required this.descripcion,
    required this.estado,
    required this.numeroEstrellas,
    required this.fechaInicio,
    required this.horaInicio,
    required this.fechaFin,
    required this.horaFin,
    required this.ubicaciones,
    required this.adiciones,
    required this.terminosCondiciones,
    required this.imagenes,
    required this.comboPlan,
    required this.tiempoPermitidoCancelar,
  });

  factory Evento.construir({
    id,
    nombre,
    tipoEvento,
    aforoPermitido,
    cantidadMaxPersonas,
    descripcion,
    estado,
    ubicaciones,
    adiciones,
    comboPlan,
    tiempoPermitidoCancelar,
    imagenes,
    imagenPrincipal,
    fechaInicio,
    horaInicio,
    fechaFin,
    horaFin,
    numeroEstrellas,
    terminosCondiciones
  }){
    return Evento(
      id: id,
      nombre: nombre ?? '',
      tipoEvento: tipoEvento ?? '0',
      aforoPermitido: aforoPermitido ?? 0,
      cantidadMaxPersonas: cantidadMaxPersonas ?? 0,
      descripcion: descripcion ?? '',
      estado: estado ?? true,
      ubicaciones: ubicaciones ?? [],
      adiciones: adiciones ?? [],
      comboPlan: comboPlan,
      tiempoPermitidoCancelar: tiempoPermitidoCancelar,
      imagenes: imagenes ?? [],
      terminosCondiciones: terminosCondiciones ?? [],
      imagenPrincipal: imagenPrincipal ?? Imagen(),
      fechaInicio: fechaInicio ?? DateTime.now(),
      horaInicio: horaInicio ?? TimeOfDay.now(),
      fechaFin: fechaFin ?? DateTime.now(),
      horaFin: horaFin ?? TimeOfDay.now(),
      numeroEstrellas: numeroEstrellas ?? 0
    );
  }
}

class UbicacionEvento {
  dynamic id;
  String nombre;
  int? cantidad;
  DateTime? fechaHora;
  double? valor;

  UbicacionEvento({
    this.id,
    this.nombre = '',
    this.cantidad,
    this.fechaHora,
    this.valor,
  });
}







