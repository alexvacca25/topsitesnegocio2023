import 'dart:convert';

class TipoServicio {
  dynamic id;
  dynamic foto;
  String? nombre;
  bool? estado;
  String? categoria;

  TipoServicio({
    this.id,
    this.foto,
    this.nombre,
    this.estado,
    this.categoria,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'foto': foto});
    if(nombre != null){
      result.addAll({'nombre': nombre});
    }
    if(estado != null){
      result.addAll({'estado': estado});
    }
    if(categoria != null){
      result.addAll({'categoria': categoria});
    }
  
    return result;
  }

  factory TipoServicio.fromMap(Map<String, dynamic> map) {
    return TipoServicio(
      id: map['id'],
      foto: map['foto'],
      nombre: map['nombre'],
      estado: map['estado'],
      categoria: map['categoria'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TipoServicio.fromJson(String source) => TipoServicio.fromMap(json.decode(source));
}
