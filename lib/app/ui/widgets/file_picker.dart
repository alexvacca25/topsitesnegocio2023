import 'package:file_picker/file_picker.dart';

/**
 * se utiliza el paquete file_picker
 * y se usa para retornar una imagen
 */
class Files {
  static Future<PlatformFile?> obtenerImagen()async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['jpg', 'jpeg', 'png']);
    if(result==null){
      return null;
    }
    return result.files.first;
  }
}