import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:topsitesnegocio/app/ui/widgets/input.dart';
import 'package:topsitesnegocio/app/ui/widgets/switch.dart';

import '../../../data/models/sede/adicion.dart';
import '../../../data/models/sede/fecha_hora.dart';
import '../../../data/models/sede/imagenes_sede.dart';
import '../../../data/models/sede/renta.dart';
import '../../../data/models/sede/termino_condicion.dart';
import '../../theme/colores.dart';
import '../../widgets/boton.dart';
import '../../widgets/file_picker.dart';
import '../../widgets/imagen.dart';
import '../../widgets/input_fecha.dart';
import '../../widgets/input_hora.dart';
import '../../widgets/modal.dart';
import 'form_terminos_condiciones.dart';

class FormRenta extends GetView {
  
  final Renta renta;

  const FormRenta({super.key, required this.renta});

  @override
  Widget build(BuildContext context) {
    return Responsive(renta: renta,);
  }
}

class Responsive extends GetResponsiveView {

  final Renta renta;

  final cambiaInformacion = false.obs;
  final cambiaHorario = false.obs;
  final cambiaImagen = false.obs;
  final cambiaAdicion = false.obs;
  final cambiaTerminoCondicion = false.obs;


  TextInputController txtNombre = TextInputController();
  TextInputController txtDescripcion = TextInputController();
  TextInputController txtCantidadDisponible = TextInputController();
  TextInputController txtTiempoPermitidoHoras = TextInputController();

  Responsive({super.key, required this.renta});

