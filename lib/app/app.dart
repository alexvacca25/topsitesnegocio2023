import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:topsitesnegocio/app/bindings/sesion_binding.dart';
import 'package:topsitesnegocio/app/ui/pages/login/login.dart';

import 'constantes.dart';
import 'routes/app_pages.dart';
import 'ui/theme/fonts.dart';

class App extends StatelessWidget {  

  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      //propiedad que permite arrastrar elementos con el mouse como si fuera "tactil"
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch, PointerDeviceKind.stylus, PointerDeviceKind.unknown},
      ),
      title: titulo,
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
      initialBinding: SesionBinding(),
      theme: ThemeData(
        fontFamily: Fuentes.ztgrafton
      ),
      getPages: AppPages.pages,
    );
  }
}