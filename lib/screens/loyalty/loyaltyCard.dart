import 'package:flutter/material.dart';
import 'package:flutter_my_app/models/UserQrCode.dart';
import 'package:flutter_my_app/services/QrCodesService/QrCodesService.dart';
import 'package:flutter_my_app/testSendingQrCode/testSendingQrCode.dart';
import 'package:qr_flutter/qr_flutter.dart';

class LoyaltyCard extends StatefulWidget {
  @override
  _LoyaltyCardState createState() => _LoyaltyCardState();
}

final qrCodeSimulator = QRCodeSimulator();

class _LoyaltyCardState extends State<LoyaltyCard> {
  UserQrCode qrData = new UserQrCode(DateTime.now(), '', '');
  final qrCodeService = QrCodesService();

  void setQrData() async {
    UserQrCode? data = await qrCodeService.fetchUserQrCode();

    setState(() {
      qrData = data!;
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

  void _sendQRCodeData() {
    if (mounted) {
      qrCodeSimulator.sendQRCodeDataToServer(qrData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _sendQRCodeData,
        child: Icon(Icons.send),
      ),
      body: Container(
        decoration: BoxDecoration(
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
                    padding: EdgeInsets.only(top: 100),
                    child: Container(
                      height: 220,
                      width: double.infinity,
                      margin: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/coffeBackground.png'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: qrData.id.isNotEmpty
                            ? Center(
                                child: QrImageView(
                                  data: qrData.toString(),
                                  version: QrVersions.auto,
                                  size: 160.0,
                                  backgroundColor: Colors
                                      .white, // Ustaw białe tło dla QRCode
                                ),
                              )
                            : Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 4,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.black),
                                ),
                              ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 70),
                    child: Text(
                      'Lorem Ipsum',
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
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
