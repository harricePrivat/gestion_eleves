import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestion_etudiant/bloc/addStudent/add_student_bloc.dart';
import 'package:gestion_etudiant/screens/Components/loading.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AjoutEtudiantTest extends StatefulWidget {
  const AjoutEtudiantTest({super.key});

  @override
  State<AjoutEtudiantTest> createState() => _AjoutEtudiantTestState();
}

class _AjoutEtudiantTestState extends State<AjoutEtudiantTest> {
  late InputImage inputImage;
  var options = FaceDetectorOptions();
// final faceDetector = FaceDetector(options: options);
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
        title: BlocBuilder<AddStudentBloc, AddStudentState>(
            builder: (event, state) {
          if (state is AddStudentInitial) {
            return Text(
              "Initial",
              style: theme.bodyMedium,
            );
          } else if (state is AddStudentLoading) {
            return Text(
              "Loading",
              style: theme.bodyMedium,
            );
          } else if (state is AddStudentDone) {
            return Text(
              "Done",
              style: theme.bodyMedium,
            );
          }
          return const Text("Bonjour les gens");
        }),
        backgroundColor: const Color.fromARGB(255, 247, 101, 91),
      ),
      body: BlocBuilder<AddStudentBloc, AddStudentState>(
          builder: (context, state) {
        if (state is AddStudentInitial) {
          return Center(
            child: ShadButton(
              child: const Text("BLoC"),
              onPressed: () {
                FormData data = FormData();
                context.read<AddStudentBloc>().add(SendDataStudent(data));
              },
            ),
          );
        } else if (state is AddStudentLoading) {
          return const Loading();
        } else if (state is AddStudentDone) {
          return Center(
            child: Text(
              "Reussi pour moi",
              style: theme.titleMedium,
            ),
          );
        }
        return const Text("Bonjour les gens");
      }),
    );
  }
}
