import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:topsitesnegocio/simulacionbackend/backend_negocio.dart';
import 'package:url_strategy/url_strategy.dart';
import 'app/app.dart';







Future<void> main() async{
  //inicializando get storage para guardar el token del usuario
  await GetStorage.init();
  //inicializo negociobackend para simular el backend y poder procesar los datos como si estuviera realizando consultas
  Get.put(BackendNegocio());
  //esto quita el # que aparece en la barra de busqueda
  setPathUrlStrategy();
  
  runApp(const App());
}








