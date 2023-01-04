import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:topsitesnegocio/app/ui/widgets/input.dart';
import 'package:topsitesnegocio/app/ui/widgets/switch.dart';

import '../../theme/colores.dart';
import '../../widgets/boton.dart';
import '../../widgets/modal.dart';

class FormRenta extends GetView {
  
  const FormRenta({super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive();
  }
}

class Responsive extends GetResponsiveView {
  @override
  Widget builder() {
    return Builder(
      builder: (BuildContext context) => DefaultTabController(
        length: 4,
        child: Scaffold(
          floatingActionButton: Wrap(
            direction: Axis.horizontal, 
              children: [
                Container(child: Boton(
                  accion: ()=>Get.back(),
                  child: Text('Cancelar'),color: Colores.gris,)
                ),
                SizedBox(width: 10,),
                Container(child: Boton(
                  accion: ()=>Get.back(),
                  child: Text('Guardar'),color: Colores.verde,)),
              ],
          ),
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Información General',),
                Tab(text: 'Horarios',),
                Tab(text: 'Imagenes',),
                Tab(text: 'Adiciones',),
              ],
            ),
            title: Text('Renta'),
            backgroundColor: Colores.negro,
            automaticallyImplyLeading: false,
            actions: [
              IconButton(onPressed: (){
                Modal.porDefecto(
                  context, 
                  child: const Text('¿Seguro que quieres cerrar?'), 
                  onAceptar: (){
                    Get.back();
                    Get.back();
                  }
                );
              }, icon: Icon(BootstrapIcons.x))
            ],
          ),
          body: TabBarView(
            children: [
              ListView(
                children: [
                  Inputs(controller: TextInputController(), titulo: 'Nombre',),
                  DropdownButton(items: [DropdownMenuItem(child: Text('Tipo renta'))], onChanged: (value){}),
                  SizedBox(height: 10,),
                  Inputs(controller: TextInputController(), titulo: 'Cantidad disponible',),
                  Inputs(controller: TextInputController(), titulo: 'Descripción', maxLines: 3),
                  SwitchPersonalizado(estado: true, onChanged: (value){}, texto: 'Publicado',),
                ],
              ),


              ListView(
                children: [
                  const SizedBox(height: 20,),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Horario'),
                        BotonTexto(
                          accion: ()async{
                            
                          },
                          texto: 'Agregar Horario',
                          color: Colores.verde,
                        ),
                      ],
                    ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Inicio: 11/01/2022 5:00 p.m'),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Boton(
                              child: Icon(BootstrapIcons.calendar, color: Colores.blanco,),
                            ),
                            const SizedBox(width: 10,),
                            Boton(
                              child: Icon(BootstrapIcons.clock, color: Colores.blanco,),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Fin: 11/01/2022 5:00 p.m'),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Boton(
                              child: Icon(BootstrapIcons.calendar, color: Colores.blanco,),
                            ),
                            const SizedBox(width: 10,),
                            Boton(
                              child: Icon(BootstrapIcons.clock, color: Colores.blanco,),
                            )
                          ],
                        ),
                      ),
                      ]
              ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(child: Inputs(controller: TextInputController(), titulo: 'Valor',)),
                      SizedBox(width: 10,),
                      Expanded(child: DropdownButton(items: [DropdownMenuItem(child: Text('0% descuento'))], onChanged: (value){})),
                    ],
                  ),
                ],
              ),
              ListView(
                children: [
                  SizedBox(height: 20,),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Imagenes'),
                        BotonTexto(
                          accion: ()async{
                            
                          },
                          texto: 'Agregar Imagen',
                          color: Colores.verde,
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Wrap(
                      children: List.generate(
                        3, 
                        (index) => Container(
                          width: 140,
                          height: 140,
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colores.gris,
                            borderRadius: BorderRadius.circular(5),
                            // image: DecorationImage(
                            //   // image: comboPlan.getImagenes[index],
                            //   fit: BoxFit.cover
                            // )
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Boton(
                                accion: (){},
                                color: Colores.rojo,
                                child: Icon(BootstrapIcons.trash, color: Colores.blanco,),
                              ),
                            ],
                          ),
                        )
                      ),
                    ),
                  ],
                ),


              ListView(
                children: [

                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Adiciones'),
                      BotonTexto(
                        accion: (){
                          
                        },
                        texto: 'Agregar adición',
                        color: Colores.verde,
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Inputs(controller: TextInputController(),
                            titulo: 'Nombre',)),
                          SizedBox(width: 10,),
                          Expanded(
                            flex: 5,
                            child: Inputs(controller: TextInputController(), titulo: 'Cantidad max stock',)
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Inputs(controller: TextInputController(),
                            titulo: 'Valor',)),
                          SizedBox(width: 10,),
                          Expanded(
                            flex: 5,
                            child:DropdownButton(items: [DropdownMenuItem(child: Text('Departamento'))], onChanged: (value){})
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 100,),
                ],
              ),
              ]
            // ],
          )
        ),
      ),
    );
  }
}