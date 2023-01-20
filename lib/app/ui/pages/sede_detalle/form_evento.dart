import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:topsitesnegocio/app/data/models/sede/evento.dart';
import 'package:topsitesnegocio/app/ui/pages/sede_detalle/form_valores_ubicacion.dart';
import 'package:topsitesnegocio/app/ui/widgets/input.dart';
import 'package:topsitesnegocio/app/ui/widgets/input_fecha.dart';
import 'package:topsitesnegocio/app/ui/widgets/input_hora.dart';
import 'package:topsitesnegocio/app/ui/widgets/switch.dart';

import '../../../data/models/sede/adicion.dart';
import '../../../data/models/sede/imagenes_sede.dart';
import '../../../data/models/sede/termino_condicion.dart';
import '../../theme/colores.dart';
import '../../widgets/boton.dart';
import '../../widgets/file_picker.dart';
import '../../widgets/imagen.dart';
import '../../widgets/modal.dart';
import 'form_terminos_condiciones.dart';

class FormEvento extends GetView {
  
  final Evento evento;

  const FormEvento({super.key, required this.evento});

  @override
  Widget build(BuildContext context) {
    return Responsive(evento: evento,);
  }
}

class Responsive extends GetResponsiveView {

  final Evento evento;

  final cambiaInformacion = false.obs;
  final cambiaImagenesnes = false.obs;
  final cambiaAdiciones = false.obs;
  final cambiaImagenPrincipal = false.obs;
  final cambiaUbicaciones = false.obs;
  final cambiaTerminoCondicion = false.obs;

  TextInputController txtNombre = TextInputController();
  TextInputController txtAforoPermitido = TextInputController();
  TextInputController txtCantidadMaxPersona = TextInputController();
  TextInputController txtDescripcion = TextInputController();
  TextInputController txtDireccion = TextInputController();

