
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/negocio_registro_controller.dart';
import '../../theme/colores.dart';
import '../../widgets/boton.dart';
import '../../widgets/input.dart';
import '../../widgets/titulo.dart';

class FormularioRegistroNegocio extends GetResponsiveView {

  RegistroNegocioController negocioController = Get.put(RegistroNegocioController());

  @override
  Widget builder() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: screen.isPhone ? 0 : 20),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5)
      ),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(width: 1))
            ),
            child: AppBar(
              title: const TituloWidget(fontSize: 20),
              backgroundColor: Colores.crema,
              automaticallyImplyLeading: false,
              iconTheme: IconThemeData(
                color: Colores.negro
              ),
              elevation: 0,
              actions: [
                IconButton(onPressed: ()=>Get.back(), icon: Icon(BootstrapIcons.x))
              ],
            ),
          ),
        ),
        backgroundColor: Colores.crema,
        body: ListView(
          padding: EdgeInsets.all(10),
          children: [
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text('Envíanos un mensaje'),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text('Escríbenos y uno de nuestros ejecutivos te estará contactando para asesorarte más acerca de nuestros servicios si te interesa sumar tu comercio a nuestra red de beneficios.'),
            ),
            Row(
              children: <Widget>[
                Expanded(child: DropdownButton(isExpanded: true,items: [DropdownMenuItem(child: Text('Tipo de persona'))], onChanged: (value){})),
                const SizedBox(width: 10,),
                Expanded(
                  child: Inputs(
                    icon: BootstrapIcons.number_123,
                    titulo: 'Identificación',
                    controller: negocioController.txtNumeroIdentificacion,
                    tipoTeclado: TextInputType.number,
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Inputs(
                    icon: BootstrapIcons.type,
                    titulo: 'Nombre del negocio',
                    controller: negocioController.txtNombreNegocio,
                  ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: Inputs(
                    icon: BootstrapIcons.type,
                    titulo: 'Nombre de contacto',
                    controller: negocioController.txtNombreContacto,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(child: DropdownButton(isExpanded: true,items: List.generate(negocioController.paises.value.length, (index) => DropdownMenuItem(child: Text(negocioController.paises.value[index].nombre, maxLines: 1, overflow: TextOverflow.fade,),value: negocioController.paises.value[index].id,)), value: negocioController.paises.value[0].id,onChanged: (value){})),
                const SizedBox(width: 10,),
                Expanded(child: DropdownButton(isExpanded: true,items: List.generate(negocioController.departamentos.value.length, (index) => DropdownMenuItem(child: Text(negocioController.departamentos.value[index].nombre, maxLines: 1, overflow: TextOverflow.fade,),value: negocioController.departamentos.value[index].id,)),value: negocioController.departamentos.value[0].id,onChanged: (value){})),
                const SizedBox(width: 10,),
                Expanded(child: DropdownButton(isExpanded: true,items: List.generate(negocioController.ciudades.value.length, (index) => DropdownMenuItem(child: Text(negocioController.ciudades.value[index].nombre, maxLines: 1, overflow: TextOverflow.fade,),value: negocioController.ciudades.value[index].id,)),value: negocioController.ciudades.value[0].id, onChanged: (value){})),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Inputs(
                    icon: BootstrapIcons.pin_map,
                    titulo: 'Dirección',
                    controller: negocioController.txtDireccion,
                  ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: Inputs(
                    icon: BootstrapIcons.telephone,
                    titulo: 'Teléfono',
                    controller: negocioController.txtNumeroContacto,
                    tipoTeclado: TextInputType.number,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Inputs(
                    icon: BootstrapIcons.envelope,
                    titulo: 'Correo',
                    controller: negocioController.txtCorreo,
                  ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: Inputs(
                    icon: BootstrapIcons.envelope,
                    titulo: 'Confirmacoión de correo',
                    controller: negocioController.txtConfirmacionCorreo,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(child: DropdownButton(isExpanded: true,items: List.generate(negocioController.promedioVentaMes.value.length, (index) => DropdownMenuItem(child: Text(negocioController.promedioVentaMes.value[index].promedioVenta!,overflow: TextOverflow.fade, maxLines: 1,),value: negocioController.promedioVentaMes.value[index].id!,)), value: negocioController.promedioVentaMes.value[0].id!,onChanged: (value){})),
                const SizedBox(width: 10,),
                Expanded(
                  child: Inputs(
                    icon: BootstrapIcons.instagram,
                    titulo: 'Instagram',
                    controller: negocioController.txtInstagram,
                  ),
                )
              ],
            ),
            Inputs(
              controller: negocioController.txtMensaje,
              titulo: 'Mensaje',
              maxLines: 3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: BotonTexto(
                    texto: 'Conceptos basicos de TopSites',
                    accion: () {},
                  ),
                ),
                SizedBox(width: 10,),
                Boton(
                  accion: () => negocioController.registrarNegocio(),
                  color: Colores.verde,
                  colorHover: Colores.verdeOscuro,
                  child: const Text(
                    'Continuar',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
