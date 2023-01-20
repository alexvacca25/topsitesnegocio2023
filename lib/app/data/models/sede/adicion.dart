
import 'imagenes_sede.dart';

class Adicion {
  dynamic id;
  String? nombre;
  double? valor;
  double? cantidadMaxima;
  bool? aplicaDescuento;
  int? descuento;
  Imagen imagen;
  Adicion({
    this.id,
    this.nombre,
    this.valor,
    this.cantidadMaxima,
    this.aplicaDescuento,
    this.descuento,
    required this.imagen,
  });
}