
// import 'package:bootstrap_icons/bootstrap_icons.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:topsitesnegocio/app/constantes.dart';
// import 'package:topsitesnegocio/app/data/models/sede/combo_plan.dart';
// import 'package:topsitesnegocio/app/ui/theme/colores.dart';
// import 'package:topsitesnegocio/app/ui/theme/fonts.dart';
// import 'package:topsitesnegocio/app/ui/widgets/boton.dart';
// import 'package:topsitesnegocio/app/ui/widgets/modal.dart';
// import 'package:topsitesnegocio/app/ui/widgets/tarjeta.dart';

// import '../sede/pages/tabs/combo_plan_sede/form_combo_plan.dart';
// import '../sede/pages/tabs/evento_sede/form_evento.dart';
// import '../sede/pages/tabs/imagenes_sede/imagenes.dart';
// import '../sede/pages/tabs/informacion_general_sede/informacion_general.dart';
// import '../sede/pages/tabs/pago_cobro_sede/pago_cobro.dart';
// import '../sede/pages/tabs/renta_sede/form_renta.dart';

// class DocumentoPage extends GetView {

//   @override
//   Widget build(BuildContext context) {
//     return Responsive(context);
//   }
// }

// class Responsive extends GetResponsiveView {

//   final context;

//   Responsive(this.context);

//   @override
//   Widget builder() {
//     return Container(
//       color: Colores.blanco,
//       child: Container(
//         // width: Get.width > 1024 ? 1024 : null,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Expanded(
//               child: Container(
//                 child: BottomBar(context)
//               ),
//             ),
//             Get.width < 1000 ? Container() : HorariosExcepciones()
//           ],
//         ),
//       ),
//     );
//   }
// }

// class HorariosExcepciones extends StatelessWidget {

//   HorariosExcepciones({
//     Key? key,
//   }) : super(key: key);

