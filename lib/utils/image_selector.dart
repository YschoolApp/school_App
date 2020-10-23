import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageSelector {
  Future<File> selectImage(ImageSource imageSource) async {
    PickedFile pickedFile = await ImagePicker().getImage(source: imageSource);
    if (pickedFile != null) return File(pickedFile.path);
    return null;
  }
}
