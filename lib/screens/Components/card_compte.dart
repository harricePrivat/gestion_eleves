import 'package:flutter/material.dart';

class CardCompte extends StatefulWidget {
  const CardCompte({super.key});

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
            gradient:  const LinearGradient(colors: <Color>[
                  Color.fromRGBO(240, 46, 46, 0.8),
                  Color.fromRGBO(236, 107, 107, 0.898),
                ])
          ),
          child:  Padding(padding:const  EdgeInsets.all(16.00),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Row(
              children: [ ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset("assets/avatar.jpg",height: 100,width: 100,)
              ),
             const  Padding(padding: EdgeInsets.all(16.00),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
             Text("Nom: Brice Privat"),
                Text("Statut: Etudiant"),
                Text("Niveau: L3")
              ],),)
              ],)
            ],
          )
          )
        );
  }
}