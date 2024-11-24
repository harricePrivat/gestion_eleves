import 'package:flutter/material.dart';
import 'package:gestion_etudiant/screens/Pages/list_etudiant.dart';

import '../Components/fonctionnalites.dart';

class AccueilList extends StatefulWidget {
  const AccueilList({super.key});

  @override
  State<AccueilList> createState() => _AccueilListState();
}

class _AccueilListState extends State<AccueilList> {
  List<String> title = [
    'L1',
    'L2',
    'L3',
    'M1',
    'M2',
  ];

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
            "Niveau:",
            style: theme.bodyMedium,
          ),
          backgroundColor: const Color.fromARGB(255, 247, 101, 91),
        ),
        body: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: title.length,
            itemBuilder: (context, i) {
              return GestureDetector(
                child: Fonctionnalites(title: title[i]),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ListEtudiant(
                                title: title[i],
                              )));
                },
              );
            }));
  }
}
