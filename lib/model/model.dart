import 'package:tflite_v2/tflite_v2.dart';

class ModelClass {
  static bool _isModelLoaded = false;

  static Future<void> loadModel() async {
    try {
      await Tflite.loadModel(
        model: 'assets/model/model.tflite',
        labels: 'assets/model/labels.txt',
      );
      _isModelLoaded = true;
    } catch (e) {
      print('Failed to load model.');
    }
  }

  static Future<String> classifyImage(String imagePath) async {
    await loadModel();
    var output = await Tflite.runModelOnImage(
      path: imagePath,
      imageMean: 127.5,
      imageStd: 127.5,
      numResults: 1,
      threshold: 0,
      asynch: true,
    );
    if (output != null && output.isNotEmpty) {
      final confidence = output[0]['confidence'];
      if (confidence >= 0.5) {
        const label = 'Pneumonia detected';
        return label;
      } else {
        const label = 'Normal';
        return label;
      }
    } else {
      return 'No result';
    }
  }

  static Future<void> closeModel() async {
    await Tflite.close();
  }
}
