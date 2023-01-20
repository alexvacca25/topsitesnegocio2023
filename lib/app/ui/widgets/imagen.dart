import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/sede/imagenes_sede.dart';

imagenWidget({required String tipo, required dynamic imagen}) {
  return tipo == Imagen.URL ? NetworkImage(imagen) : GetPlatform.isWeb ? MemoryImage(imagen) : FileImage(File(imagen));
}