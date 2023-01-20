import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:topsitesnegocio/app/data/models/sede/termino_condicion.dart';
import 'package:topsitesnegocio/app/ui/pages/sede_detalle/form_terminos_condiciones.dart';

import 'package:topsitesnegocio/app/ui/theme/colores.dart';
import 'package:topsitesnegocio/app/ui/widgets/boton.dart';
import 'package:topsitesnegocio/app/ui/widgets/imagen.dart';
import 'package:topsitesnegocio/app/ui/widgets/input.dart';
import 'package:topsitesnegocio/app/ui/widgets/input_fecha.dart';
import 'package:topsitesnegocio/app/ui/widgets/input_hora.dart';
import 'package:topsitesnegocio/app/ui/widgets/modal.dart';
import 'package:topsitesnegocio/app/ui/widgets/switch.dart';

import '../../../data/models/sede/adicion.dart';
import '../../../data/models/sede/combo_plan.dart';
import '../../../data/models/sede/fecha_hora.dart';
import '../../../data/models/sede/imagenes_sede.dart';
import '../../theme/fonts.dart';
import '../../widgets/file_picker.dart';
import '../../widgets/snackbar.dart';

class FormComboPlan extends StatelessWidget {
  final ComboPlan comboPlan;

  const FormComboPlan({super.key, required this.comboPlan});

  @override
  Widget build(BuildContext context) {
    return Responsive(comboPlan: comboPlan);
  }
}

class Responsive extends GetResponsiveView {

  final cambiaImagenPrincipal= false.obs;
  
  TextInputController txtNombre = TextInputController();
  TextInputController txtDetalle = TextInputController();
  TextInputController txtTiempoPermitidoCancelar = TextInputController();

  final tipoPlan = '0'.obs;
  
  final cambia = false.obs;
  final ComboPlan comboPlan;

  Responsive({
    super.key,
    required this.comboPlan,
  });

