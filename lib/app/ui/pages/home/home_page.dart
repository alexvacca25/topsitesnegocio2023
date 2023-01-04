
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:topsitesnegocio/app/controllers/home_controller.dart';
import 'package:topsitesnegocio/app/ui/widgets/titulo.dart';

import '../../theme/colores.dart';
import '../../widgets/error_pantalla.dart';
import 'menu_lateral.dart';

class HomePage extends GetView {
  
  const HomePage({super.key});  

  @override
  Widget build(BuildContext context) {
    return ResponsiveHome();
  }
}

// ignore: must_be_immutable
class ResponsiveHome extends GetResponsiveView{

  HomeController homeController = Get.find();

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
      /**
       * muestra las opciones del menu
       * - inicio
       * - reserva o compra 
       * - usuarios (esta opcion la muestra cuando el tamaño de la pantalla no es escritorio)
       */
      drawer: MenuDrawer(),
      body: Row(
        children: [

          //muestra el menu lateral solo si es escritorio
          !screen.isDesktop ? Container() : MenuLateral(),

          //muestra el contrnido del item seleccionado
          //el contenido de la lista es cargado con los elementos de la lista definida en home controller vistas
          Expanded(
            child: Container(
              color: Colores.rojo,
              child: Obx(() => homeController.vistas[homeController.vista.value]['vista']),
            )
          ),
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
          const PopupMenuItem(
            enabled: false, 
            child: Divider()
          ),
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

