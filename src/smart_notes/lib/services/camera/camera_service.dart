import 'dart:io';

import 'package:image_picker/image_picker.dart';

abstract class CameraService {
  Future<File> takePhoto();

  Future<File> takePhotoFromFile();
}

class CameraServiceImpl implements CameraService {
  @override
  Future<File> takePhoto() => ImagePicker()
      .getImage(source: ImageSource.camera)
      .then((value) => File(value.path));

  @override
  Future<File> takePhotoFromFile() => ImagePicker()
      .getImage(source: ImageSource.camera)
      .then((value) => File(value.path));
}
