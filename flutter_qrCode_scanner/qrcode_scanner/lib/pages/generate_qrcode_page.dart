import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:qrcode_scanner/pages/scan_page.dart'; // Import ScanPage

class GenerateQrcodePage extends StatefulWidget {
  const GenerateQrcodePage({super.key});

  @override
  State<GenerateQrcodePage> createState() => _GenerateQrcodePageState();
}

class _GenerateQrcodePageState extends State<GenerateQrcodePage> {
  String? qrData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Generate QR Code"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const ScanPage(), // Navigate to ScanPage
                ),
              );
            },
            icon: const Icon(Icons.qr_code),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Enter data for QR Code',
                  border: OutlineInputBorder(  
                    borderRadius:
                        BorderRadius.circular(15.0), // Set the border radius here
                    borderSide: const BorderSide(
                      color:
                          Colors.blue, // You can change the color of the border
                      width: 2.0, // You can adjust the width of the border
                    ),
                  ),
                ),
                onSubmitted: (value) {
                  setState(() {
                    qrData = value;
                  });
                },
              ),
            ),
            if (qrData != null && qrData!.isNotEmpty)
              PrettyQrView.data(data: qrData!)
            else
              const Text("Enter text to generate a QR code")
          ],
        ),
      ),
    );
  }
}
