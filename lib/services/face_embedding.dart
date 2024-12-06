import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';
import 'dart:ui' as ui; // Pour utiliser ui.Image
import 'package:path_provider/path_provider.dart';

class FaceEmbedding {
  late Interpreter _interpreter;

  Future<void> loadModel() async {
    _interpreter = await Interpreter.fromAsset('assets/mobilefacenet.tflite');
  }

  List<List<List<List<double>>>> preprocessImage(File imageFile) {
    // Charger et redimensionner l'image
    img.Image? image = img.decodeImage(imageFile.readAsBytesSync());
    if (image == null) {
      throw Exception("Erreur : Impossible de charger l'image !");
    }
    img.Image resizedImage = img.copyResize(image, width: 112, height: 112);

    // Obtenir les pixels et les normaliser
    List<double> normalizedData = resizedImage
        .getBytes(order: img.ChannelOrder.rgb)
        .map((e) => e / 255.0)
        .toList();

    // Reformater en tableau 4D : [batch_size, height, width, channels]
    return [
      List.generate(
        112,
        (y) => List.generate(
          112,
          (x) => [
            normalizedData[(y * 112 + x) * 3], // Canal R
            normalizedData[(y * 112 + x) * 3 + 1], // Canal G
            normalizedData[(y * 112 + x) * 3 + 2] // Canal B
          ],
        ),
      )
    ];
  }

  List<double> generateEmbedding(File faceImage) {
    // Préparer les entrées et sorties
    final input = preprocessImage(faceImage);

    // Initialiser la sortie (par exemple : un vecteur de 128 dimensions)
    List<List<double>> output = List.generate(1, (_) => List.filled(192, 0.0));

    // Exécuter l'inférence
    _interpreter.run(input, output);

    // Retourner les embeddings
    return output[0];
  }

  Future<File> imageToFile(ui.Image image, String fileName) async {
    // Étape 1 : Extraire les données de pixels de l'image
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData == null) {
      throw Exception("Impossible d'extraire les données de l'image.");
    }

    // Étape 2 : Convertir ByteData en Uint8List
    Uint8List pngBytes = byteData.buffer.asUint8List();

    // Étape 3 : Obtenir le chemin pour sauvegarder le fichier
    Directory tempDir =
        await getTemporaryDirectory(); // Utilisation d'un répertoire temporaire
    String filePath = '${tempDir.path}/$fileName.png';

    // Étape 4 : Écrire les données dans un fichier
    File file = File(filePath);
    await file.writeAsBytes(pngBytes);

    return file; // Retourner l'objet File
  }
}