  @override
  Widget builder() {
    return Builder(
      builder: (BuildContext context) => DefaultTabController(
        length: 5,
        child: Scaffold(
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
                    ///aqui se realiza el cambio o se agrega una nueva renta
                  //se deben realizar las validaciones pertinentes 
                  if(renta.id==null){
                    ///entonces es agregar
                  }else{
                    ///es editar
                  }
                  },
                  color: Colores.verde,
                  child: const Text('Guardar'),
                ),
              ],
          ),
          appBar: AppBar(
            bottom: const TabBar(
              isScrollable: true,
              tabs: [
                Tab(text: 'Información General',),
                Tab(text: 'Horarios',),
                Tab(text: 'Imagenes',),
                Tab(text: 'Adiciones',),
                Tab(text: 'Terminos y condiciones',),
              ],
            ),
            title: const Text('Renta'),
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
              }, icon: const Icon(BootstrapIcons.x))
            ],
          ),
          body: TabBarView(
            children: [
              Obx(
                () {
                  cambiaInformacion.value;
                  return informacion();
                }
              ),
              Obx(
                (){
                  cambiaHorario.value;
                  return fechaHora();
                }
              ),
              Obx(
                (){
                  cambiaImagen.value;
                  return imagenes();
                }
              ),
              Obx(
                (){
                  cambiaAdicion.value;
                  return adiciones();
                }
              ),
              Obx(
                (){
                  cambiaTerminoCondicion.value;
                  return terminosCondiciones(context);
                }
              )
            ]
          )
        ),
      ),
    );
  }

  ListView informacion() {
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
                  renta.imagenPrincipal.imagen = result.bytes;
                }else{
                  renta.imagenPrincipal.imagen = result.path;
                }
                renta.imagenPrincipal.tipo = Imagen.FILE;
                cambiaInformacion.value = !cambiaInformacion.value;
              } 
            },
            child: Obx(
              (){
                cambiaInformacion.value;
                return Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colores.azul,
                    image: DecorationImage(
                      image: imagenWidget(tipo: renta.imagenPrincipal.tipo, imagen: renta.imagenPrincipal.imagen),
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
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: DropdownButton(items: [DropdownMenuItem(child: Text('Tipo renta'))], onChanged: (value){})),
                ],
              ),
              Inputs(controller: txtNombre, titulo: 'Nombre',),
              Inputs(controller: txtDescripcion, titulo: 'Descripción', maxLines: 3),
              Inputs(controller: txtCantidadDisponible, titulo: 'Cantidad disponible',),
              Inputs(controller: txtTiempoPermitidoHoras, titulo: 'Tiempo permitido para cancelar en horas', tipoTeclado: TextInputType.number,),
              SwitchPersonalizado(estado: renta.estado, onChanged: (value){
                renta.estado = value;
                cambiaInformacion.value = !cambiaInformacion.value;
              }, texto: renta.estado ? 'Publicado' : 'Inactivo',),
            ],
          ),
        ),
        const SizedBox(height: 100,)
      ],
    );
  }

  fechaHora() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Fecha y hora'),
            BotonTexto(
              accion: () {
                ///aqui se agrega un elemento nuevo a la lista de horarios
                renta.agregarFechaHora(FechaHora.construir());
                cambiaHorario.value = !cambiaHorario.value;
              },
              texto: 'Agregar fecha y hora',
              color: Colores.verde,
            ),
          ],
        ),
        const SizedBox(height: 10,),
        Column( 
          ///se llama el metodo que retorna el widget que contiene el horario
          children: List.generate(
            renta.fechaHora.length,
            (index) => itemFechaHora(renta.fechaHora[index], index))
        ),
        const SizedBox(height: 100,),
      ],
    );
  }
  Container itemFechaHora(FechaHora fechaHora, index) {
    return Container(
      decoration: BoxDecoration(
        color: Colores.gris.withOpacity(0.3),
        borderRadius: BorderRadius.circular(5)),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Builder(
                  builder: (context){
                    return Boton(
                      accion: () {
                        Modal.porDefecto(
                          context,
                          child: const Text('¿Quieres eliminar este horario?'),
                          onAceptar: (){
                            /**
                             * qui se elimina el horario en la posicion index de la lista de horarios
                             */
                            renta.fechaHora.removeAt(index);
                            cambiaHorario.value = !cambiaHorario.value;
                            Get.back();
                          }
                        );
                      },
                      color: Colores.negro.withOpacity(0.5),
                      radio: 100,
                      child: const Icon(
                        BootstrapIcons.x,
                        color: Colores.blanco,
                      ),
                    );
                  }
                )
              ],
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: InputsFecha(
                  getFecha: (value){
                    ///asignacion de la fecha de inicio al elemento index de la lista de horarios
                    if(value!=null){
                      renta.fechaHora[index].fechaInicio = value;
                      cambiaHorario.value = !cambiaHorario.value;
                    }
                  }, 
                  fechaInicial: fechaHora.fechaInicio, 
                  fecha: fechaHora.strFechaInicio, 
                  titulo: 'Fecha y Hora inicio',
                )
              ),
              const SizedBox(width: 10,),
              Expanded(
                child: InputsHora(
                  getHora: (value){
                    ///asignacion de la hora de inicio al elemento index de la lista de horarios
                    if(value!=null){
                      renta.fechaHora[index].horaInicio = value;
                      cambiaHorario.value = !cambiaHorario.value;
                    }
                  }, 
                  horaInicial: fechaHora.horaInicio, 
                  hora: fechaHora.strHoraInicio,
                )
              )
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: InputsFecha(
                  getFecha: (value){
                    ///asignacion de la fecha de fin al elemento index de la lista de horarios
                    if(value!=null){
                      renta.fechaHora[index].fechaFin = value;
                      cambiaHorario.value = !cambiaHorario.value;
                    }
                  }, 
                  fechaInicial: fechaHora.fechaFin, 
                  titulo: 'Fecha y Hora Fin', 
                  fecha: fechaHora.strFechaFin,
                )
              ),
              const SizedBox(width: 10,),
              Expanded(
                child: InputsHora(
                  getHora: (value){
                    ///asignacion de la fecha de hora al elemento index de la lista de horarios
                    if(value!=null){
                      renta.fechaHora[index].horaFin = value;
                      cambiaHorario.value = !cambiaHorario.value;
                    }
                  }, 
                  horaInicial: TimeOfDay.now(), 
                  hora: fechaHora.strHoraFin,
                )
              )
            ],
          ),
        Row(
          children: [
            Expanded(
                flex: 4,
                child: Inputs(
                  controller: TextInputController().init('${fechaHora.valor}'),
                  onChanged: (str){
                    ///se toma el valor del horario en la posicion index y se le asigna el nuevo valor
                    ///se valida que el valor ingresado sea numerico y lo que contenga el input
                    ///no sea nulo
                    if(str!=null && str.isNum){
                      renta.fechaHora[index].valor = double.parse(str);
                    }
                  },
                  titulo: 'Valor',
                )),
            const SizedBox(width: 10,),
            Expanded(
              flex: 6,
              child: DropdownButton(
                  items: List.generate(
                      101,
                      (index) => DropdownMenuItem(
                      value: '$index',
                      child: Text(
                        '$index% descuento'
                      ), 
                    )
                  ),
                  value: fechaHora.descuento.toString(),
                  onChanged: (value) {
                    ///cambio del valor del descuento de la lista de horarios en la posicion index
                    fechaHora.descuento = int.parse(value.toString());
                    cambiaHorario.value = !cambiaHorario.value;
                  }),
            )
          ],
        ),        
      ]),
    );
  }

  imagenes() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Imágenes adicionales'),
            IconButton(
              onPressed: () async {
                ///seleccion de una nueva imagen para agregarla a la lista de imagenes adicionales
                PlatformFile? result = await Files.obtenerImagen();
                if (result != null) {
                  Imagen imagen = Imagen();
                  if(GetPlatform.isWeb){
                    imagen.imagen = result.bytes;
                  }else{
                    imagen.imagen = result.path;
                  }
                  imagen.tipo = Imagen.FILE;
                  renta.agregarImagen(imagen);
                  cambiaImagen.value = !cambiaImagen.value;
                } 
              },
              icon: const Icon(BootstrapIcons.plus),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Wrap(
          children: List.generate(
              renta.imagenes.length,
              (index) => Container(
                    width: 140,
                    height: 140,
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colores.gris,
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            image: imagenWidget(imagen:renta.imagenes[index].imagen, tipo:renta.imagenes[index].tipo),
                            fit: BoxFit.cover)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Boton(
                          radio: 100,
                          accion: () {
                            /// metodo que elimina foto adicional de la posicion index
                            renta.imagenes.removeAt(index);
                            cambiaImagen.value = !cambiaImagen.value;
                          },
                          color: Colores.blanco.withOpacity(0.5),
                          child: const Icon(
                            BootstrapIcons.x,
                            color: Colores.blanco,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            index == 0 ? Container() : 
                            IconButton(
                              onPressed: (){
                                if(index!=0){
                                  dynamic aux = renta.imagenes[index];
                                  renta.imagenes[index] =renta.imagenes[index - 1];
                                 renta.imagenes[index - 1] = aux;
                                  cambiaImagen.value = !cambiaImagen.value;
                                }
                              }, 
                              icon: const Icon(BootstrapIcons.caret_left_fill, color: Colores.blanco,)
                            ),
                            index == renta.imagenes.length - 1 ? Container() : 
                            IconButton(
                              onPressed: (){
                                dynamic aux = renta.imagenes[index];
                                  renta.imagenes[index] = renta.imagenes[index + 1];
                                  renta.imagenes[index + 1] = aux;
                                  cambiaImagen.value = !cambiaImagen.value;
                              }, 
                              icon: const Icon(BootstrapIcons.caret_right_fill, color: Colores.blanco,),
                            )
                          ],
                        ),
                      ],
                    ),
                  )),
        ),
        const SizedBox(
          height: 100,
        ),
      ],
    );
  }
  
  ListView terminosCondiciones(BuildContext context) {
    return ListView(
                  padding: EdgeInsets.all(10),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Términos y copndiciones'),
                        IconButton(
                          onPressed: () async {
                            ///se reutiliza el formulario de terminos y condiciones para obtener el termino y condicion
                            Modal.child(
                              context,
                              child: FormTerminosCondiciones(terminoCondicion: TerminoCondicion(), esObtener: true,)
                            ).then(
                              (value){
                                ///se agrega el nuevo elemento a la lista de terminos y condiciones
                                renta.terminosCondiciones.add(value);
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
                        renta.terminosCondiciones.length,
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
                                      renta.terminosCondiciones[index].titulo,
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
                                              child: FormTerminosCondiciones(terminoCondicion: renta.terminosCondiciones[index],esObtener: true,)
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
                                renta.terminosCondiciones[index].descripcion,
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

  adiciones() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Adiciones'),
            BotonTexto(
              accion: () {
                renta.agregarAdicion(Adicion(valor: 0, imagen: Imagen(), descuento: 0));
                cambiaAdicion.value = !cambiaAdicion.value;
              },
              texto: 'Agregar adición',
              color: Colores.verde,
            ),
          ],
        ),
        const SizedBox(height: 10,),
        Column(
          children: List.generate(
              renta.adiciones.length,
              (index) => Container(
                    decoration: BoxDecoration(
                        color: Colores.blancoOscuro,
                        borderRadius: BorderRadius.circular(5)),
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: ()async{
                                  ///cambiando imagen de la posicion index de la lista de
                                  ///adiciones
                                  PlatformFile? result = await Files.obtenerImagen();
                                  if (result != null) {
                                    if(GetPlatform.isWeb){
                                      renta.adiciones[index].imagen.imagen = result.bytes;
                                    }else{
                                      renta.adiciones[index].imagen.imagen = result.path;
                                    }
                                    renta.adiciones[index].imagen.tipo = Imagen.FILE;
                                    cambiaAdicion.value = !cambiaAdicion.value;
                                  } 
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colores.azul,
                                  backgroundImage: imagenWidget(tipo: renta.adiciones[index].imagen.tipo, imagen: renta.adiciones[index].imagen.imagen),
                                  radius: 40,
                                  onBackgroundImageError: (exception, stackTrace) {},
                                  child: const Icon(BootstrapIcons.camera),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Inputs(
                                  controller: TextInputController().init(
                                      renta.adiciones[index].nombre),
                                  titulo: 'Nombre',
                                  onChanged: (str) {
                                    ///asignacion de nombre de adicion en la posicion index
                                    renta.adiciones[index].nombre = str!;
                                  }),
                            ),
                            const SizedBox(width: 10,),
                            Expanded(
                              child: Inputs(
                                  controller: TextInputController().init(
                                      renta
                                          .adiciones[index].cantidadMaxima),
                                  titulo: 'Cantidad máx stock',
                                  onChanged: (str) {
                                    ///asignacion de cantidadMaxima de adicion en la posicion index
                                    if(str!=null && str.isNum){
                                      renta.adiciones[index].cantidadMaxima = double.parse(str);
                                    }
                                  }),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Inputs(
                                  controller: TextInputController().init(
                                      '${renta.adiciones[index].valor}'),
                                  titulo: 'Valor',
                                  onChanged: (str) {
                                    ///asignacion de valor de adicion en la posicion index
                                    if(str!=null && str.isNum){
                                      renta.adiciones[index].valor = double.parse(str);
                                    }
                                  }),
                            ),
                            const SizedBox(width: 10,),
                            Expanded(
                              flex: 6,
                              child: DropdownButton(
                                  items: List.generate(
                                      101,
                                      (index) => DropdownMenuItem(
                                          value: '$index',
                                          child: Text('$index% descuento'),
                                        )),
                                  value: renta.adiciones[index].descuento.toString(),
                                  onChanged: (value) {
                                    ///asignacion de descuento de adicion en la posicion index
                                    renta.adiciones[index].descuento = int.parse(value.toString());
                                    cambiaAdicion.value=!cambiaAdicion.value;
                                  }),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Boton(
                          accion: () {
                            renta.adiciones.removeAt(index);
                            cambiaAdicion.value = !cambiaAdicion.value;
                          },
                          color: Colores.rojo,
                          child: const Icon(
                            color: Colores.blanco,
                            BootstrapIcons.trash,
                          ),
                        )
                      ],
                    ),
                  )),
        ),
        const SizedBox(
          height: 100,
        ),
      ],
    );
  }
}