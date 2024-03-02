import 'package:flutter/material.dart';
import 'package:flutter_my_app/services/QrCodesService/QrCodesService.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GetYourPrize extends StatefulWidget {
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
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 248, 241),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: qrData.isNotEmpty
              ? Center(
                  child: QrImageView(
                    data: qrData,
                    version: QrVersions.auto,
                    size: 160.0,
                    backgroundColor: Colors.white, // Ustaw białe tło dla QRCode
                  ),
                )
              : Center(
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
