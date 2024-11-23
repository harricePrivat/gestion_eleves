import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Fonctionnalites extends StatefulWidget {
  String title;
   Fonctionnalites({super.key,required this.title});

  @override
  State<Fonctionnalites> createState() => _FonctionnalitesState();
}

class _FonctionnalitesState extends State<Fonctionnalites> {
  @override
  Widget build(BuildContext context) {
    final textTheme=Theme.of(context).textTheme;
    return  Expanded(child: Padding(padding: const EdgeInsets.all(16.00),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(width: 0.4,color: const Color.fromARGB(255, 247, 101, 91)),
      ),
      child:  Padding(padding: const EdgeInsets.all(4.00),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.00),
          child: Image.asset("assets/test.png",fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
                    height: 100,
          ),
        ),
        const SizedBox(height: 8,),
        Text(widget.title,style: textTheme.displayMedium,),
      ],) 
      ),
    ),));
  }
}