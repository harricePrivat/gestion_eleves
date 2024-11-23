import 'package:flutter/material.dart';
import 'package:gestion_etudiant/screens/Pages/page1.dart';
import 'package:gestion_etudiant/screens/Pages/page2.dart';

class Accueil extends StatefulWidget {
  const Accueil({super.key});

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    List<Widget> listPages = [const Page1(), const Page2()];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Gestion des eleves - MIT",
          style: theme.textTheme.bodyMedium,
        ),
        backgroundColor: const Color.fromARGB(255, 247, 101, 91),
      ),
      body: listPages[index],
      bottomNavigationBar: BottomNavigationBar(
          selectedIconTheme: const IconThemeData(size: 35),
          currentIndex: index,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          showUnselectedLabels: true,
          selectedItemColor: const Color.fromARGB(255, 247, 101, 91),
          unselectedItemColor: const Color.fromARGB(255, 116, 115, 115),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.school,
                ),
                label: "Eleves"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_box,
                ),
                label: "Mon Compte")
          ]),
    );
  }
}