//   List minutos = ['15 MIN','30 MIN', '60 MIN'];
//   List diasSemana = [
//     'L',
//     'M',
//     'M',
//     'J',
//     'V',
//     'S',
//     'D',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 500,
//       child: Scaffold(
//         body: Column(
//           children: [
//             Expanded(
//               child: Container(
//                 margin: EdgeInsets.only(bottom: 5, left: 10, right: 10, top: 10),
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: Colores.blancoOscuro,
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(10),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text('Horarios'),
//                           Icon(BootstrapIcons.plus)
//                         ],
//                       ),
//                     ),
//                     Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(5),
//                         color: Colores.blanco,
//                       ),
//                       margin: EdgeInsets.all(10),
//                       padding: EdgeInsets.all(10),
//                       // height: 40,
//                       child: Row(
//                         children: [
//                           Text('Permitir reserva cada:'),
//                           Expanded(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 for(int i=0; i<minutos.length; i++)
//                                   Container(
//                                     height: 30,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(5),
//                                       color: Colores.verde,
//                                     ),
//                                     padding: EdgeInsets.symmetric(horizontal: 10),
//                                     margin: EdgeInsets.symmetric(horizontal: 5),
//                                     child: Column(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         Text(
//                                           '${minutos[i]}', 
//                                           style: TextStyle(
//                                             color: Colores.blanco,
//                                             fontSize: 12
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 //end for
//                               ],
//                             )
//                           )
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       child: SingleChildScrollView(
//                         primary: false,
//                         child: Container(
//                           width: double.infinity,
//                           padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                           child: Column(
//                             children: List.generate(
//                               100, 
//                               (index) => Container(
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(5),
//                                   color: Colores.blanco,
//                                 ),
//                                 margin: EdgeInsets.symmetric(vertical: 5),
//                                 padding: EdgeInsets.all(10),
//                                 child: Row(
//                                   children: [
//                                     Expanded(
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           for(int i = 0; i < diasSemana.length; i++)
//                                             CircleAvatar(
//                                               radius: 10,
//                                               backgroundColor: Colores.verde,
//                                               child: Text('${diasSemana[i]}', style: TextStyle(fontSize: 8, color: Colores.blanco)),
//                                             ),
//                                           //end for
//                                         ],
//                                       )
//                                     ),
//                                     SizedBox(width: 5,),
//                                     Expanded(
//                                       child: Text('12:00 a.m - 06:00 p.m', style: TextStyle(fontSize: 12),)
//                                     ),
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.end,
//                                       children: [
//                                         Boton(
//                                           color: Colores.rojo,
//                                           child: Icon(BootstrapIcons.trash, color: Colores.blanco,),
//                                         ),
//                                         SizedBox(width: 10,),
//                                         Boton(
//                                           color: Colores.verde,
//                                           child: Icon(BootstrapIcons.pencil, color: Colores.blanco,),
//                                         )
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               )
//                             ),
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               )
//             ),
//             Expanded(
//               child: Container(
//                 margin: EdgeInsets.only(bottom: 5, left: 10, right: 10, top: 10),
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: Colores.blancoOscuro,
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(10),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text('Excepciones'),
//                           IconButton(onPressed: (){},icon: Icon(BootstrapIcons.plus))
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       child: SingleChildScrollView(
//                         primary: false,
//                         child: Container(
//                           width: double.infinity,
//                           padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                           child: Column(
//                             children: List.generate(
//                               100, 
//                               (index) => Container(
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(5),
//                                   color: Colores.blanco,
//                                 ),
//                                 margin: EdgeInsets.symmetric(vertical: 5),
//                                 padding: EdgeInsets.all(10),
//                                 child: Row(
//                                   children: [
//                                     Expanded(
//                                       child: index % 2 == 0 ? Text('11/11/2022 - 11/11/2022', style: TextStyle(fontSize: 10),) : Row(
//                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           for(int i = 0; i < diasSemana.length; i++)
//                                             CircleAvatar(
//                                               radius: 10,
//                                               backgroundColor: Colores.verde,
//                                               child: Text('${diasSemana[i]}', style: TextStyle(fontSize: 8, color: Colores.blanco)),
//                                             ),
//                                           //end for
//                                         ],
//                                       )
//                                     ),
//                                     SizedBox(width: 5,),
//                                     Expanded(
//                                       child: Text('12:00 a.m - 06:00 p.m', style: TextStyle(fontSize: 10))
//                                     ),
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.end,
//                                       children: [
//                                         Boton(
//                                           color: Colores.rojo,
//                                           child: Icon(BootstrapIcons.trash, color: Colores.blanco,),
//                                         ),
//                                         SizedBox(width: 10,),
//                                         Boton(
//                                           color: Colores.verde,
//                                           child: Icon(BootstrapIcons.pencil, color: Colores.blanco,),
//                                         )
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               )
//                             ),
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               )
//             ),
            
            
//           ],
//         ),
//       ),
//     );
//   }
// }


// class BottomBar extends GetResponsiveView {

//   final seleccionado = 0.obs;
//   final context;

//   List vistas = [
//     'Combos / planes',
//     'Eventos',
//     'Renta',
//     'Tickets',
//     'Terminos y condiciones',
//   ];

//   BottomBar(this.context);

