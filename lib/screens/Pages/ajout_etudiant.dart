import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gestion_etudiant/screens/Components/input_naissance.dart';
import 'package:gestion_etudiant/screens/Components/input_widget.dart';
import 'package:gestion_etudiant/screens/Components/select.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';

class AjoutEtudiant extends StatefulWidget {
  const AjoutEtudiant({super.key});

  @override
  State<AjoutEtudiant> createState() => _AjoutEtudiantState();
}

class _AjoutEtudiantState extends State<AjoutEtudiant> {
  TextEditingController nom = TextEditingController();
  TextEditingController prenom = TextEditingController();
<<<<<<< HEAD:lib/Screens/Pages/ajout_etudiant.dart
  TextEditingController numCin = TextEditingController();
=======
  TextEditingController cin = TextEditingController();

>>>>>>> 58f13c3f20f6d0c84428bda76870785c6e65fc9e:lib/screens/Pages/ajout_etudiant.dart
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: Text(
          "Ajout étudiant",
          style: theme.bodyMedium,
        ),
        backgroundColor: const Color.fromARGB(255, 247, 101, 91),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.00),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
<<<<<<< HEAD:lib/Screens/Pages/ajout_etudiant.dart
                input("Nom: *", "ex: NARIVELO", nom, false),
                espacement(),
                input("Prénom: *", "ex: Brice Privat ", prenom, false),
                espacement(),
                const SingleDatePicker(),
                espacement(),
                input("Numéro CIN:(facultatif)", "numero CIN", numCin, true),
=======
                input("Nom: *", "ex: NARIVELO", nom),
                espacement(),
                input("Prénom: *", "ex: Brice Privat ", prenom),
                espacement(),
                const SingleDatePicker(),
                espacement(),
                input("Numéro CIN:(facultatif)", "numero CIN", cin),
>>>>>>> 58f13c3f20f6d0c84428bda76870785c6e65fc9e:lib/screens/Pages/ajout_etudiant.dart
                espacement(),
                InputSelect(
                  getValueSelect: (value) {
                    print(value);
                  },
                ),
                espacement(),
                Text(
                  "Photo de l'étudiant: *",
                  style: theme.displayMedium,
                ),
                const SizedBox(
                  height: 4,
                ),
                GestureDetector(
                  onTap: () async {
                    await _pickImage(ImageSource.gallery);
                  },
                  child: Container(
                    // width: 200,
                    //  / height: 25,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        color: const Color.fromARGB(255, 220, 220, 220),
                        border: Border.all(width: 0.001, color: Colors.grey)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.add),
                        Text(
                          "Ajouter une photo (Obligatoire)",
                          style: theme.titleMedium,
                        )
                      ],
                    ),
                  ),
                ),
                //  espacement(),
                _image == null
                    ? Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              color: Colors.red,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Aucune photo selectionée",
                              style: GoogleFonts.lato(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                          ],
                        ))
                    : Padding(
                        padding: const EdgeInsets.all(16.00),
                        child: Stack(
                          children: [
                            Image.file(File(_image!.path)),
                            Positioned(
                                child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _image = null;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.red,
                                    )))
                          ],
                        )),
                espacement(),
                ShadButton(
                  onPressed: () {
                    if (nom.text.compareTo('') == 0 &&
                        prenom.text.compareTo('') == 0 &&
                        numCin.text.compareTo('') == 0) {}
                  },
                  decoration: const ShadDecoration(
                      gradient: LinearGradient(colors: <Color>[
                    Color.fromRGBO(240, 46, 46, 0.8),
                    Color.fromRGBO(236, 107, 107, 0.898),
                  ])),
                  child: const Text(
                    "Ajouter l'etudiant",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget espacement() {
    return const SizedBox(
      height: 16,
    );
  }

  Widget input(String label, String placeholder, TextEditingController control,
      bool checkType) {
    final theme = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.displayMedium,
        ),
        const SizedBox(
          height: 4,
        ),
        InputWidget(
            placeholder: placeholder,
            textInputType: checkType
                ? const TextInputType.numberWithOptions()
                : TextInputType.text,
            controller: control),
      ],
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? selectedImage = await _picker.pickImage(source: source);
    setState(() {
      _image = selectedImage;
    });
  }
}