import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class QRScannerScreen extends StatefulWidget {
  static const route ='qr_scanner';

  const QRScannerScreen({super.key});
  @override
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
      ),
      body: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      // Aquí se ejecuta cada vez que se lee un código QR
      _processQRCode(scanData.code!);
    });
  }

  void _processQRCode(String qrData) async {
    // Aquí puedes verificar el contenido del código QR y actuar en consecuencia
    // Supongamos que el código QR contiene un identificador único de usuario
    String userId = qrData;

    // Consulta el documento del usuario en Firestore
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (userDoc.exists) {
      bool status = userDoc['acreditacion'];
      if (status) {
        // El status es true, muestra un popup indicando que el QR se utilizó
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('QR Utilizado'),
            content: Text('El código QR ya ha sido utilizado.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cerrar'),
              ),
            ],
          ),
        );
      } else {
        // El status es false, actualiza el documento en Firestore
        await FirebaseFirestore.instance
            .collection('usuarios')
            .doc(userId)
            .update({'acreditacion': true});

        // Mostrar un popup indicando que el QR se ha utilizado correctamente
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('QR Utilizado'),
            content: Text('El código QR se ha utilizado correctamente.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cerrar'),
              ),
            ],
          ),
        );
      }
    } else {
      // El documento del usuario no existe en Firestore
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('El código QR no corresponde a ningún usuario.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cerrar'),
            ),
          ],
        ),
      );
    }
  }
}