  Responsive({required this.evento});

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
                  ///aqui se realiza el cambio o se agrega un nuevo evento
                  ///se deben realizar las validaciones pertinentes
                  if(evento.id==null){
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
                Tab(text: 'Ubicaciones',),
                Tab(text: 'Imagenes',),
                Tab(text: 'Adiciones',),
                Tab(text: 'Terminos y condiciones',),
              ],
            ),
            title: const Text('Evento'),
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
              informacionGeneral(),
              Obx((){
                cambiaUbicaciones.value;
                return ubicaciones();
              }),
              Obx((){
                cambiaImagenesnes.value;
                return imagenes();
              }),
              Obx(() {
                cambiaAdiciones.value;
                return adiciones();
              },),
              Obx(() {
                cambiaTerminoCondicion.value;
                return terminosCondiciones(context);
              },)
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
                    evento.terminosCondiciones.add(value);
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
            evento.terminosCondiciones.length,
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
                          evento.terminosCondiciones[index].titulo,
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
                                  child: FormTerminosCondiciones(terminoCondicion: evento.terminosCondiciones[index],esObtener: true,)
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
                    evento.terminosCondiciones[index].descripcion,
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
  ///item 1 de los tabs
  ListView informacionGeneral() {
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
                  evento.imagenPrincipal.imagen = result.bytes;
                }else{
                  evento.imagenPrincipal.imagen = result.path;
                }
                evento.imagenPrincipal.tipo = Imagen.FILE;
                cambiaImagenPrincipal.value = !cambiaImagenPrincipal.value;
              } 
            },
            child: Obx(
              (){
                cambiaImagenPrincipal.value;
                return Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colores.azul,
                    image: DecorationImage(
                      image: imagenWidget(tipo: evento.imagenPrincipal.tipo, imagen: evento.imagenPrincipal.imagen),
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
        Obx(
          (){
            cambiaInformacion.value;
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      ///se debe realizar una peticion al backed para llenar este combo
                      Expanded(child: DropdownButton(items: [DropdownMenuItem(child: Text('Tipo evento'))], onChanged: (value){})),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Inputs(controller: txtNombre, titulo: 'Nombre',),
                  Inputs(controller: txtDescripcion, titulo: 'Descripción', maxLines: 3),
                  Inputs(controller: txtAforoPermitido, titulo: 'Aforo permitido',),
                  Inputs(controller: txtCantidadMaxPersona, titulo: 'Cantidad máx por persona',),
                  SwitchPersonalizado(estado: evento.estado, onChanged: (value){
                    evento.estado = !evento.estado;
                    cambiaInformacion.value = !cambiaInformacion.value;
                  }, texto: evento.estado ? 'Publicado' : 'Inactivo',),
                    const SizedBox(height: 10,),
                    const Text('Detalle del evento'),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        ///se debe realizar una paeticion al backend para llenar estos combos
                        Expanded(child: DropdownButton(items: [DropdownMenuItem(child: Text('Departamento'))], onChanged: (value){})),
                        const SizedBox(width: 10,),
                        Expanded(child: DropdownButton(items: [DropdownMenuItem(child: Text('Ciudad'))], onChanged: (value){})),
                      ],
                    ),
                    Inputs(controller: txtDireccion, titulo: 'Dirección',),
                    const Text('Horarios'),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        Expanded(child: InputsFecha(getFecha: (value){
                          ///seleccion de fecha de inicio
                          if(value!=null){
                            evento.fechaInicio = value;
                            cambiaInformacion.value = !cambiaInformacion.value;
                          }
                        }, 
                        fechaInicial: evento.fechaInicio, 
                        titulo: 'Fecha Inicio',
                        fecha: evento.strFechaInicio,)),
                        const SizedBox(width: 10,),
                        Expanded(child: InputsHora(getHora: (value){
                          //seleccion de hora inicio
                          if(value!=null){
                            evento.horaInicio = value;
                            cambiaInformacion.value = !cambiaInformacion.value;
                          }
                        }, 
                        horaInicial: evento.horaInicio,
                        titulo: 'Hora Inicio',
                        hora: evento.strHoraInicio,))
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Expanded(child: InputsFecha(getFecha: (value){
                          ///seleccion de fecha fin
                          if(value!=null){
                            evento.fechaFin = value;
                            cambiaInformacion.value = !cambiaInformacion.value;
                          }
                        }, 
                        fechaInicial: evento.fechaFin, 
                        titulo: 'Fecha Fin',
                        fecha: evento.strFechaFin,)),
                        const SizedBox(width: 10,),
                        Expanded(child: InputsHora(getHora: (value){
                          ///seleccion de hora fin
                          if(value!=null){
                            evento.horaFin = value;
                            cambiaInformacion.value = !cambiaInformacion.value;
                          }
                        }, 
                        horaInicial: evento.horaFin,
                        titulo: 'Hora Fin',
                        hora: evento.strHoraFin,))
                      ],
                    )

                ],
              ),
            );
          }
        ),
        const SizedBox(height: 100,)
      ],
    );
  }

  ///item 2 de tabs
  ListView ubicaciones() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Ubicaciones'),
            BotonTexto(
              accion: (){
                ///se agrega una nueva ubicacion
                evento.agregarUbicacion(UbicacionEvento());
                cambiaUbicaciones.value = !cambiaUbicaciones.value;
              },
              texto: 'Agregar ubicación',
              color: Colores.verde,
            ),
          ],
        ),
        const SizedBox(height: 10,),
        ///se recorre el array de ubicaciones y se muestra en pantalla
        for(int i = 0; i < evento.ubicaciones.length; i++)
        Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Inputs(
                    controller: TextInputController().init(evento.ubicaciones[i].nombre),
                    titulo: 'Nombre ubicación',
                    onChanged: (str){
                      ///se modifica el nombre de la ubicacion en la posicion i
                      if(str!=null){
                        evento.ubicaciones[i].nombre = str;
                      }
                    }
                  )
                ),
                const SizedBox(width: 10,),
                Expanded(
                  flex: 3,
                  child: Inputs(
                    controller: TextInputController().init(evento.ubicaciones[i].cantidad), 
                    titulo: 'Cantidad',
                    onChanged: (str){
                      ///se modifica la cantidad de la ubicacion en la posicion i
                      if(str!=null && str.isNum){
                        evento.ubicaciones[i].cantidad = int.parse(str);
                      }
                    },
                  )
                ),
                const SizedBox(width: 10,),
                Builder(builder: (context){
                  return Boton(accion: (){
                    Modal.child(
                      context,
                      child: FormValoresUbicacionPage()
                    );
                  }, child: const Icon(BootstrapIcons.plus, color: Colores.blanco,),
                );
                }),
                const SizedBox(width: 10,),
                Builder(
                  builder: (context) {
                    return Boton(
                      accion: (){
                        Modal.porDefecto(
                          context,
                          child:const Text('¿Quieres eliminar esta ubicación?'),
                          onAceptar: (){
                            ///se elimina la ubicacion en la posicion i
                            evento.ubicaciones.removeAt(i);
                            cambiaUbicaciones.value = !cambiaUbicaciones.value;
                            Get.back();
                          }
                        );
                    }, 
                    child: const Icon(BootstrapIcons.trash, color: Colores.blanco,)
                    );
                  }
                )
              ],
            )
          ],
        ),
      ],
    );
  }

  
  ///item 3 de los tabs
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
                  evento.agregarImagen(imagen);
                  cambiaImagenesnes.value = !cambiaImagenesnes.value;
                } 
              },
              icon: Icon(BootstrapIcons.plus),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Wrap(
          children: List.generate(
              evento.imagenes.length,
              (index) => Container(
                    width: 140,
                    height: 140,
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colores.gris,
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            image: imagenWidget(imagen:evento.imagenes[index].imagen, tipo:evento.imagenes[index].tipo),
                            fit: BoxFit.cover)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Boton(
                          radio: 100,
                          accion: () {
                            /// metodo que elimina foto adicional de la posicion index
                            evento.imagenes.removeAt(index);
                            cambiaImagenesnes.value = !cambiaImagenesnes.value;
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
                                  dynamic aux = evento.imagenes[index];
                                  evento.imagenes[index] =evento.imagenes[index - 1];
                                 evento.imagenes[index - 1] = aux;
                                  cambiaImagenesnes.value = !cambiaImagenesnes.value;
                                }
                              }, 
                              icon: const Icon(BootstrapIcons.caret_left_fill, color: Colores.blanco,)
                            ),
                            index == evento.imagenes.length - 1 ? Container() : 
                            IconButton(
                              onPressed: (){
                                dynamic aux = evento.imagenes[index];
                                  evento.imagenes[index] = evento.imagenes[index + 1];
                                  evento.imagenes[index + 1] = aux;
                                  cambiaImagenesnes.value = !cambiaImagenesnes.value;
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

  ///item 4 de los tabs
  adiciones() {
    return ListView(
      padding: EdgeInsets.all(20),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Adiciones'),
            BotonTexto(
              accion: () {
                evento.agregarAdicion(Adicion(valor: 0, imagen: Imagen(), descuento: 0));
                cambiaAdiciones.value = !cambiaAdiciones.value;
              },
              texto: 'Agregar adición',
              color: Colores.verde,
            ),
          ],
        ),
        const SizedBox(height: 10,),
        Column(
          children: List.generate(
              evento.adiciones.length,
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
                                      evento.adiciones[index].imagen.imagen = result.bytes;
                                    }else{
                                      evento.adiciones[index].imagen.imagen = result.path;
                                    }
                                    evento.adiciones[index].imagen.tipo = Imagen.FILE;
                                    cambiaAdiciones.value = !cambiaAdiciones.value;
                                  } 
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colores.azul,
                                  backgroundImage: imagenWidget(tipo: evento.adiciones[index].imagen.tipo, imagen: evento.adiciones[index].imagen.imagen),
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
                                      evento.adiciones[index].nombre),
                                  titulo: 'Nombre',
                                  onChanged: (str) {
                                    ///asignacion de nombre de adicion en la posicion index
                                    evento.adiciones[index].nombre = str!;
                                  }),
                            ),
                            const SizedBox(width: 10,),
                            Expanded(
                              child: Inputs(
                                  controller: TextInputController().init(
                                      evento
                                          .adiciones[index].cantidadMaxima),
                                  titulo: 'Cantidad máx stock',
                                  onChanged: (str) {
                                    ///asignacion de cantidadMaxima de adicion en la posicion index
                                    if(str!=null && str.isNum){
                                      evento.adiciones[index].cantidadMaxima = double.parse(str);
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
                                      '${evento.adiciones[index].valor}'),
                                  titulo: 'Valor',
                                  onChanged: (str) {
                                    ///asignacion de valor de adicion en la posicion index
                                    if(str!=null && str.isNum){
                                      evento.adiciones[index].valor = double.parse(str);
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
                                          child: Text('$index% descuento'),
                                          value: '$index')),
                                  value: evento.adiciones[index].descuento.toString(),
                                  onChanged: (value) {
                                    ///asignacion de descuento de adicion en la posicion index
                                    evento.adiciones[index].descuento = int.parse(value.toString());
                                    cambiaAdiciones.value=!cambiaAdiciones.value;
                                  }),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Boton(
                          accion: () {
                            evento.adiciones.removeAt(index);
                            cambiaAdiciones.value = !cambiaAdiciones.value;
                          },
                          child: Icon(
                            BootstrapIcons.trash,
                            color: Colores.blanco,
                          ),
                          color: Colores.rojo,
                        )
                      ],
                    ),
                  )),
        ),
        SizedBox(
          height: 100,
        ),
      ],
    );
  }
 

  
}