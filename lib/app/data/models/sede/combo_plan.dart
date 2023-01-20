import 'package:flutter/material.dart';

import 'package:topsitesnegocio/app/data/models/metodos.dart';
import 'package:topsitesnegocio/app/data/models/sede/imagenes_sede.dart';
import 'package:topsitesnegocio/app/data/models/sede/termino_condicion.dart';

import 'adicion.dart';
import 'fecha_hora.dart';

class ComboPlan {
  dynamic id;
  bool estado;
  String nombre;
  String descripcion;
  Imagen imagenPrincipal;
  List<Imagen> imagenes;
  List<FechaHora>  fechaHora;
  List<DetalleComboPlan> detalles;
  List<Adicion> adiciones;
  List<TerminoCondicion> terminosCondiciones;
  int numeroEstrellas;
  
  ComboPlan({
    required this.id,
    required this.estado,
    required this.nombre,
    required this.descripcion,
    required this.imagenPrincipal,
    required this.imagenes,
    required this.fechaHora,
    required this.detalles,
    required this.adiciones,
    required this.terminosCondiciones,
    required this.numeroEstrellas,
  });

  factory ComboPlan.construir(
    {
      id,
      estado,
      nombre,
      descripcion,
      imagenPrincipal,
      imagenes,
      fechaHora,
      detalles,
      adiciones,
      numeroEstrellas,
      terminosCondiciones
    }
  ){
    return ComboPlan(
      id: id ,
      estado: estado ?? true,
      nombre: nombre ?? '',
      descripcion: descripcion ?? '',
      imagenPrincipal: imagenPrincipal ?? Imagen(),
      imagenes: imagenes ?? [],
      fechaHora: fechaHora ?? [],
      detalles: detalles ?? [],
      adiciones: adiciones ?? [],
      terminosCondiciones: terminosCondiciones ?? [],
      numeroEstrellas: numeroEstrellas ?? 0
    );
  }


  agregarDetalle(DetalleComboPlan detalle){
    detalles.add(detalle);
  }
  agregarImagen(Imagen imagen){
    imagenes.add(imagen);
  }
  agregarFechaHora(FechaHora fechaHora){
    this.fechaHora.add(fechaHora);
  }
  agregarAdicion(Adicion adicion){
    adiciones.add(adicion);
  }
}



class DetalleComboPlan {
  dynamic id;
  String nombre;
  DetalleComboPlan({
    this.id,
    this.nombre = '',
  });
}

