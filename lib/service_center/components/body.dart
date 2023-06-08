import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  whatsapp() async {
    var contact = "+6289699603965";
    var androidUrl =
        "whatsapp://send?phone=$contact&text=Hi admin, Saya membutuhkan bantuan tentang aplikasi Dapur Tiyer";
    var iosUrl =
        "https://wa.me/$contact?text=${Uri.parse('Hi admin, Saya membutuhkan bantuan tentang aplikasi Dapur Tiyer')}";

    try {
      await launchUrl(Uri.parse(androidUrl));
    } on Exception {
      print('WhatsApp tidak terinstall.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(60),
              child: Row(
                children: [
                  /*GestureDetector(
                    onTap: () {
                      // Handle back button click
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Image.asset(
                        'assets/ic_baseline_arrow_back_24.png',
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                  Text(
                    'Support Center',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),*/
                ],
              ),
            ),
            SizedBox(height: 15),
            Text(
              'WhatsApp',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'Hella (Admin)',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text('\n +62 896-9960-3965'),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(30),
              child: ElevatedButton(
                onPressed: () {
                  whatsapp();
                  // Implementasi logika tombol simpan
                },
                child: Text('Hubungi admin'),
                style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 18),
                    textStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
