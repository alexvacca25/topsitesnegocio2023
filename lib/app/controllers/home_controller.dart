import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:topsitesnegocio/app/controllers/sesion_controller.dart';

import '../data/repository/token_repository.dart';
import '../ui/pages/usuario/usuario_list.dart';
import '../ui/pages/sede_list/sedes_list.dart';

class HomeController extends GetxController {

  SesionController sesionController = Get.find();
  final vista = 0.obs;

  List vistas = [
    {
      'nombre': 'Inicio',
      'icono': BootstrapIcons.house,
      'vista': SedesList()
    },
    {
      'nombre': 'Reservas o compras',
      'icono': BootstrapIcons.check2_square,
      'vista': const Scaffold(body: Text(''),)
    },
    {
      'nombre': 'Documentacion',
      'icono': BootstrapIcons.filetype_pdf,
      'vista': const Scaffold(body: Text(''),)
    },
    {
      'nombre': 'Usuarios',
      'icono': BootstrapIcons.person,
      'vista': ListUsuarios()
    },
  ];


  @override
  void onInit() async{
    String? token = await TokenRepository().getToken();
    if(token==null){
      cerrarSesion();
    }
    super.onInit();
  }

  Future<void> cerrarSesion()async{
    await TokenRepository().deletetoken();
    Get.offAllNamed('/');
  }
}