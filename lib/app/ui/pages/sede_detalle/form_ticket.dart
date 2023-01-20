import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:topsitesnegocio/app/data/models/sede/ticket.dart';

import 'package:topsitesnegocio/app/ui/theme/colores.dart';
import 'package:topsitesnegocio/app/ui/widgets/boton.dart';
import 'package:topsitesnegocio/app/ui/widgets/file_picker.dart';
import 'package:topsitesnegocio/app/ui/widgets/imagen.dart';
import 'package:topsitesnegocio/app/ui/widgets/input.dart';
import 'package:topsitesnegocio/app/ui/widgets/input_hora.dart';
import 'package:topsitesnegocio/app/ui/widgets/modal.dart';

import '../../../data/models/sede/imagenes_sede.dart';
import '../../../data/models/sede/termino_condicion.dart';
import '../../widgets/input_fecha.dart';
import 'form_terminos_condiciones.dart';


class FormTicket extends StatelessWidget {

  final Ticket ticket;

  const FormTicket({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Responsive(ticket: ticket);
  }
}
class Responsive extends GetResponsiveView {

  /// estas variables son empleadas para escuchar los cambios de los respesctivos datos
  /// a los que hace refencia
  /// descuento
  /// fecha de vencimiento
  /// hora inicio y fin
  final cambiaDescuento = false.obs;
  final cambiaFechaVencimiento = false.obs;
  final cambiaHoraInicio = false.obs;
  final cambiaHoraFin = false.obs;
  final cambiaImagen = false.obs;
  final cambiaTerminoCondicion = false.obs;

  /// se inicializan los textinputs controller que obtendran los datos de cada
  /// input, si se necesita mostrar un error en el input
  /// textInputController tiene la propiedad error a la cual se le asigna un string
  /// solo es decir txtEjemplo.error.value = 'esto es un ejemplo'
  TextInputController txtValor = TextInputController();
  TextInputController txtCantidadMaximaTicket = TextInputController();
  TextInputController txtCantidadMaximaLugar = TextInputController();
  TextInputController txtDiasVencimiento = TextInputController();


  final Ticket ticket;
  //aqui se recibe por parametros el tickete para ser guardado, si 
  //es para agregar el id == null
  Responsive({
    super.key, 
    required this.ticket,
  });

