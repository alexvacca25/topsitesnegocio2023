
import 'package:badges/badges.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:topsitesnegocio/app/controllers/home_controller.dart';
import 'package:topsitesnegocio/app/ui/widgets/input.dart';
import 'package:topsitesnegocio/app/ui/widgets/modal.dart';

import '../../theme/colores.dart';
import 'form_usuario.dart';

class ListUsuarios extends GetResponsiveView{
  
  ListUsuarios({super.key});

  @override
  Widget builder() {
    return GetBuilder<HomeController>(
      builder: (_){
        return Builder(
          builder: (context) => Scaffold(
            backgroundColor: Colores.gris,
            body: Center(
              child: Container(
                width: screen.isDesktop ? 600 : null,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colores.blanco,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Usuarios'),
                          IconButton(onPressed: (){
                            Modal.child(
                              context,
                              child: FormUsuario()
                            );
                          }, icon: const Icon(BootstrapIcons.plus))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Inputs(controller: TextInputController(), titulo: 'Buscar',),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            for(int i = 0; i < 10; i++)
                            Container(
                              decoration: BoxDecoration(
                                color: Colores.blancoOscuro,
                                borderRadius: BorderRadius.circular(5)
                              ),
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              child: Row(
                                children: [
                                  Badge(
                                    position: BadgePosition.bottomEnd(bottom: 1, end: 1),
                                    badgeColor: i%2==0?Colores.rojo:Colores.verde,
                                    child: CircleAvatar(
                                      child: Icon(BootstrapIcons.person),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text('Nombre usuario')
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}