import 'package:get/get.dart';
import 'package:topsitesnegocio/app/data/models/sede/sede.dart';
import 'package:topsitesnegocio/app/data/repository/sede_repository.dart';

import '../../../data/repository/token_repository.dart';

class SedeListController extends GetxController {

  SedeRepository sedeRepository = SedeRepository();
  final sedes = <Sede>[].obs;
  String? token = '';

  @override
  void onInit() async{
    token = await TokenRepository().getToken();
    await cargarLista();
    super.onInit();  
  }

  Future<void> cargarLista()async{
    try {
      sedes.value = [];
      sedes.value = await sedeRepository.getAll(token!);
    } catch (e) {
      sedes.value = [];
    }
  }

  agregarNuevaSede(Sede sede){
    sedeRepository.add(token, sede);
    cargarLista();
  }

}