import 'dart:convert';

class Usuario {
  int id;
  bool reestablecer;
  String correo;
  String clave;
  Usuario({
    required this.id,
    required this.reestablecer,
    required this.correo,
    required this.clave,
  });

  factory Usuario.construir({
    id = 0,
    reestablecer = false,
    correo = '',
    clave = '',
  }){
    return Usuario(id: id, reestablecer: reestablecer, correo: correo, clave: clave);
  }

  

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(id != null){
      result.addAll({'id': id});
    }
    if(correo != null){
      result.addAll({'correo': correo});
    }
    if(clave != null){
      result.addAll({'clave': clave});
    }
  
    return result;
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      id: map['id']?.toInt(),
      reestablecer: false,
      correo: map['correo'],
      clave: map['clave'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Usuario.fromJson(String source) => Usuario.fromMap(json.decode(source));
}
