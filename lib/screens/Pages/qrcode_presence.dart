import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class QrcodePresence extends StatefulWidget {
  const QrcodePresence({super.key});

  @override
  State<QrcodePresence> createState() => _QrcodePresenceState();
}

class _QrcodePresenceState extends State<QrcodePresence> {
  bool showValue = false;
  dynamic displayValue;
  MobileScanner? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: "qr");
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
          "Présence",
          style: theme.bodyMedium,
        ),
        backgroundColor: const Color.fromARGB(255, 247, 101, 91),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      "Scanner ici le code QR de l'etudiant:",
                      style: theme.titleMedium),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 400,
                    width: MediaQuery.of(context).size.width - 32,
                    child: Expanded(
                        flex: 5,
                        child: MobileScanner(
                          onDetect: (barCode) {
                            final raw = barCode.raw;
                            if (raw != null && raw is Map) {
                              // Vérifie si 'data' existe et contient des éléments
                              final dataList = raw['data'];
                              if (dataList != null &&
                                  dataList is List &&
                                  dataList.isNotEmpty) {
                                // Récupère le premier élément de la liste
                                final firstData = dataList[0];

                                // Récupère la valeur de 'displayValue'
                                setState(() {
                                  displayValue = firstData['displayValue'];
                                  showValue = true;
                                });

                                // Affiche la valeur
                                if (displayValue != null) {
                                  debugPrint('Display Value: $displayValue');
                                } else {
                                  debugPrint('Aucune displayValue détectée.');
                                }
                              } else {
                                debugPrint(
                                    'La liste de données est vide ou invalide.');
                              }
                            } else {
                              debugPrint(
                                  'L\'objet raw est null ou n\'est pas un Map.');
                            }
                          },
                        )),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  showValue
                      ? Text(
                          textAlign: TextAlign.center,
                          displayValue,
                          style: theme.displayMedium,
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 16,
                  ),
                  showValue
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ShadButton(
                              decoration: const ShadDecoration(
                                  gradient: LinearGradient(colors: <Color>[
                                Color.fromRGBO(240, 46, 46, 0.8),
                                Color.fromRGBO(236, 107, 107, 0.898),
                              ])),
                              onPressed: () {
                                setState(() {
                                  showValue = false;
                                });
                              },
                              child: const Text(
                                "Ok!!",
                                // style: theme.bodyMedium,
                              ),
                            ),
                            const SizedBox(
                              height: 16.00,
                            ),
                            ShadButton(
                              decoration:
                                  const ShadDecoration(color: Colors.grey),
                              child: const Text(
                                "Reesayez",
                                //      style: theme.bodyMedium,
                              ),
                              onPressed: () {
                                setState(() {
                                  showValue = false;
                                });
                              },
                            )
                          ],
                        )
                      : const SizedBox()
                ],
              )),
            ],
          )),
    );
  }
}
