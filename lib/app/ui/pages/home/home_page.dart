
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:topsitesnegocio/app/controllers/home_controller.dart';
import 'package:topsitesnegocio/app/ui/widgets/titulo.dart';

import '../../theme/colores.dart';
import '../../widgets/error_pantalla.dart';
import '../usuario/usuario_list.dart';
import 'menu_lateral.dart';

class HomePage extends GetView {
  
  HomePage({super.key});
  // HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveHome();
  }
}

// ignore: must_be_immutable
class ResponsiveHome extends GetResponsiveView{

  HomeController homeController = Get.find();

  List opciones = [
    {'titulo':'Perfil','icono':BootstrapIcons.person, 'value': 1},
    {'titulo':'Opciones','icono':BootstrapIcons.sliders, 'value': 2},
    {'titulo':'Documentacion','icono':BootstrapIcons.sliders, 'value': 2},
    {'titulo':'Cerrar sesion','icono':BootstrapIcons.box_arrow_left, 'value': 3},
  ];
  
  // final BuildContext context;

  ResponsiveHome({super.key});

  @override
  Widget builder() {
    if(screen.isWatch){
      return const Scaffold(body: ErrorPantalla());
    }
    if(Get.height < 400){
      return const Scaffold(body: ErrorPantalla());
    }
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colores.crema,
          centerTitle: true,
          title: const TituloWidget(fontSize: 15,),
          iconTheme: const IconThemeData(color: Colores.negro),
          actions:  menuOpciones(),
        )
      ),
      drawer: MenuDrawer(),
      body: Row(
        children: [
          !screen.isDesktop ? Container() : MenuLateral(),
          Expanded(
            child: Container(
              color: Colores.rojo,
              child: Obx(() => homeController.vistas[homeController.vista.value]['vista']),
            )
          ),
          !screen.isDesktop ? Container() : ListUsuarios()
        ],
      )
    );
  }

  menuOpciones(){
    return [
      PopupMenuButton(
        tooltip: 'Opciones',
        initialValue: null,
        itemBuilder: (BuildContext context) => [
          PopupMenuItem(
            onTap: (){},
            child: const ListTile(title: Text('Perfil'))
          ),
          PopupMenuItem(
            onTap: (){},
            child: const ListTile(title: Text('Opciones'))
          ),
          PopupMenuItem(
            onTap: (){},
            child: const ListTile(title: Text('Documentacion'))
          ),
          const PopupMenuItem(enabled: false, child: Divider()),
          PopupMenuItem(
            onTap: ()async{
              await homeController.cerrarSesion();
            },
            child: const ListTile(title: Text('Cerrar sesion'))
          ),
        ],
        child: const CircleAvatar(
          backgroundColor: Colores.azulOscuro,
          backgroundImage: NetworkImage('https://i.picsum.photos/id/177/2515/1830.jpg?hmac=G8-2Q3-YPB2TreOK-4ofcmS-z5F6chIA0GHYAe5yzDY'),
        ),
      ),
      const SizedBox(width: 10,)
    ];
  }
}

