// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_my_app/models/UserQrCode.dart';
import 'package:flutter_my_app/services/QrCodesService/QrCodesService.dart';
import 'package:flutter_my_app/testSendingQrCode/testSendingQrCode.dart';
import 'package:qr_flutter/qr_flutter.dart';

class LoyaltyCard extends StatefulWidget {
  const LoyaltyCard({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoyaltyCardState createState() => _LoyaltyCardState();
}

final qrCodeSimulator = QRCodeSimulator();

class _LoyaltyCardState extends State<LoyaltyCard> {
  String qrData = "";
  final qrCodeService = QrCodesService();

  void setQrData() async {
    String data = await qrCodeService.fetchUserQrCode();

    setState(() {
      qrData = data;
    });
  }

  @override
  void initState() {
    super.initState();
    setQrData();
  }

  Future<void> _refreshQRData() async {
    setQrData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 248, 241),
        ),
        child: RefreshIndicator(
          color: Colors.white,
          backgroundColor: Colors.blue,
          onRefresh: _refreshQRData,
          child: Stack(
            children: <Widget>[
              ListView(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 100),
                    child: Container(
                      height: 320,
                      width: double.infinity,
                      margin: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage('images/coffeBackground.png'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: qrData.isNotEmpty
                            ? Center(
                                child: QrImageView(
                                  data: qrData.toString(),
                                  version: QrVersions.auto,
                                  size: 250.0,
                                  backgroundColor: Colors
                                      .white, // Ustaw białe tło dla QRCode
                                ),
                              )
                            : const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 4,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.black),
                                ),
                              ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 70),
                    child: Text(
                      'Lorem Ipsum',
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      textAlign: TextAlign.center,
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry s standard dummy text ever since the 1500s',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
