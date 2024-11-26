import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// ignore: must_be_immutable
class CardCompte extends StatefulWidget {
  String pathImages;
  String nom;
  String niveau;
  CardCompte(
      {super.key,
      required this.pathImages,
      required this.nom,
      required this.niveau});

  @override
  State<CardCompte> createState() => _CardCompteState();
}

class _CardCompteState extends State<CardCompte> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            //color: Colors.red
            gradient: const LinearGradient(colors: <Color>[
              Color.fromRGBO(240, 46, 46, 0.8),
              Color.fromRGBO(236, 107, 107, 0.898),
            ])),
        child: Padding(
            padding: const EdgeInsets.all(16.00),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ShadAvatar(
                      widget.pathImages,
                      size: const Size(90, 90),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.00),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Nom: ${widget.nom}"),
                          const Text("Statut: Etudiant"),
                          Text("Niveau: ${widget.niveau}")
                        ],
                      ),
                    ))
                  ],
                )
              ],
            )));
  }
}
