import 'package:topsitesnegocio/app/data/models/sede/combo_plan.dart';

class Evento {
  dynamic id;
  String nombre;
  dynamic tipoEvento;
  int? aforoPermitido;
  int? cantidadMaxPersonas;
  String? descripcion;
  bool estado;

  List<UbicacionEvento>? uviacaiones;
  List<Adicion>? adiciones;

  ComboPlan? comboPlan;
  int? tiempoPermitidoCancelar;

  Evento({
    this.id,
    this.nombre = '',
    this.tipoEvento,
    this.aforoPermitido,
    this.cantidadMaxPersonas,
    this.descripcion,
    this.estado = false,
    this.uviacaiones,
    this.adiciones,
    this.comboPlan,
    this.tiempoPermitidoCancelar,
  });
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


class Adicion {
  dynamic id;
  String nombre;
  int? cantidadMaxStock;
  double? valor;
  int? descuento;
  
  Adicion({
    this.id,
    this.nombre = '',
    this.cantidadMaxStock,
    this.valor,
    this.descuento,
  });
}





