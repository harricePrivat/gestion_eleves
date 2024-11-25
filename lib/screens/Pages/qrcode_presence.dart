import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrcodePresence extends StatefulWidget {
  const QrcodePresence({super.key});

  @override
  State<QrcodePresence> createState() => _QrcodePresenceState();
}

class _QrcodePresenceState extends State<QrcodePresence> {
  QRViewController? controller;
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
        child: Expanded(
            flex: 5,
            child: QRView(key: qrKey, onQRViewCreated: onQRViewCreated)),
      ),
    );
  }

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      print(scanData.code);
    });
  }
}
