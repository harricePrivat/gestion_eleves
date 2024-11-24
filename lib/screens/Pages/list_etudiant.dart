import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gestion_etudiant/screens/Components/listTile_student.dart';
import 'package:gestion_etudiant/screens/Components/loading.dart';
import 'package:gestion_etudiant/services/send_data.dart';

// ignore: must_be_immutable
class ListEtudiant extends StatefulWidget {
  String title;
  String niveau;
  ListEtudiant({super.key, required this.title, required this.niveau});

  @override
  State<ListEtudiant> createState() => _ListEtudiantState();
}

class _ListEtudiantState extends State<ListEtudiant> {
  bool loading = false;
  dynamic body;
  Future<void> getAllStudent(String niveau) async {
    setState(() {
      loading = true;
    });
    final response = await SendData()
        .goPost("${dotenv.env['URL']}/get-student", {"niveau": niveau});
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        body = data;
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getAllStudent(widget.niveau);
  }

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
            "${widget.title}: (${body == null ? 0 : body.length} étudiants)",
            style: theme.bodyMedium,
          ),
          backgroundColor: const Color.fromARGB(255, 247, 101, 91),
        ),
        body: Stack(
          children: [
            ((body is List && body.isNotEmpty)
                ? ListView.builder(
                    itemCount: body.length,
                    itemBuilder: (context, i) {
                      return ListtileStudent(
                        cin: body[i]['numero_cin'].toString(),
                        nom: body[i]['nom'],
                        prenom: body[i]['prenom'],
                        niveau: body[i]['niveau'],
                        pathImages: body[i]['path_images'],
                      );
                    },
                  )
                : Center(
                    child: Padding(
                    padding: const EdgeInsets.all(16.00),
                    child: Text(
                      textAlign: TextAlign.center,
                      "Aucune etudiants inscrits",
                      style: theme.displayLarge,
                    ),
                  ))),
            if (loading) const Loading(),
          ],
        ));
  }
}
