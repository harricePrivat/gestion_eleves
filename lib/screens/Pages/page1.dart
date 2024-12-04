import 'package:flutter/material.dart';
import 'package:gestion_etudiant/screens/Pages/accueil_list.dart';
import 'package:gestion_etudiant/screens/Pages/ajout_etudiant.dart';
import 'package:gestion_etudiant/screens/Pages/ajout_etudiant_test.dart';
import 'package:gestion_etudiant/screens/Pages/qrcode_presence.dart';
import '../Components/fonctionnalites.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  List<String> title = [
    "Presence",
    'Liste des étudiants',
    'Ajout des etudiants',
    'Gestion des machines'
  ];
  List<Widget> fonctionnalites = [
    const QrcodePresence(),
    const AccueilList(),
    const AjoutEtudiant(),
    const AjoutEtudiantTest(),
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: 4,
        itemBuilder: (context, i) {
          return GestureDetector(
            child: Fonctionnalites(title: title[i]),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => fonctionnalites[i]));
            },
          );
        });
  }
}
