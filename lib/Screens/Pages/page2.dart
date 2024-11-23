import 'package:flutter/material.dart';
import 'package:gestion_etudiant/Screens/Components/card_compte.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        Padding(
          padding: EdgeInsets.all(16.00),
          child: Column(
            children: [
              CardCompte(),
              SizedBox(
                height: 16.00,
              ),
              //  Parametre(),
              // const SizedBox(height: 16.00,),
              ShadButton(
                decoration: ShadDecoration(
                    gradient: LinearGradient(colors: <Color>[
                  Color.fromRGBO(240, 46, 46, 0.8),
                  Color.fromRGBO(236, 107, 107, 0.898),
                ])),
                child: Text(
                  "Deconnexion",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
