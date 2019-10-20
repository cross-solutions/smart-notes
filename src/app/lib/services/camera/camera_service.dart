import 'dart:io';

import 'package:image_picker/image_picker.dart';

abstract class CameraService {
  Future<File> takePhoto();

  Future<File> takePhotoFromFile();
}

class CameraServiceImpl implements CameraService {
  @override
  Future<File> takePhoto() => ImagePicker.pickImage(source: ImageSource.camera);

  @override
  Future<File> takePhotoFromFile() => ImagePicker.pickImage(source: ImageSource.gallery);
}
