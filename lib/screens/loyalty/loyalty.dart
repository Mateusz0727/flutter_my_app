import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:http/http.dart' as http;

class QRScreen extends StatefulWidget {
  @override
  _QRScreenState createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  String qrData = '';

  void fetchData() async {
    var response =
        await http.get(Uri.parse('http://172.19.32.1:4002/api/qrCode'));
    if (response.statusCode == 200) {
      setState(() {
        qrData = response.body;
      });
    } else {
      print('Failed to fetch QR data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> _refreshQRData() async {
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Screen'),
      ),
      body: RefreshIndicator(
        color: Colors.white,
        backgroundColor: Colors.blue,
        onRefresh: _refreshQRData,
        child: Stack(
          children: <Widget>[
            ListView(),
            qrData.isNotEmpty
                ? QrImageView(
                    data: qrData,
                    version: QrVersions.auto,
                    size: 200.0,
                  )
                : CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
