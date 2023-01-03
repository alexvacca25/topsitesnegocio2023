import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/sede_controller.dart';
import 'widgets/list_tarjeta.dart';
class ListTicketsPage extends GetView {
@override
  Widget build(BuildContext context) {
    return GetBuilder<SedeController>(
      builder: (_){
        return ListTarjeta(lista: _.sede.value.tickets,textoListaVacia: 'Aun no agregas ticketes',);
      }
    );
  }
}