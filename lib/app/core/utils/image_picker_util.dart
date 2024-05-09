import 'dart:developer';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerUtil {
  ImagePickerUtil._();

  /// Pick image from gallery or camera
  static Future<File?> pick(ImageSource source) async {
    try {
      final selectedFile = await ImagePicker().pickImage(source: source);

      if (selectedFile == null) return null;

      final File file = File(selectedFile.path);
      return file;
    } catch (e) {
      log(
        '[ImagePicker] $e',
      );
    }
    return null;
  }
}
