import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'recognition_screen.dart';
import 'registration_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              margin: const EdgeInsets.only(top: 100),
              child: Image.asset(
                "assets/logo.png",
                width: screenWidth - 40,
                height: screenWidth - 40,
              )),
          // Container(
          //   margin: const EdgeInsets.only(bottom: 50),
          //   child:
          Padding(
            padding: const EdgeInsets.only(bottom: 32, left: 16, right: 16),
            child: Column(
              children: [
                ShadButton(
                    width: double.infinity,
                    decoration: const ShadDecoration(
                        gradient: LinearGradient(colors: <Color>[
                      Color.fromRGBO(240, 46, 46, 0.8),
                      Color.fromRGBO(236, 107, 107, 0.898),
                    ])),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const RegistrationScreen()));
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(color: Colors.white),
                    )
                    //  style: ElevatedButton.styleFrom(minimumSize: Size(screenWidth-30, 50)), child: const Text("Register"),
                    ),
                const SizedBox(
                  height: 20,
                ),
                ShadButton(
                  width: double.infinity,
                  decoration: const ShadDecoration(
                      gradient: LinearGradient(colors: <Color>[
                    Color.fromRGBO(240, 46, 46, 0.8),
                    Color.fromRGBO(236, 107, 107, 0.898),
                  ])),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RecognitionScreen()));
                  },
                  //  style: ElevatedButton.styleFrom(minimumSize: Size(screenWidth-30, 50)),
                  child: const Text(
                    "Recognize",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          )
          //   ),
        ],
      ),
    );
  }
}
