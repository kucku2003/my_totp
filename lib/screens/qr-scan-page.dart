import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io';
import '../models/setup-model.dart';
import '../screens/setup-page.dart';

class QRScanPage extends StatefulWidget {
  QRScanPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _QRScanPageState createState() => _QRScanPageState();
}


class _QRScanPageState extends State<QRScanPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode result;
  QRViewController controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SetupModel>(
      builder: (context, setupModel, child) => Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 10,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: (result != null)
                    ? Text(
                        'Found: ${result.code}', style: Theme.of(context).textTheme.headline6)
                    : Text('Scanning...', style: Theme.of(context).textTheme.headline6),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: SizedBox(
                  width: double.infinity,
                    child: ElevatedButton.icon(
                      label: Text('Add key'),
                      icon: Icon(Icons.done),
                      onPressed: (result != null) ? () => {
                        setupModel.setKey(result.code),
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => SetupPage(title: 'Setup new account')),
                        )
                      } : null,
                    ),
                  )
                )
              ),
            )
          ],
        ),
      )
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}