  @override
  Widget builder() {
    return Builder(
      builder: (BuildContext context) => DefaultTabController(
        length: 6,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Combo / plan'),
            backgroundColor: Colores.negro,
            automaticallyImplyLeading: false,
            bottom: const TabBar(
              isScrollable: true,
              tabs: [
                ///estos son los tabs que se muestran en el formulario de combo/plan
                Tab(
                  text: 'Información General',
                ),
                Tab(
                  text: 'Imagenes',
                ),
                Tab(
                  text: 'Fecha y hora',
                ),
                Tab(
                  text: 'Detalles',
                ),
                Tab(
                  text: 'Adiciones',
                ),
                Tab(
                  text: 'Terminos y condiciones',
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {
                  /// este metodo se ejecuta si presiona en la x que se encuentra en la parte superior derecha del form
                  Modal.porDefecto(context,
                    child: const Text('¿Seguro que quieres cerrar?'),
                    onAceptar: () {
                      Get.back();
                      Get.back();
                    }
                  );
                },
                icon: const Icon(BootstrapIcons.x)
              )
            ],
          ),
          floatingActionButton: Wrap(
            direction: Axis.horizontal,
            children: [
              Boton(
                accion: () => Get.back(),
                color: Colores.gris,
                child: const Text('Cancelar'),
              ),
              const SizedBox(width: 10,),
              Boton(
                accion: (){
                  ///aqui se realiza el cambio o se agrega un nuevo combo plan
                  //se deben realizar las validaciones pertinentes al combo plan
                  if(comboPlan.id==null){
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
          body: Obx(
            (){
              cambia.value;
              return TabBarView(
                children: [
                  informacionGeneral(),
                  imagenes(),
                  fechaHora(),
                  detalles(),
                  adiciones(),
                  terminosCondiciones(context),
                ],
              );
            }
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
                                comboPlan.terminosCondiciones.add(value);
                                cambia.value = !cambia.value;
                              }
                            );
                          },
                          icon: Icon(BootstrapIcons.plus),
                        ),
                      ],
                    ),
                    Column(
                      children: List.generate(
                        comboPlan.terminosCondiciones.length,
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
                                      comboPlan.terminosCondiciones[index].titulo,
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
                                              child: FormTerminosCondiciones(terminoCondicion: comboPlan.terminosCondiciones[index],esObtener: true,)
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
                                comboPlan.terminosCondiciones[index].descripcion,
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

  ///item 1 del tab
  ///aqui se realiza los cambios de la informacion general de el combo plan
  informacionGeneral() {
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
                  comboPlan.imagenPrincipal.imagen = result.bytes;
                }else{
                  comboPlan.imagenPrincipal.imagen = result.path;
                }
                comboPlan.imagenPrincipal.tipo = Imagen.FILE;
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
                      image: imagenWidget(tipo: comboPlan.imagenPrincipal.tipo, imagen: comboPlan.imagenPrincipal.imagen),
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
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Inputs(
                controller: txtNombre,
                titulo: 'Nombre',
                onChanged: (str) {
                  comboPlan.nombre = str!;
                },
              ),
              Inputs(
                controller: txtDetalle,
                maxLines: 3,
                titulo: 'Detalle',
                onChanged: (str) {
                  comboPlan.descripcion = str!;
                },
              ),
              Inputs(
                controller: txtTiempoPermitidoCancelar,
                titulo: 'Tiempo permitido para cancelar en horas',
                tipoTeclado: TextInputType.number,
              ),
              /**
               * este es el combo de tipo plan
               * para llenar este combo debe realizar una peticion al backend para que retorne la lista
               * de todos los tipos de planes que hay
               */
              Row(
                children: [
                  Obx(
                    ()=>Expanded(
                      child: DropdownButton(
                        ///la lista de items debe ir de la siguente manera
                        ///en Text debe ir el nombre del tipo plan
                        ///y en value el id del tipoplan
                        items: [DropdownMenuItem(child: Text('Tipo plan'), value: '0',)],
                        value: tipoPlan.value,
                        onChanged: (value) {
                          tipoPlan.value = value.toString();
                        }
                      )        
                    )
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Obx(
                      (){ 
                        cambia.value;
                        return SwitchPersonalizado(
                          estado: comboPlan.estado,
                          onChanged: (value){ comboPlan.estado = value; cambia.value = !cambia.value;},
                          texto: 'Estado',
                        );
                      }
                    )
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Obx((){
                    cambia.value;
                    return Text(comboPlan.estado ? 'Publicado' : 'Inactivo');
                  })
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 100,
        ),
      ],
    );
  }
 
  ///item 2 del tab
  ///imagenes
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
                  comboPlan.agregarImagen(imagen);
                  cambia.value = !cambia.value;
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
              comboPlan.imagenes.length,
              (index) => Container(
                    width: 140,
                    height: 140,
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colores.gris,
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            image: imagenWidget(imagen:comboPlan.imagenes[index].imagen, tipo:comboPlan.imagenes[index].tipo),
                            fit: BoxFit.cover)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Boton(
                          radio: 100,
                          accion: () {
                            /// metodo que elimina foto adicional de la posicion index
                            comboPlan.imagenes.removeAt(index);
                            cambia.value = !cambia.value;
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
                                  dynamic aux = comboPlan.imagenes[index];
                                  comboPlan.imagenes[index] =comboPlan.imagenes[index - 1];
                                 comboPlan.imagenes[index - 1] = aux;
                                  cambia.value = !cambia.value;
                                }
                              }, 
                              icon: const Icon(BootstrapIcons.caret_left_fill, color: Colores.blanco,)
                            ),
                            index == comboPlan.imagenes.length - 1 ? Container() : 
                            IconButton(
                              onPressed: (){
                                dynamic aux = comboPlan.imagenes[index];
                                  comboPlan.imagenes[index] = comboPlan.imagenes[index + 1];
                                  comboPlan.imagenes[index + 1] = aux;
                                  cambia.value = !cambia.value;
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


  ///item 3 del tab
  ///horarios
  fechaHora() {
    return ListView(
      padding: EdgeInsets.all(20),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Fecha y hora'),
            BotonTexto(
              accion: () {
                ///aqui se agrega un elemento nuevo a la lista de horarios
                comboPlan.agregarFechaHora(FechaHora.construir());
                cambia.value = !cambia.value;
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
            comboPlan.fechaHora.length,
            (index) => itemFechaHora(comboPlan.fechaHora[index], index))
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
                            comboPlan.fechaHora.removeAt(index);
                            cambia.value = !cambia.value;
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
                      comboPlan.fechaHora[index].fechaInicio = value;
                      cambia.value = !cambia.value;
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
                      comboPlan.fechaHora[index].horaInicio = value;
                      cambia.value = !cambia.value;
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
                      comboPlan.fechaHora[index].fechaFin = value;
                      cambia.value = !cambia.value;
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
                      comboPlan.fechaHora[index].horaFin = value;
                      cambia.value = !cambia.value;
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
                      comboPlan.fechaHora[index].valor = double.parse(str);
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
                    cambia.value = !cambia.value;
                  }),
            )
          ],
        ),        
      ]),
    );
  }
  
  ///item 4 del tab
  ///detalles
  detalles() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Detalles'),
            BotonTexto(
              accion: () {
                ///aqui se agrega un nuevo elemento a los detalles de comboplan
                comboPlan.agregarDetalle(DetalleComboPlan());
                cambia.value = !cambia.value;
              },
              texto: 'Agregar detalle',
              color: Colores.verde,
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Column(
          children: List.generate(
              comboPlan.detalles.length,
              (index) => Row(
                children: [
                Expanded(
                  child: Inputs(
                    controller: TextInputController()
                        .init(comboPlan.detalles[index].nombre),
                    titulo: 'Nombre',
                    onChanged: (str) {
                      ///cambia el nombre del detalle de la posicion index
                      ///al presionar una tecla
                      comboPlan.detalles[index].nombre = str!;
                    }
                  )
                ),
                const SizedBox(width: 10,),
                Builder(
                  builder: (context){
                    return Boton(
                      accion: () {
                        ///se elimina el detale de la posicion index de la lista de detalles
                        Modal.porDefecto(
                          context,
                          child: Text('¿Quieres eliminar este detalle?'),
                          onAceptar: (){
                            comboPlan.detalles.removeAt(index);
                            cambia.value = !cambia.value;
                          }
                        );
                      },
                      color: Colores.rojo,
                      child: const Icon(
                        BootstrapIcons.trash,
                        color: Colores.blanco,
                      ),
                    );
                  }
                )
              ],
            )
          ),
        ),
        const SizedBox(height: 100,),
      ],
    );
  }

  ///item 5 del tab
  ///adiciones
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
                comboPlan.agregarAdicion(Adicion(valor: 0, imagen: Imagen(), descuento: 0));
                cambia.value = !cambia.value;
              },
              texto: 'Agregar adición',
              color: Colores.verde,
            ),
          ],
        ),
        const SizedBox(height: 10,),
        Column(
          children: List.generate(
              comboPlan.adiciones.length,
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
                                      comboPlan.adiciones[index].imagen.imagen = result.bytes;
                                    }else{
                                      comboPlan.adiciones[index].imagen.imagen = result.path;
                                    }
                                    comboPlan.adiciones[index].imagen.tipo = Imagen.FILE;
                                    cambia.value = !cambia.value;
                                  } 
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colores.azul,
                                  backgroundImage: imagenWidget(tipo: comboPlan.adiciones[index].imagen.tipo, imagen: comboPlan.adiciones[index].imagen.imagen),
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
                                      comboPlan.adiciones[index].nombre),
                                  titulo: 'Nombre',
                                  onChanged: (str) {
                                    ///asignacion de nombre de adicion en la posicion index
                                    comboPlan.adiciones[index].nombre = str!;
                                  }),
                            ),
                            const SizedBox(width: 10,),
                            Expanded(
                              child: Inputs(
                                  controller: TextInputController().init(
                                      comboPlan
                                          .adiciones[index].cantidadMaxima),
                                  titulo: 'Cantidad máx stock',
                                  onChanged: (str) {
                                    ///asignacion de cantidadMaxima de adicion en la posicion index
                                    if(str!=null && str.isNum){
                                      comboPlan.adiciones[index].cantidadMaxima = double.parse(str);
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
                                      '${comboPlan.adiciones[index].valor}'),
                                  titulo: 'Valor',
                                  onChanged: (str) {
                                    ///asignacion de valor de adicion en la posicion index
                                    if(str!=null && str.isNum){
                                      comboPlan.adiciones[index].valor = double.parse(str);
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
                                  value: comboPlan.adiciones[index].descuento.toString(),
                                  onChanged: (value) {
                                    ///asignacion de descuento de adicion en la posicion index
                                    comboPlan.adiciones[index].descuento = int.parse(value.toString());
                                    cambia.value=!cambia.value;
                                  }),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Boton(
                          accion: () {
                            comboPlan.adiciones.removeAt(index);
                            cambia.value = !cambia.value;
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