  @override
  Widget builder() {
    return Builder(
      builder: (BuildContext context) => DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Ticket'),
            backgroundColor: Colores.negro,
            automaticallyImplyLeading: false,
            bottom: const TabBar(
              isScrollable: true,
              tabs: [
                Tab(text: 'Información General',),
                Tab(text: 'Terminos y condiciones',),
              ],
            ),
            actions: [
              IconButton(onPressed: (){
                /// este metodo se ejecuta si presiona en la x que se encuentra en la parte superior derecha del form
                Modal.porDefecto(
                  context, 
                  child: const Text('¿Seguro que quieres cerrar?'), 
                  onAceptar: (){
                    Get.back();
                    Get.back();
                  }
                );
              }, icon: const Icon(BootstrapIcons.x))
            ],
          ),
          floatingActionButton: Wrap(
            direction: Axis.horizontal, 
              children: [
                Boton(
                  accion: ()=>Get.back(),
                  color: Colores.gris,
                  child: const Text('Cancelar'),
                ),
                const SizedBox(width: 10,),
                Boton(
                  accion: (){
      
                    /**
                     * aqui es donde va la accion de guardar o editar
                     * se deben agregar las validaciones pertinentes
                     * 
                     */
      
                    if(ticket.id==null){
                      /**
                       * acciones de agregar
                       */
                    }else{
                      /**
                       * acciones de editar
                       */
                    }
      
                  },
                  color: Colores.verde,
                  child: const Text('Guardar'),
                ),
              ],
          ),
          body: TabBarView(
            children: [
              informacionGeneral(),
              Obx(
                (){
                  cambiaTerminoCondicion.value;
                  return terminosCondiciones(context);
                }
              )
            ],
          )
        ),
      ),
    );
  }

  ListView terminosCondiciones(BuildContext context) {
    return ListView(
                  padding: EdgeInsets.all(10),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Términos y condiciones'),
                        IconButton(
                          onPressed: () async {
                            ///se reutiliza el formulario de terminos y condiciones para obtener el termino y condicion
                            Modal.child(
                              context,
                              child: FormTerminosCondiciones(terminoCondicion: TerminoCondicion(), esObtener: true,)
                            ).then(
                              (value){
                                ///se agrega el nuevo elemento a la lista de terminos y condiciones
                                ticket.terminosCondiciones.add(value);
                                cambiaTerminoCondicion.value = !cambiaTerminoCondicion.value;
                              }
                            );
                          },
                          icon: Icon(BootstrapIcons.plus),
                        ),
                      ],
                    ),
                    Column(
                      children: List.generate(
                        ticket.terminosCondiciones.length,
                        (index) => Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: Colores.blancoOscuro,
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      ticket.terminosCondiciones[index].titulo,
                                      maxLines: 1,
                                      style: const TextStyle(
                                        fontSize: 20,
                                      ),
                                    )
                                  ),
                                  PopupMenuButton(
                                    padding: const EdgeInsets.all(0),
                                    tooltip: 'Opciones',
                                    icon: const Icon(
                                      Icons.more_horiz,
                                      color: Colores.negro,
                                    ),
                                    itemBuilder: (BuildContext context) =>
                                        <PopupMenuEntry>[
                                      PopupMenuItem(
                                        padding: const EdgeInsets.all(0),
                                        child: ListTile(
                                          onTap: (){
                                            Get.back();
                                            Modal.child(
                                              context,
                                              child: FormTerminosCondiciones(terminoCondicion: ticket.terminosCondiciones[index],esObtener: true,)
                                            ).then((value) {
                                              ///acciones que se ejecutan para actualizar el termino condicion
                                            });
                                          },
                                          leading: const Icon(BootstrapIcons.pen),
                                          title: const Text('Editar'),
                                        ),
                                      ),
                                      PopupMenuItem(
                                        padding: const EdgeInsets.all(0),
                                        child: ListTile(
                                          onTap: (){
                                            Get.back();
                                            Modal.porDefecto(
                                              context,
                                              child: Text('¿Quieres eliminar este Termino condición?'),
                                              onAceptar: ()async{
                                                ///acciones a realizar si se quiere eliminar el termino condicion
                                              }
                                            );
                                          },
                                          leading: const Icon(BootstrapIcons.trash),
                                          title: const Text('Eliminar'),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: 5,),
                              Text(
                                ticket.terminosCondiciones[index].descripcion,
                                maxLines: 3,
                                textAlign: TextAlign.justify,
                                style: const TextStyle(
                                  fontSize: 10
                                ),
                              ),
                            ],
                          ),
                        )
                      ),
                    )
                  ],
                );
  }

  informacionGeneral()  {
    return ListView(
              children: [
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: ()async{
                      /**
                       * aqui se cambia la imagen
                       */
                      PlatformFile? result = await Files.obtenerImagen();
                      if (result != null) {
                        if(GetPlatform.isWeb){
                          ticket.imagen.imagen = result.bytes;
                        }else{
                          ticket.imagen.imagen = result.path;
                        }
                        ticket.imagen.tipo = Imagen.FILE;
                        cambiaImagen.value = !cambiaImagen.value;
                      } 
                    },
                    child: Obx(
                      (){
                        cambiaImagen.value;
                        return Container(
                          width: double.infinity,
                          height: 300,
                          decoration: BoxDecoration(
                            color: Colores.azul,
                            image: DecorationImage(
                              image: imagenWidget(tipo: ticket.imagen.tipo, imagen: ticket.imagen.imagen),
                              onError: (o,s){},
                              fit: BoxFit.cover
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(BootstrapIcons.camera, color: Colores.blanco,),
                              SizedBox(height: 10,),
                              Text('Imágen', style: TextStyle(color: Colores.blanco),),
                            ],
                          ),
                        );
                      }
                    )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Inputs(
                        controller: txtValor, 
                        titulo: 'Valor'
                      ),
                      Inputs(
                        controller: txtCantidadMaximaTicket, 
                        titulo: 'Cantidad máx por ticket',
                      ),
                      Inputs(
                        controller: txtCantidadMaximaLugar, 
                        titulo: 'Cantidad máx por lugar',
                      ),
                      Obx(
                        (){
                          cambiaFechaVencimiento.value;
                          return InputsFecha(
                            titulo: 'Fecha de vencimiento', 
                            fecha: ticket.strFecha,
                            fechaInicial: ticket.fechaVencimiento,
                            getFecha: (DateTime? value){
                              if(value!=null){
                                /**
                                 * aqui se cambia a fecha de vencimiento
                                */
                                ticket.fechaVencimiento = value;
                                cambiaFechaVencimiento.value = !cambiaFechaVencimiento.value;
                              }
                            },
                          );
                        }
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        children: [
                          Expanded(
                            child: Obx(
                              () {
                                cambiaDescuento.value;
                                return DropdownButton(
                                  isExpanded: true, 
                                  items: List.generate(
                                    101, 
                                    (index) => DropdownMenuItem(
                                      value: '$index',
                                      child: Text('$index% de descuento'),
                                    )
                                  ), 
                                  value: '${ticket.descuento}', 
                                  onChanged: (value){
                                    /**
                                     * aqui se cambia el valor del descuento
                                     */
                                    ticket.descuento = int.parse(value.toString());
                                    cambiaDescuento.value = !cambiaDescuento.value;
                                  }
                                );
                              }
                            )
                          ),
                        ],
                      ),
                      Obx(
                        (){
                          cambiaDescuento.value;
                          return ticket.descuento == 0 ? Container() :
                          Column(
                            children: [
                              Inputs(
                                controller: txtDiasVencimiento, 
                                titulo: 'Dias de vencimiento', 
                                tipoTeclado: TextInputType.number,
                              ),
                              const SizedBox(height: 5,),
                              Obx(
                                (){
                                  cambiaHoraInicio.value;
                                  return InputsHora(
                                    getHora: (value){
                                      if(value!=null){
                                        /**
                                         * aqui se cambia el valor de la hora de inicio
                                         */
                                        ticket.horaInicio = value;
                                        cambiaHoraInicio.value = !cambiaHoraInicio.value;
                                      }
                                    }, 
                                    hora: ticket.strHoraInicio, 
                                    horaInicial: ticket.horaInicio, 
                                    titulo: 'Hora Inicio',
                                  );
                                }
                              ),
                              const SizedBox(height: 10,),
                              Obx(
                                (){
                                  cambiaHoraFin.value;
                                  return InputsHora(
                                    getHora: (value){
                                      if(value!=null){
                                        /**
                                         * aqui se cambia el valor de la hora fin
                                         */
                                        ticket.horaFin = value;
                                        cambiaHoraFin.value = !cambiaHoraFin.value;
                                      }
                                    }, 
                                    hora: ticket.strHoraFin, 
                                    horaInicial: ticket.horaFin, 
                                    titulo: 'Hora Fin',
                                  );
                                }
                              )
                            ],
                          );
                        }
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 100,),
              ],
            );
  }
}
