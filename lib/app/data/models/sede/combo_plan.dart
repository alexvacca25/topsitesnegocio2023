class ComboPlan {
  dynamic id;
  bool? estado;
  String? nombre;
  String? descripcion;
  List<dynamic>? imagenes;
  List<FechaHora>?  fechaHora;
  List<DetalleComboPlan>? detalles;
  List<Adicion>? adiciones;
  
  ComboPlan({
    this.id,
    this.estado,
    this.nombre,
    this.descripcion,
    this.imagenes,
    this.fechaHora,
    this.detalles,
    this.adiciones,
  });


  agregarDetalle(DetalleComboPlan detalle){
    if(detalles==null){
      detalles = [detalle];
    }else{
      detalles!.add(detalle);
    }
  }

  get getDetalles{
    return detalles ?? [];
  }
  agregarImagen(dynamic imagen){
    if(imagenes==null){
      imagenes = [imagen];
    }else{
      imagenes!.add(imagen);
    }
  }

  get getImagenes{
    return imagenes ?? [];
  }
  agregarFechaHora(FechaHora fechaHora){
    if(this.fechaHora==null){
      this.fechaHora = [fechaHora];
    }else{
      this.fechaHora!.add(fechaHora);
    }
  }

  get getFechaHora{
    return fechaHora ?? [];
  }
  agregarAdicion(Adicion adicion){
    if(adiciones==null){
      adiciones = [adicion];
    }else{
      adiciones!.add(adicion);
    }
  }

  get getAdiciones{
    return adiciones ?? [];
  }

}


class FechaHora {
  dynamic id;
  DateTime? fechaHoraInicio;
  DateTime? fechaHoraFin;
  double? valor;
  bool? aplicaDescuento;
  int? descuento;

  FechaHora({
    this.id,
    this.fechaHoraInicio,
    this.fechaHoraFin,
    this.valor,
    this.aplicaDescuento,
    this.descuento,
  });
}

class DetalleComboPlan {
  dynamic id;
  String nombre;
  DetalleComboPlan({
    this.id,
    this.nombre = '',
  });
}

class Adicion {
  dynamic id;
  String? nombre;
  double? valor;
  int? cantidadMaxima;
  bool? aplicaDescuento;
  int? descuento;
  Adicion({
    this.id,
    this.nombre,
    this.valor,
    this.cantidadMaxima,
    this.aplicaDescuento,
    this.descuento,
  });
}