//   @override
//   Widget builder() {
//     return DefaultTabController(
//       length: 5,
//       child: Container(
//         decoration: BoxDecoration(
//           border: Border(
//             right: BorderSide(color: Colores.negro, width: 1)
//           )
//         ),
//         child: Scaffold(
//           appBar: PreferredSize(
//             preferredSize: Size.fromHeight(40),
//             child: AppBar(
//               automaticallyImplyLeading: false,
//               backgroundColor: Colores.blanco,
//               elevation: 2,
//               actions: [
//                 Icon(BootstrapIcons.search, color: Colores.negro,),
//                 SizedBox(width: 10,)
//               ],
//             ),
//           ),
//           backgroundColor: Colores.blanco,
//           floatingActionButton: FloatingActionButton(
//             onPressed: (){
//               Modal.porDefecto(
//                 context,
//                 mostrarAcciones: false,
//                 titulo: 'Selecciona la accion a realizar',
//                 child: Column(
//                   children: [
//                     Wrap(
//                       runSpacing: 10,
//                       spacing: 10,
//                       children: [
//                         Boton(
//                           accion: (){
//                             Get.back();
//                             Modal.child(
//                               context,
//                               barrierDismissible: false,
//                               child: FormComboPlanPage(comboPlan: ComboPlan(),)
//                             ).then((value){
//                               if(value!=null){
//                               }
//                             });
//                           },
//                           color: Colores.verde,
//                           colorHover: Colores.verdeOscuro,
//                           child: Text('Agregar Combo / plan'),
//                         ),
//                         Boton(
//                           accion: (){
//                             Get.back();
//                             Modal.child(
//                               context,
//                               barrierDismissible: false,
//                               child: FormEventoPage()
//                             ).then((value){
//                               if(value!=null){
//                                 // agregarEditarSedeController.combosPlanes.value[index] = value;
//                                 // agregarEditarSedeController.combosPlanes.refresh();
//                               }
//                             });
//                           },
//                           color: Colores.verde,
//                           colorHover: Colores.verdeOscuro,
//                           child: Text('Agregar nuevo evento'),
//                         ),
//                         Boton(
//                           accion: (){
//                             Get.back();
//                             Modal.child(
//                               context,
//                               barrierDismissible: false,
//                               child: FormRentaPage()
//                             ).then((value){
//                               if(value!=null){
//                                 // agregarEditarSedeController.combosPlanes.value[index] = value;
//                                 // agregarEditarSedeController.combosPlanes.refresh();
//                               }
//                             });
//                           },
//                           color: Colores.verde,
//                           colorHover: Colores.verdeOscuro,
//                           child: Text('Agregar nueva renta'),
//                         ),
//                         Boton(
//                           accion: (){
//                             Get.back();
//                           },
//                           color: Colores.verde,
//                           colorHover: Colores.verdeOscuro,
//                           child: Text('Agregar nuevo ticket'),
//                         ),
//                         Boton(
//                           accion: (){
//                             Get.back();
//                           },
//                           color: Colores.verde,
//                           colorHover: Colores.verdeOscuro,
//                           child: Text('Agregar nuevo Termino y condicion'),
//                         ),
//                       ],
//                     )
//                   ],
//                 )
//               );
//             },
//             backgroundColor: Colores.verde,
//             child: Icon(BootstrapIcons.plus),
//           ),
//           bottomNavigationBar: Container(
//             decoration: BoxDecoration(
//               border: Border(top: BorderSide(width: 1, color: Colores.negro)),
//               color: Colores.blanco,
//             ),
//             height: 40,
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Expanded(
//                     child: TabBar(
//                       labelColor: Colores.negro,
//                       unselectedLabelColor: Colores.gris,
//                       indicatorSize: TabBarIndicatorSize.label,
//                       indicatorColor: Colores.blanco,
//                       indicator: null,
//                       onTap: (value){
//                         seleccionado.value = value;
//                       },
//                       tabs: [
//                         Tab(
//                           text: "Combo / plan",                
//                         ),
//                         Tab(
//                           text: "Evento",
//                         ),
//                         Tab(
//                           text: "Renta",
//                         ),
//                         Tab(
//                           text: "Tickets",
//                         ),
//                         Tab(
//                           text: "Terminos y condiciones",
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//           ),
//           body: ListView(
//             children: [
//               Row(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       height: 200,
//                       color: Colores.crema,
//                       width: double.infinity,
//                       padding: EdgeInsets.all(20),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           CircleAvatar(
//                             radius: 50,
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Container(
//                 color: Colores.blanco,
//                 padding: const EdgeInsets.all(10),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Text(
//                             'Nombre sede',
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontFamily: Fuentes.ztgrafton
//                             ),
//                           ),
//                         ),
//                         PopupMenuButton(
//                           padding: EdgeInsets.all(0),
//                           tooltip: 'Opciones',
//                           icon: Icon(
//                             Icons.more_horiz,
//                             color: Colores.negro,
//                           ),
//                           itemBuilder: (BuildContext context) =>
//                               <PopupMenuEntry>[
//                             PopupMenuItem(
//                               padding: EdgeInsets.all(0),
//                               child: ListTile(
//                                 onTap: () {
//                                   Get.back();
//                                   Modal.child(
//                                     context,
//                                     child: InformacionGeneralPage()
//                                   );
//                                 },
//                                 leading:
//                                     Icon(BootstrapIcons.info),
//                                 title: Text('Informacion general'),
//                               ),
//                             ),
//                             PopupMenuItem(
//                               padding: EdgeInsets.all(0),
//                               child: ListTile(
//                                 onTap: (){
//                                   Get.back();
//                                   Modal.child(
//                                     context,
//                                     child: PagosCobrosPage()
//                                   );

//                                 },
//                                 leading:
//                                     Icon(BootstrapIcons.coin),
//                                 title: Text('Pagos y cobros'),
//                               ),
//                             ),
//                             PopupMenuItem(
//                               padding: EdgeInsets.all(0),
//                               child: ListTile(
//                                 onTap: (){
//                                   Get.back();
//                                   Modal.child(
//                                     context,
//                                     child: ImagenesPage()
//                                   );

//                                 },
//                                 leading:
//                                     Icon(BootstrapIcons.image),
//                                 title: Text('Imagenes'),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 10,),
//                     Text(
//                       lorem,
//                       textAlign: TextAlign.justify,
//                       style: TextStyle(
//                         fontSize: 15,
//                         fontFamily: Fuentes.ztgraftonThin
//                       )
//                     ),
//                     SizedBox(height: 10,),
//                     SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: Row(
//                         children: List.generate(
//                           5, 
//                           (index) => Container(
//                             margin: EdgeInsets.all(5),
//                             width: 80,height: 80,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(5),
//                               color: Colores.blancoOscuro,
//                               image: DecorationImage(
//                                 image: NetworkImage(
//                                   'https://i.picsum.photos/id/15/2500/1667.jpg?hmac=Lv03D1Y3AsZ9L2tMMC1KQZekBVaQSDc1waqJ54IHvo4'
//                                 ),
//                                 fit: BoxFit.cover
//                               )
//                             ),

//                           )
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 10,),
//                     Get.width > 1000 ? Container() : 
//                     SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: Boton(
//                         accion: (){
//                           Modal.child(
//                             context,
//                             child: Scaffold(
//                               appBar: AppBar(
//                                 automaticallyImplyLeading: false,
//                                 title: Text('Horarios y Excepciones'),
//                                 backgroundColor: Colores.negro,
//                                 actions: [
//                                   IconButton(onPressed: ()=>Get.back(), icon: Icon(BootstrapIcons.x))
//                                 ],
//                               ),
//                               body: HorariosExcepciones(),
//                             )
//                           );
//                         },
//                         color: Colores.verde,
//                         child: Text('Ver Horarios y excepciones')
//                       )
//                     ),
//                     SizedBox(height: 10,),
//                   ],
//                 ),
//               ),

//               Obx(
//                 () => Padding(
//                   padding: const EdgeInsets.all(10),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         vistas[seleccionado.value],
//                         style: TextStyle(
//                           color: Colores.negro,
//                           fontSize: 20
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               ),

//               SizedBox(height: 20,),

//               Column(
//                 children: [
//                   Wrap(
//                     spacing: 5,
//                     runSpacing: 5,
//                     children: [
//                       for(int i=0; i<5; i++)
//                       Tarjeta(width: screen.isPhone ? Get.width : 300,)
//                     ],
//                   ),
//                 ],
//               ),

//               SizedBox(height: 1000,)

//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

