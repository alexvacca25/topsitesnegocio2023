class Pais{
  dynamic id;
  String nombre;
  List<Departamento>? departamentos;
  Pais({
    required this.id,
    required this.nombre,
    this.departamentos
  });
}
class Departamento {
  dynamic id;
  String nombre;
  List<Ciudad>? ciudades;
  Departamento({
    required this.id,
    required this.nombre,
    this.ciudades,
  });
}
class Ciudad {
  String id;
  String nombre;
  Ciudad({
    required this.id,
    required this.nombre,
  });
}
