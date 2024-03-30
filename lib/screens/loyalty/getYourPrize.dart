// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_my_app/services/QrCodesService/QrCodesService.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GetYourPrize extends StatefulWidget {
  const GetYourPrize({super.key});

  @override
  _GetYourPrizeState createState() => _GetYourPrizeState();
}

class _GetYourPrizeState extends State<GetYourPrize> {
  String qrData = '';
  final qrCodeService = QrCodesService();

  void setQrData() async {
    var data = await qrCodeService.fetchUserPrizeQrCode();
    if (mounted) {
      setState(() {
        qrData = data;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setQrData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 248, 241),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: qrData.isNotEmpty
              ? Center(
                  child: QrImageView(
                    data: qrData,
                    version: QrVersions.auto,
                    size: 300.0,
                    backgroundColor: Colors.white, // Ustaw białe tło dla QRCode
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 4, // Ustaw grubość obramowania
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.black), // Ustaw kolor animacji
                  ),
                ),
        ),
      ),
    );
  }
}
