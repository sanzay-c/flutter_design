import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan QR Code"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context); // Pop the current route and go back
            },
            icon: const Icon(Icons.qr_code),
          ),
        ],
      ),
      body: MobileScanner(
        controller: MobileScannerController(
          detectionSpeed: DetectionSpeed.noDuplicates,
          returnImage: true,
        ),
        onDetect: (barcodesCap) {
          final List<Barcode> capture = barcodesCap.barcodes;
          final Uint8List? image = barcodesCap.image;
          for (final captures in capture) {
            print('Barcode found: ${captures.rawValue}');
          }
          if (image != null && capture.isNotEmpty) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(capture.first.rawValue ?? "No value found"),
                  content: Image.memory(image),
                );
              },
            );
          }
        },
      ),
    );
  }
}
