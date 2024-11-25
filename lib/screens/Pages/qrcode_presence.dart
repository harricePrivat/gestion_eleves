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
        height: 500,
        width: MediaQuery.of(context).size.width - 20,
        child: Expanded(
            flex: 5,
            child: MobileScanner(
              onDetect: (barCode) {
                print(barCode);
              },
            )),
      )),
    );
  }

  // void onQRViewCreated(QRViewController controller) {
  //   this.controller = controller;
  //   controller.scannedDataStream.listen((scanData) {
  //     print(scanData.code);
  //   });
  // }
}
