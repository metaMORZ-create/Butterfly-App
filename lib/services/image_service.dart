import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageService {
  static final _picker = ImagePicker();

  /// Öffnet die Kamera und nimmt ein Foto auf.
  static Future<File?> takePhoto() async {
    try {
      final XFile? file = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1600,
      );
      if (file == null) return null;
      return File(file.path);
    } catch (e) {
      print("Camera Error: $e");
      return null;
    }
  }
}
