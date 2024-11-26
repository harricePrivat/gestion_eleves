import 'package:flutter/material.dart';
import 'package:gestion_etudiant/screens/Components/card_pc.dart';
import '../Components/card_compte.dart';

// ignore: must_be_immutable
class DetailsStudent extends StatefulWidget {
  String pathImages;
  String niveau;
  String prenom;
  DetailsStudent(
      {super.key,
      required this.niveau,
      required this.prenom,
      required this.pathImages});

  @override
  State<DetailsStudent> createState() => _DetailsStudentState();
}

class _DetailsStudentState extends State<DetailsStudent> {
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
            "${widget.niveau.toUpperCase()}: ${widget.prenom} ",
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
                  Text(
                    "Informations de l'étudiant:",
                    style: theme.titleMedium,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CardCompte(
                    niveau: widget.niveau.toUpperCase(),
                    nom: widget.prenom,
                    pathImages: widget.pathImages,
                  ),
                  const SizedBox(
                    height: 16.00,
                  ),
                  Text(
                    "Informations sur le PC:",
                    style: theme.titleMedium,
                  ),
                  const SizedBox(
                    height: 16.00,
                  ),
                  const CardPc()
                ],
              ),
            )
          ],
        ));
  }
}
