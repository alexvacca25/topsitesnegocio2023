
import 'package:topsitesnegocio/app/data/models/sede/evento.dart';
import 'package:topsitesnegocio/app/data/models/sede/pago_cobro.dart';
import 'package:topsitesnegocio/app/data/models/sede/termino_condicion.dart';
import 'package:topsitesnegocio/app/data/models/sede/ticket.dart';

import 'combo_plan.dart';
import 'horario_sede.dart';
import 'imagenes_sede.dart';
import 'informacion_general.dart';
import 'renta.dart';

class Sede {
  dynamic id;

  InformacionGeneral informacionGeneral;
  PagoCobro pagoCobro;
  ImagenesSede imagenesSede;
  
  
  Horario horario;
  List<ComboPlan> combosPlanes;
  List<Evento> eventos;
  List<Renta> rentas;
  List<Ticket> tickets;
  List<TerminoCondicion> terminosCondiciones;



  dynamic fechaRegistro;
  dynamic estado;

  Sede({
    required this.id,
    required this.informacionGeneral,
    required this.pagoCobro,
    required this.imagenesSede,
    required this.horario,
    required this.combosPlanes,
    required this.eventos,
    required this.rentas,
    required this.tickets,
    required this.terminosCondiciones,
    required this.fechaRegistro,
    required this.estado,
  });
  
  factory Sede.construir({
    id,
    informacionGeneral,
    pagoCobro,
    imagenesSede,
    horario,
    combosPlanes,
    eventos,
    rentas,
    tickets,
    terminosCondiciones,
    fechaRegistro,
    estado,
  }){
    return Sede(
      id: id ,
      informacionGeneral: informacionGeneral ?? InformacionGeneral.construir(),
      pagoCobro: pagoCobro ?? PagoCobro(),
      imagenesSede: imagenesSede ?? ImagenesSede.construir(),
      horario: horario ?? Horario.construir(),
      combosPlanes: combosPlanes ?? [],
      eventos: eventos ?? [],
      rentas: rentas ?? [],
      tickets: tickets ?? [],
      terminosCondiciones: terminosCondiciones ?? [] ,
      fechaRegistro: fechaRegistro ,
      estado: estado ,
    );
  }

}

