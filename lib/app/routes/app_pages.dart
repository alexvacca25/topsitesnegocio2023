import 'package:get/get.dart';
import 'package:topsitesnegocio/app/bindings/home_binding.dart';
import 'package:topsitesnegocio/app/bindings/reestablecer_clave_binding.dart';
import 'package:topsitesnegocio/app/bindings/sede_binding.dart';
import 'package:topsitesnegocio/app/ui/pages/home/home_page.dart';
import 'package:topsitesnegocio/app/ui/pages/reestablecer_clave/reestablecer_clave.dart';
import 'package:topsitesnegocio/app/ui/pages/sede_detalle/sede_page.dart';
part './app_routes.dart';

class AppPages {

  static List<GetPage> pages = <GetPage>[
    GetPage(
      name: Routes.HOME, 
      page:() => HomePage(),
      transition: Transition.fadeIn,
      binding: HomeBinding()
    ),
    GetPage(
      name: Routes.SEDE, 
      page:() => SedePage(),
      transition: Transition.downToUp,
      binding: SedeBinding()
    ),
    GetPage(
      name: Routes.REESTABLECER, 
      page:() => ReestablecerClavePage(),
      transition: Transition.downToUp,
      binding: ReestablecerClaveBinding(),
    ),
  ];
}