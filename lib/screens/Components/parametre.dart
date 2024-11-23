import 'package:flutter/material.dart';

class Parametre extends StatefulWidget {
  const Parametre({super.key});

  @override
  State<Parametre> createState() => _ParametreState();
}

class _ParametreState extends State<Parametre> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          //color: Colors.red
          gradient: const LinearGradient(colors: <Color>[
            Color.fromRGBO(240, 46, 46, 0.8),
            Color.fromRGBO(236, 107, 107, 0.898),
          ])),
      child: const Row(
        children: [],
      ),
    );
  }
}
