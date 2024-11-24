import 'package:flutter/material.dart';
import 'package:gestion_etudiant/screens/Components/listTile_student.dart';

// ignore: must_be_immutable
class ListEtudiant extends StatefulWidget {
  String title;
  ListEtudiant({super.key, required this.title});

  @override
  State<ListEtudiant> createState() => _ListEtudiantState();
}

class _ListEtudiantState extends State<ListEtudiant> {
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
          "${widget.title}:",
          style: theme.bodyMedium,
        ),
        backgroundColor: const Color.fromARGB(255, 247, 101, 91),
      ),
      body: Column(
        children: [
          ListtileStudent(),
          ListtileStudent(),
        ],
      ),
    );
  }
}
