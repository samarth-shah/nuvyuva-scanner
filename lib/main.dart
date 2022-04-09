// ignore_for_file: must_be_immutable, prefer_const_constructors, deprecated_member_use, use_key_in_widget_constructors, duplicate_ignore, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'screens/result.dart';
import 'package:barcode_scan_fix/barcode_scan.dart';
// import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nuv Yuva 2022',
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   primarySwatch: Colors.deepPurple,
      // ).copyWith(textTheme: GoogleFonts.quicksandTextTheme()),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  String qrCodeResult = " ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFef3c49),
        title: Text(
          'NUV YUVA 💜',
        ),
        centerTitle: true,
      ),
      backgroundColor: Color.fromARGB(255, 90, 175, 225),
      body: Container(
        padding: const EdgeInsets.all(50),
        // decoration: BoxDecoration(
        // color: Color(0x69349C),
        // image: DecorationImage(
        //   image: AssetImage('assets/images/freshersPoster.png'),
        //   fit: BoxFit.cover,
        // ),
        // ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(35),
              decoration: BoxDecoration(
                // color: Color(0xff69349C),
                image: DecorationImage(
                  image: AssetImage('assets/navrachana_logo.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              padding: const EdgeInsets.all(100),
              decoration: BoxDecoration(
                // color: Color(0xff69349C),
                image: DecorationImage(
                  image: AssetImage('assets/nuv_yuva_logo.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Text(
              " NUV YUVA 2022",
              style: TextStyle(color: Colors.white, fontSize: 35),
            ),
            SizedBox(
              height: 70,
            ),
            FlatButton(
              //height: 180,
              color: Color(0xFFef3c49),
              padding: EdgeInsets.all(15),
              onPressed: () async {
                String codeScanner =
                    await BarcodeScanner.scan(); //barcode scanner
                qrCodeResult = codeScanner;
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Results(uuid: qrCodeResult)));
              },
              child: Text(
                "Scan QR Code",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            SizedBox(
              height: 65,
            ),
          ],
        ),
      ),
    );
  }
}
