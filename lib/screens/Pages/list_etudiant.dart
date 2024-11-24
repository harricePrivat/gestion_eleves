import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gestion_etudiant/screens/Components/input_widget.dart';
import 'package:gestion_etudiant/screens/Components/list_tile_student.dart';
import 'package:gestion_etudiant/screens/Components/loading.dart';
import 'package:gestion_etudiant/services/send_data.dart';

// ignore: must_be_immutable
class ListEtudiant extends StatefulWidget {
  String title;
  String niveau;
  ListEtudiant({super.key, required this.title, required this.niveau});

  @override
  State<ListEtudiant> createState() => _ListEtudiantState();
}

class _ListEtudiantState extends State<ListEtudiant> {
  bool _showTextField = false;
  TextEditingController controller = TextEditingController();

  bool loading = false;
  dynamic body;
  dynamic recherche;
  Future<void> getAllStudent(String niveau) async {
    setState(() {
      loading = true;
    });
    final response = await SendData()
        .goPost("${dotenv.env['URL']}/get-student", {"niveau": niveau});
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        body = data;
        recherche = body;
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getAllStudent(widget.niveau);
  }

  void rechercheNom() {
    setState(() {
      // Si le champ de recherche est vide, on affiche tous les éléments
      if (controller.text.isEmpty) {
        recherche = List.from(body); // Copie la liste originale
      } else {
        recherche = body.where((etudiant) {
          String nom = etudiant['nom'].toLowerCase();
          String prenom = etudiant['prenom'].toLowerCase();
          String critere = controller.text.toLowerCase();

          // Vérifie si le nom ou le prénom contient le texte recherché
          return nom.contains(critere) || prenom.contains(critere);
        }).toList(); // Convertit l'itérable en une liste
      }
    });
  }

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
            "${widget.title}: (${body == null ? 0 : body.length} étudiants)",
            style: theme.bodyMedium,
          ),
          backgroundColor: const Color.fromARGB(255, 247, 101, 91),
        ),
        body: Stack(
          children: [
            ((recherche is List && recherche.isNotEmpty)
                ? ListView.builder(
                    itemCount: recherche.length,
                    itemBuilder: (context, i) {
                      return ListtileStudent(
                        cin: recherche[i]['numero_cin'].toString(),
                        nom: recherche[i]['nom'],
                        prenom: recherche[i]['prenom'],
                        niveau: recherche[i]['niveau'],
                        pathImages: recherche[i]['path_images'],
                      );
                    },
                  )
                : Center(
                    child: Padding(
                    padding: const EdgeInsets.all(16.00),
                    child: Text(
                      textAlign: TextAlign.center,
                      // "Aucune etudiants inscrits",
                      controller.text.isEmpty
                          ? "Aucune etudiants inscrits"
                          : "Etudiants introuvables",
                      style: theme.displayLarge,
                    ),
                  ))),
            ((body is List && body.isNotEmpty))
                ? Positioned(
                    top: 10,
                    left: 10,
                    child: SizedBox(
                      height: 45,
                      width: 45,
                      child: Card(
                        child: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            setState(() {
                              _showTextField =
                                  !_showTextField; // Toggle visibility
                            });
                          },
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
            // TextField avec animation de glissement
            ((body is List && body.isNotEmpty))
                ? AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    top: _showTextField
                        ? 15
                        : -100, // Change la position verticale
                    left: 55,
                    right: 20, // Contraindre la largeur
                    child: InputWidget(
                        valueChanged: (value) {
                          setState(() {
                            rechercheNom();
                          });
                        },
                        placeholder: "Recherche par le nom",
                        controller: controller))
                : const SizedBox(),
            if (loading) const Loading(),
          ],
        ));
  }
}
