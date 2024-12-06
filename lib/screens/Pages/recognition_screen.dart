import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gestion_etudiant/services/face_comparator.dart';
import 'package:gestion_etudiant/provider/embedding_face.dart';
import 'package:gestion_etudiant/services/face_embedding.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;
// import 'package:image/image.dart' as img;

class RecognitionScreen extends StatefulWidget {
  const RecognitionScreen({Key? key}) : super(key: key);

  @override
  State<RecognitionScreen> createState() => _HomePageState();
}

class _HomePageState extends State<RecognitionScreen> {
  late ImagePicker imagePicker;
  File? _image;
  late FaceDetector faceDetector;
  late FaceEmbedding faceEmbedding;

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
    faceEmbedding = FaceEmbedding();
    faceEmbedding.loadModel();
    FaceDetectorOptions options = FaceDetectorOptions();

    faceDetector = FaceDetector(options: options);
  }

  _imgFromCamera() async {
    XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        doFaceDetection(pickedFile);
      });
    }
  }

  _imgFromGallery() async {
    XFile? pickedFile =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        doFaceDetection(pickedFile);
      });
    }
  }

  Future<void> doFaceDetection(XFile image) async {
    final InputImage inputImage = InputImage.fromFilePath(image.path);
    final List<Face> faces = await faceDetector.processImage(inputImage);

    debugPrint("Voici le nombre de face ${faces.length}");

    if (faces.isNotEmpty) {
      final Rect boundingBox = faces[0].boundingBox;

      debugPrint("Voici boudingBox $boundingBox");
      try {
        // Vérifier si l'image a un filePath
        if (inputImage.filePath == null) {
          throw Exception("L'image ne contient pas de chemin valide");
        }

        // Charger l'image en tant que Uint8List
        Uint8List imageBytes = await File(inputImage.filePath!).readAsBytes();

        // Décoder l'image
        ui.decodeImageFromList(imageBytes, (ui.Image fullImage) async {
          // Dessiner une sous-image avec le boundingBox
          final recorder = ui.PictureRecorder();
          final canvas = ui.Canvas(recorder);

          canvas.drawImageRect(
            fullImage,
            boundingBox,
            ui.Rect.fromLTWH(0, 0, boundingBox.width, boundingBox.height),
            ui.Paint(),
          );

          // Créer l'image découpée
          final croppedImage = recorder
              .endRecording()
              .toImage(boundingBox.width.toInt(), boundingBox.height.toInt());

          croppedImage.then((image) {
            debugPrint(
                'Visage découpé avec succès : ${image.width}x${image.height}');
            // Vous pouvez redimensionner et prétraiter cette image ici
          });

          File imageFile =
              await faceEmbedding.imageToFile(await croppedImage, "image");
          final embedding = faceEmbedding.generateEmbedding(imageFile);
          debugPrint("Voici la taille embedding: ${embedding.length}");
          final match = FaceEmbeddingComparator.isMatch(embedding,
              Provider.of<EmbeddingFace>(context, listen: false).getTheFace());
          debugPrint("Sont ils pareils ?? $match");
        });
      } catch (e) {
        debugPrint('Erreur : $e');
      }
    } else {
      debugPrint("Aucune face reconnue");
    }

    // for (Face face in faces) {
    //   final Rect boundingBox = face.boundingBox;

    //   final double? rotX =
    //       face.headEulerAngleX; // Head is tilted up and down rotX degrees
    //   final double? rotY =
    //       face.headEulerAngleY; // Head is rotated to the right rotY degrees
    //   final double? rotZ =
    //       face.headEulerAngleZ; // Head is tilted sideways rotZ degrees

    //   // If landmark detection was enabled with FaceDetectorOptions (mouth, ears,
    //   // eyes, cheeks, and nose available):
    //   final FaceLandmark? leftEar = face.landmarks[FaceLandmarkType.leftEar];
    //   if (leftEar != null) {
    //     final Point<int> leftEarPos = leftEar.position;
    //   }

    //   // If classification was enabled with FaceDetectorOptions:
    //   if (face.smilingProbability != null) {
    //     final double? smileProb = face.smilingProbability;
    //   }

    //   // If face tracking was enabled with FaceDetectorOptions:
    //   if (face.trackingId != null) {
    //     final int? id = face.trackingId;
    //   }
    // }
    faceDetector.close();
  }

  // removeRotation(File inputImage) async {
  //   final img.Image? capturedImage =
  //       img.decodeImage(await File(inputImage!.path).readAsBytes());
  //   final img.Image orientedImage = img.bakeOrientation(capturedImage!);
  //   return await File(_image!.path).writeAsBytes(img.encodeJpg(orientedImage));
  // }

  // TextEditingController textEditingController = TextEditingController();
  // showFaceRegistrationDialogue(Uint8List cropedFace, Recognition recognition){
  //   showDialog(
  //     context: context,
  //     builder: (ctx) => AlertDialog(
  //       title: const Text("Face Registration",textAlign: TextAlign.center),alignment: Alignment.center,
  //       content: SizedBox(
  //         height: 340,
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             const SizedBox(height: 20,),
  //             Image.memory(
  //               cropedFace,
  //               width: 200,
  //               height: 200,
  //             ),
  //             SizedBox(
  //               width: 200,
  //               child: TextField(
  //                 controller: textEditingController,
  //                   decoration: const InputDecoration( fillColor: Colors.white, filled: true,hintText: "Enter Name")
  //               ),
  //             ),
  //             const SizedBox(height: 10,),
  //             ElevatedButton(
  //                 onPressed: () {
  //                   recognizer.registerFaceInDB(textEditingController.text, recognition.embeddings);
  //                   textEditingController.text = "";
  //                   Navigator.pop(context);
  //                   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //                     content: Text("Face Registered"),
  //                   ));
  //                 },style: ElevatedButton.styleFrom(primary:Colors.blue,minimumSize: const Size(200,40)),
  //                 child: const Text("Register"))
  //           ],
  //         ),
  //       ),contentPadding: EdgeInsets.zero,
  //     ),
  //   );
  // }
  //TODO draw rectangles
  // var image;
  // drawRectangleAroundFaces() async {
  //   image = await _image?.readAsBytes();
  //   image = await decodeImageFromList(image);
  //   print("${image.width}   ${image.height}");
  //   setState(() {
  //     image;
  //     faces;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _image != null
              ? Container(
                  margin: const EdgeInsets.only(top: 100),
                  width: screenWidth - 50,
                  height: screenWidth - 50,
                  child: Image.file(_image!),
                )
              // Container(
              //   margin: const EdgeInsets.only(
              //       top: 60, left: 30, right: 30, bottom: 0),
              //   child: FittedBox(
              //     child: SizedBox(
              //       width: image.width.toDouble(),
              //       height: image.width.toDouble(),
              //       child: CustomPaint(
              //         painter: FacePainter(
              //             facesList: faces, imageFile: image),
              //       ),
              //     ),
              //   ),
              // )
              : Container(
                  margin: const EdgeInsets.only(top: 100),
                  child: Image.asset(
                    "assets/logo.png",
                    width: screenWidth - 100,
                    height: screenWidth - 100,
                  ),
                ),
          Container(
            height: 50,
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(200))),
                  child: InkWell(
                    onTap: () {
                      _imgFromGallery();
                    },
                    child: SizedBox(
                      width: screenWidth / 2 - 70,
                      height: screenWidth / 2 - 70,
                      child: Icon(Icons.image,
                          color: Colors.red[300], size: screenWidth / 7),
                    ),
                  ),
                ),
                Card(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(200))),
                  child: InkWell(
                    onTap: () {
                      _imgFromCamera();
                    },
                    child: SizedBox(
                      width: screenWidth / 2 - 70,
                      height: screenWidth / 2 - 70,
                      child: Icon(Icons.camera,
                          color: Colors.red[300], size: screenWidth / 7),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

// class FacePainter extends CustomPainter {
//   List<Face> facesList;
//   dynamic imageFile;
//   FacePainter({required this.facesList, @required this.imageFile});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     if (imageFile != null) {
//       canvas.drawImage(imageFile, Offset.zero, Paint());
//     }
//
//     Paint p = Paint();
//     p.color = Colors.red;
//     p.style = PaintingStyle.stroke;
//     p.strokeWidth = 3;
//
//     for (Face face in facesList) {
//       canvas.drawRect(face.boundingBox, p);
//     }
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }
