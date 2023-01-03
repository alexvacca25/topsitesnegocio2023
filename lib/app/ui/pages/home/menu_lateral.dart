
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:topsitesnegocio/app/controllers/home_controller.dart';

import '../../theme/colores.dart';
import '../../theme/imagenes.dart';

class MenuLateral extends GetResponsiveView{  

  // HomeController homeController = Get.find();

  @override
  Widget builder() {
    return GetBuilder<HomeController>(
      builder: (_){
        return Container(
          width: 50,
          height: Get.height,
          color: Colores.azulOscuro,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: List.generate(
                      screen.isDesktop ? _.vistas.length - 1 : _.vistas.length, 
                      (index) => Padding(
                        padding: const EdgeInsets.only(top:20, bottom: 10),
                        child: IconButton(
                          onPressed: (){
                            _.vista.value = index;
                          },
                          icon: Obx(
                            () => Icon(
                              _.vistas[index]['icono'], 
                              color: _.vista.value == index ? Colores.verde : Colores.blanco,
                            )
                          )
                        ),
                      ),
                    )
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child: Image.asset(Imagenes.logo30x30, width: 30,)
              )
            ],
          )
        );
      }
    );
  }
}

class MenuDrawer extends GetResponsiveView{

  HomeController homeController = Get.find();

  MenuDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget builder() {
    return Stack(
      children: [
        Container(
          width: 300,
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
            color: Colores.azulOscuro,
          ),
          height: Get.height,
          child:  SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage('https://i.picsum.photos/id/177/2515/1830.jpg?hmac=G8-2Q3-YPB2TreOK-4ofcmS-z5F6chIA0GHYAe5yzDY'),
                            fit: BoxFit.cover
                          ),
                          color: Colores.blanco,
                        ),
                        height: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [
                            Container(
                              color: Colores.azul,
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Text('Nombre Negocio', style: TextStyle(color: Colores.blanco),),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Column(
                      children: List.generate(
                        !screen.isDesktop ? homeController.vistas.length : homeController.vistas.length -1, 
                        (index) => ListTile(
                          selected: homeController.vista.value == index,
                          selectedColor: Colores.verde,
                          textColor: Colores.blanco,
                          iconColor: Colores.blanco,
                          leading: Icon(homeController.vistas[index]['icono']),
                          title: Text(homeController.vistas[index]['nombre']),
                          onTap: (){
                            Get.back();
                            homeController.vista.value = index;
                          },
                        )
                      )
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          // child: TituloWidget()
          child: Image.asset(Imagenes.logox40,height: 40,)
        ),
      ],
    );
  }
}