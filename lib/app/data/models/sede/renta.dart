import 'package:topsitesnegocio/app/data/models/sede/termino_condicion.dart';

import 'adicion.dart';
import 'fecha_hora.dart';
import 'imagenes_sede.dart';

class Renta {
  dynamic id;
  String nombre;
  String descripcion;
  dynamic tipoRenta;
  Imagen imagenPrincipal;
  int cantidadDisponible;
  bool estado;
  int numeroEstrellas;
  List<Imagen> imagenes;
  List<FechaHora>  fechaHora;
  List<Adicion> adiciones;
  List<TerminoCondicion> terminosCondiciones;

  agregarFechaHora(FechaHora fechaHora){
    this.fechaHora.add(fechaHora);
  }
  agregarImagen(Imagen imagen){
    imagenes.add(imagen);
  }
  agregarAdicion(Adicion adicion){
    adiciones.add(adicion);
  }
  
  Renta({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.tipoRenta,
    required this.imagenPrincipal,
    required this.cantidadDisponible,
    required this.estado,
    required this.numeroEstrellas,
    required this.imagenes,
    required this.fechaHora,
    required this.adiciones,
    required this.terminosCondiciones,
  });

  factory Renta.construir({
    id,
    nombre,
    descripcion,
    tipoRenta,
    imagenPrincipal,
    cantidadDisponible,
    estado,
    numeroEstrellas,
    imagenes,
    fechaHora,
    adiciones,
    terminosCondiciones
  }){
    return Renta(
      id: id,
      nombre: nombre ?? '',
      descripcion: descripcion ?? '',
      tipoRenta: tipoRenta ?? '0',
      imagenPrincipal: imagenPrincipal ?? Imagen(),
      cantidadDisponible: cantidadDisponible ?? 0,
      estado: estado ?? false,
      numeroEstrellas: numeroEstrellas ?? 0,
      imagenes: imagenes ?? [],
      fechaHora: fechaHora ?? [],
      adiciones: adiciones ?? [],
      terminosCondiciones: terminosCondiciones ?? []
    );
  }
}
