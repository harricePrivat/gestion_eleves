import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestion_etudiant/bloc/addStudent/add_student_bloc.dart';
import 'package:gestion_etudiant/bloc/fetch/fectch_bloc.dart';
import 'package:gestion_etudiant/screens/theme.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'screens/Pages/accueil.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {
  dotenv.load(fileName: '.env');
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => AddStudentBloc(),
      ),
      BlocProvider(
        create: (context) => FectchBloc(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadApp(
      theme: ShadThemeData(
          datePickerTheme: const ShadDatePickerTheme(
              selectedDayButtonTextStyle: TextStyle(color: Colors.grey),
              dayButtonDecoration:
                  ShadDecoration(labelStyle: TextStyle(color: Colors.grey))),
          colorScheme: const ShadRedColorScheme.light(primary: Colors.red),
          brightness: Brightness.light),
      debugShowCheckedModeBanner: false,
      home: MaterialApp(
        theme: AppTheme.appTheme,
        debugShowCheckedModeBanner: false,
        home: const Accueil(),
      ),
    );
  }
}
