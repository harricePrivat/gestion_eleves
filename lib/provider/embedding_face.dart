import 'package:flutter/material.dart';

class EmbeddingFace extends ChangeNotifier {
  List<double>? myFace;
  String? nom;

  List<double> getTheFace() {
    return myFace!;
  }

  void setTheFace(List<double> myFace) {
    nom = "Brice";
    this.myFace = myFace;
    notifyListeners();
  }
}
