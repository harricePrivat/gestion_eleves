import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// ignore: must_be_immutable
class ListtileStudent extends StatefulWidget {
  String nom;
  String prenom;
  String niveau;
  String pathImages;
  String cin;
  ListtileStudent(
      {super.key,
      required this.nom,
      required this.prenom,
      required this.niveau,
      required this.cin,
      required this.pathImages});

  @override
  State<ListtileStudent> createState() => _ListtileStudentState();
}

class _ListtileStudentState extends State<ListtileStudent> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return ListTile(
      leading: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
        ),
        child: ShadAvatar(widget.pathImages),
      ),
      title: Text(
        "${widget.nom} ${widget.prenom}",
        style: theme.titleMedium,
      ),
      subtitle: Text(widget.cin),
      trailing: const Icon(
        Icons.computer,
        color: Colors.red,
      ),
    );
  }
}
