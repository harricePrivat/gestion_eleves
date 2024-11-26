import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gestion_etudiant/bloc/fetch/fectch_bloc.dart';
import 'package:gestion_etudiant/screens/Components/input_widget.dart';
import 'package:gestion_etudiant/screens/Components/list_tile_student.dart';
import 'package:gestion_etudiant/screens/Components/loading.dart';

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

  dynamic body;
  dynamic recherche;

  @override
  void initState() {
    super.initState();
    context.read<FectchBloc>().add(FetchData(
        "${dotenv.env['URL']}/get-student", {"niveau": widget.niveau}));
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
          title:
              BlocBuilder<FectchBloc, FectchState>(builder: (context, state) {
            if (state is FetchDataLoaded) {
              final dynamic length = state.object;

              return Text(
                "${widget.title}: (${length.length} étudiants)",
                style: theme.bodyMedium,
              );
            } else {
              return Text(
                "${widget.title}: (.. étudiants)",
                style: theme.bodyMedium,
              );
            }
          }),
          backgroundColor: const Color.fromARGB(255, 247, 101, 91),
        ),
        body: Stack(
          children: [
            BlocBuilder<FectchBloc, FectchState>(builder: (context, state) {
              if (state is FetchDataLoading) {
                return const Loading();
              } else if (state is FetchDataLoaded) {
                if (controller.text == '') {
                  body = state.object;
                  recherche = List.from(body);
                }
                return (recherche is List && recherche.isNotEmpty)
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
                        child: Text(
                          textAlign: TextAlign.center,
                          "Aucune etudiants inscrits ",
                          style: theme.displayLarge,
                        ),
                      );
              } else if (state is FetchDataError) {
                return Center(
                  child: Text(
                    "Erreur de connexion ",
                    style: theme.displayLarge,
                  ),
                );
              } else if (state is FetchDataLoadedBlank) {
                return Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    "Aucune etudiants inscrits ",
                    style: theme.displayLarge,
                  ),
                );
              }
              return Center(
                child: Text(
                  "Il n'y a rien  NULL ",
                  style: theme.displayLarge,
                ),
              );
            }),
            BlocBuilder<FectchBloc, FectchState>(builder: (context, state) {
              if (state is FetchDataLoaded) {
                return Positioned(
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
                );
              }
              return const SizedBox();
            }),
            AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                top: _showTextField ? 15 : -100, // Change la position verticale
                left: 55,
                right: 20, // Contraindre la largeur
                child: InputWidget(
                    valueChanged: (value) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        setState(() {
                          rechercheNom();
                        });
                      });
                    },
                    placeholder: "Recherche par le nom",
                    controller: controller)),
          ],
        ));
  }
}
