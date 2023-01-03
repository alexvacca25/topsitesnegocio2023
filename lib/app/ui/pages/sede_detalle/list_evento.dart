import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/sede_controller.dart';
import 'widgets/list_tarjeta.dart';

class ListEventoPage extends GetView {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SedeController>(
      builder: (_){
        return ListTarjeta(lista: _.sede.value.eventos,textoListaVacia: 'Aun no agregas eventos',);
      }
    );
  }
}