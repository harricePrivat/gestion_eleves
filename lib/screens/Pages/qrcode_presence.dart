import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrcodePresence extends StatefulWidget {
  const QrcodePresence({super.key});

  @override
  State<QrcodePresence> createState() => _QrcodePresenceState();
}

class _QrcodePresenceState extends State<QrcodePresence> {
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
      body: Center(
          child: SizedBox(
        height: 400,
        width: MediaQuery.of(context).size.width - 20,
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
                    final displayValue = firstData['displayValue'];

                    // Affiche la valeur
                    if (displayValue != null) {
                      debugPrint('Display Value: $displayValue');
                    } else {
                      debugPrint('Aucune displayValue détectée.');
                    }
                  } else {
                    debugPrint('La liste de données est vide ou invalide.');
                  }
                } else {
                  debugPrint('L\'objet raw est null ou n\'est pas un Map.');
                }
              },
            )),
      )),
    );
  }
}
