import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ListtileStudent extends StatefulWidget {
  const ListtileStudent({super.key});

  @override
  State<ListtileStudent> createState() => _ListtileStudentState();
}

class _ListtileStudentState extends State<ListtileStudent> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
        ),
        child: const ShadAvatar("assets/avatar.jpg"),
      ),
      title: const Text("Brice Privat"),
      subtitle: const Text("L3"),
      trailing: const Icon(
        Icons.computer,
        color: Colors.red,
      ),
    );
  }
}
