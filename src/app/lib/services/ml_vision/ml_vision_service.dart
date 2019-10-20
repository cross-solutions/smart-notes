import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';

abstract class MLVisionService {
  Future<MLVisionResult> extractTextFromImageFile(File imageFile);
}

class MLVisionServiceImpl implements MLVisionService {
  @override
  Future<MLVisionResult> extractTextFromImageFile(File imageFile) async {
    if (imageFile != null) {
      final visionImage = FirebaseVisionImage.fromFile(imageFile);
      return _internalProcessImage(visionImage);
    }

    return MLVisionResult(null, MLVisionResultStatus.noImage);
  }

  Future<MLVisionResult> _internalProcessImage(FirebaseVisionImage image) async {
    final recognizer = FirebaseVision.instance.textRecognizer();
    final result = await recognizer.processImage(image);
    recognizer.close();

    return MLVisionResult(result.text, MLVisionResultStatus.completed);
  }
}

class MLVisionResult {
  MLVisionResult(this.text, this.status);

  final String text;
  final MLVisionResultStatus status;
}

enum MLVisionResultStatus {
  completed,
  noImage,
}
