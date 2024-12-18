import 'package:flutter/material.dart';

class CardPc extends StatefulWidget {
  const CardPc({super.key});

  @override
  State<CardPc> createState() => _CardPcState();
}

class _CardPcState extends State<CardPc> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "PC non Panasonic",
                    style: theme.bodyLarge,
                  ),
                )
              ],
            )));
  }
}
