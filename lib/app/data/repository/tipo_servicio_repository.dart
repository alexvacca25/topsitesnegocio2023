
import 'package:get/get.dart';

import '../models/tipo_servicio.dart';

class TipoServicioRepository extends GetxController {

  static const List<String> categoria = ['Planes', 'Lugares', 'Renta', 'Evento'];

  final tiposServicio  = <TipoServicio>[
    TipoServicio(id: '0',nombre: 'Restaurante',foto: 'https://cdn-icons-png.flaticon.com/512/1830/1830839.png', categoria: categoria[1]),
    TipoServicio(id: '1',nombre: 'Discoteca',foto: 'https://cdn-icons-png.flaticon.com/512/6454/6454522.png', categoria: categoria[1]),
    TipoServicio(id: '2',nombre: 'Bar',foto: 'https://cdn-icons-png.flaticon.com/512/3712/3712421.png', categoria: categoria[1]),
    TipoServicio(id: '3',nombre: 'Spa',foto: 'https://cdn-icons-png.flaticon.com/512/1858/1858270.png', categoria: categoria[1]),

    TipoServicio(id: '4',nombre: 'Yates',foto: 'https://cdn-icons-png.flaticon.com/512/1068/1068656.png', categoria: categoria[2]),
    TipoServicio(id: '5',nombre: 'Autos',foto: 'https://cdn-icons-png.flaticon.com/512/741/741407.png', categoria: categoria[2]),
    TipoServicio(id: '6',nombre: 'Botes',foto: 'https://cdn-icons-png.flaticon.com/512/2848/2848465.png', categoria: categoria[2]),
    
    TipoServicio(id: '7',nombre: 'Concierto',foto: 'https://cdn-icons-png.flaticon.com/512/1598/1598708.png', categoria: categoria[3]),
    TipoServicio(id: '8',nombre: 'Festival',foto: 'https://cdn-icons-png.flaticon.com/512/4668/4668417.png', categoria: categoria[3]),
  ].obs;


  getAll(){
    return tiposServicio.value;
  }

}