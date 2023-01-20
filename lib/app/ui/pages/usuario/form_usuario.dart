import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:topsitesnegocio/app/ui/theme/colores.dart';
import 'package:topsitesnegocio/app/ui/widgets/boton.dart';
import 'package:topsitesnegocio/app/ui/widgets/input.dart';
import 'package:topsitesnegocio/app/ui/widgets/modal.dart';
import 'package:topsitesnegocio/app/ui/widgets/switch.dart';

import '../../../data/models/sede/combo_plan.dart';


class FormUsuario extends StatelessWidget {
  
  const FormUsuario({super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive();
  }
}
class Responsive extends GetResponsiveView {

  final cambia = false.obs;
  
  Responsive();

  @override
  Widget builder() {
    return Builder(
      builder: (BuildContext context) => DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Usuario'),
            backgroundColor: Colores.negro,
            automaticallyImplyLeading: false,
            bottom: TabBar(
              tabs: [
                Tab(text: 'Información General',),
                Tab(text: 'Permisos',),
              ],
            ),
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
          body: TabBarView(
            children: [
              informacionGeneral(),
              permisos()
            ],
          )
        ),
      ),
    );
  }

  ListView permisos() {
    return ListView(
      padding: EdgeInsets.all(10),
      children: [
        armarItemPermiso([Text('Información general'),
        Text('Imágenes del negocio'),
        Text('Combos/Planes'),
        Text('Eventos'),
        Text('Servicios de renta'),
        Text('Tickets de consumo'),
        Text('Términos y condiciones'),
        Text('Pagos / Cobros'),
        Text('Documentación'),
        Text('Usuarios y permisos'),
        Text('Reservas'),]),
        SizedBox(height: 100,)

      ],
    );
  }

  ListView informacionGeneral() {
    return ListView(
          padding: EdgeInsets.all(10),
        children: [
          DropdownButton(
            icon: const Icon(Icons.keyboard_arrow_down_outlined),
            items: [
              DropdownMenuItem(child: Text('Tipo de identificación'))
            ], 
            onChanged: (vaue){}
          ),
          Inputs(controller: TextInputController(), titulo: 'Número identificación',),
          Row(
            children: [
              Expanded(child: Inputs(controller: TextInputController(), titulo: 'Nombres')),
              SizedBox(width: 10,),
              Expanded(child: Inputs(controller: TextInputController(), titulo: 'Apellidos')),
            ],
          ),
          Inputs(controller: TextInputController(), titulo: 'Correo'),
          SizedBox(height: 10,),
          Row(
            children: [
              Expanded(
                child: Text('Codigo generado')
              ),
              Expanded(
                child: Text(
                  'asd856',
                  textAlign: TextAlign.end,
                )
              ),
              IconButton(onPressed: (){}, icon: Icon(BootstrapIcons.paperclip))
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                      value: true,
                      groupValue: true,
                      onChanged: (value) {
                      },
                    ),
                    Expanded(child: Text('Usuario tipo promotor'))
                  ],
                ),
              ),
              Expanded(
                child: BotonTexto(
                  texto: 'Ver compras bajo codigo promotor ',
                  textAlign: TextAlign.end,
                )
              )
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: SwitchPersonalizado(estado: true, onChanged: (value){},texto: 'Estado',)),
              SizedBox(width: 10,),
              Text('Activo', textAlign: TextAlign.end,)
            ],
          ),
          SizedBox(height: 100,),
        ],
    );
  }
  
  armarItemPermiso(List<Text> elementos) {
    return Column(
      children: List.generate(
        elementos.length, (index) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: elementos[index]),
            SizedBox(width: 10,),
            Expanded(
              child: DropdownButton(
                icon: const Icon(Icons.keyboard_arrow_down_outlined),
                items: [
                  DropdownMenuItem(child: Text('Consulta'), value: '0',),
                  DropdownMenuItem(child: Text('Modifica')),
                ], 
                value: '0',
                onChanged: (vaue){}
              )
            )
          ],
        )
      )
    );
  }
}
