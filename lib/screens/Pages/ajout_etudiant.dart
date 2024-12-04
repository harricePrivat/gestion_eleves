import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gestion_etudiant/screens/Components/input_widget.dart';
import 'package:gestion_etudiant/screens/Components/loading.dart';
import 'package:gestion_etudiant/screens/Components/pick_images.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../Components/select.dart';
import '../Components/input_naissance.dart';

class AjoutEtudiant extends StatefulWidget {
  const AjoutEtudiant({super.key});

  @override
  State<AjoutEtudiant> createState() => _AjoutEtudiantState();
}

class _AjoutEtudiantState extends State<AjoutEtudiant> {
  String niveau = '';
  String anneeBacc = '';
  bool loading = false;
  DateTime? dateTime;
  TextEditingController nom = TextEditingController();
  TextEditingController prenom = TextEditingController();
  TextEditingController numCin = TextEditingController();

  XFile? _imageStudent;
  XFile? _imageNote;
  XFile? _imageCIN;

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
        body: Stack(
          children: [
            ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.00),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      input("Nom: *", "ex: NARIVELO", nom, false),
                      espacement(),
                      input("Prénom: *", "ex: Brice Privat ", prenom, false),
                      espacement(),
                      SingleDatePicker(
                        dateTime: dateTime,
                        dateChanged: (value) {
                          setState(() {
                            dateTime = value!;
                          });
                        },
                      ),
                      espacement(),
                      input("Numéro CIN:(facultatif)", "numero CIN", numCin,
                          true),
                      espacement(),
                      InputSelect(
                        label: 'Niveau *:',
                        itemSelects: const {
                          'l1': 'L1',
                          'l2': 'L2',
                          'l3': 'L3',
                          'm1': 'M1',
                          'm2': 'M2',
                        },
                        getValueSelect: (value) {
                          setState(() {
                            niveau = value!;
                          });
                        },
                      ),
                      espacement(),
                      InputSelect(
                        label: 'Année du Bacc: *',
                        itemSelects: const {
                          '2022': '2022',
                          '2023': '2023',
                          '2024': '2024',
                        },
                        getValueSelect: (value) {
                          setState(() {
                            anneeBacc = value!;
                          });
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
                      PickImages(
                        images: _imageStudent,
                        name: "Photo de l'étudiant(Obligatoire)",
                        //     images: _image,
                        onPicked: () async {
                          final ImagePicker picker = ImagePicker();
                          _imageStudent = await picker.pickImage(
                              source: ImageSource.camera);
                          setState(() {}); // Force la reconstruction du widget.
                        },
                      ),
                      espacement(),
                      PickImages(
                        images: _imageCIN,
                        name: "Photo de la CIN(Obligatoire)",
                        onPicked: () async {
                          final ImagePicker picker = ImagePicker();
                          _imageCIN = await picker.pickImage(
                              source: ImageSource.camera);
                          setState(() {}); // Force la reconstruction du widget.
                        },
                      ),
                      espacement(),
                      PickImages(
                        images: _imageNote,
                        name: "Photo de la relevet des notes(Obligatoire)",
                        onPicked: () async {
                          final picker = ImagePicker();
                          _imageNote = await picker.pickImage(
                              source: ImageSource.camera);
                          setState(() {}); // Force la reconstruction du widget.
                        },
                      ),
                      espacement(),
                      ShadButton(
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });
                          numCin.text.compareTo('') == 0
                              ? numCin.text = 'no'
                              : {};
                          if (_imageStudent != null &&
                              _imageCIN != null &&
                              _imageNote != null &&
                              niveau.compareTo('') != 0 &&
                              dateTime != null &&
                              nom.text.compareTo('') != 0 &&
                              prenom.text.compareTo('') != 0) {
                            FormData formData = FormData.fromMap({
                              "nom": nom.text.trim(),
                              "prenom": prenom.text.trim(),
                              "naissance": dateTime.toString(),
                              'cin': numCin.text.trim(),
                              'anneeBacc': anneeBacc,
                              "niveau": niveau,
                              "image_student": await MultipartFile.fromFile(
                                  _imageStudent!.path,
                                  filename: _imageStudent!.name),
                              "image_note": await MultipartFile.fromFile(
                                  _imageNote!.path,
                                  filename: _imageNote!.name),
                              "image_cin": await MultipartFile.fromFile(
                                  _imageCIN!.path,
                                  filename: _imageCIN!.name),
                            });
                            final response = await Dio().post(
                                "${dotenv.env['URL']}/create-user",
                                data: formData);
                            if (response.statusCode == 200) {
                              nom.clear();
                              prenom.clear();
                              numCin.clear();
                              _imageStudent = null;
                              _imageCIN = null;
                              _imageNote = null;
                              setState(() {
                                loading = false;
                              });
                              Fluttertoast.showToast(
                                  msg: "Etudiant bien ajouter");
                            } else {
                              setState(() {
                                loading = false;
                              });
                              Fluttertoast.showToast(
                                  msg:
                                      "Etudiant NON ajouter,erreur de connexion");
                            }
                          } else {
                            Fluttertoast.showToast(
                                msg: "Veuillez remplir tous les champs");
                          }
                          setState(() {
                            loading = false;
                          });
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
            if (loading) const Loading()
          ],
        ));
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
}
