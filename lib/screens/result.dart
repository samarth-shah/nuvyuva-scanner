// ignore_for_file: use_key_in_widget_constructors, prefer_const_declarations, unnecessary_new, avoid_print, prefer_const_constructors, deprecated_member_use

import 'package:barcode_scan_fix/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:nuvyuva_qrscanner/components/excel_reader.dart';

class Results extends StatefulWidget {

  @override
  _ResultsState createState() => _ResultsState();
  String argument;
  Results({
    Key? key,
    required this.argument,
  }) : super(key: key);
}

class _ResultsState extends State<Results> {
  bool flag = false;
  bool isLoading = true;
  ExcelReader excelReader = new ExcelReader();

  List result = [];

  void getNameFromApi() async {
    result = await excelReader.readExcelFile('FInalList.xlsx', widget.argument);
    setState(() {
      isLoading = false;
    });

    if(result[0] == null){
      result = ['Not Alloted',' ${widget.argument}','Not Alloted','Not Alloted'];
    }
  }

  @override
  void initState() {
    super.initState();
    getNameFromApi();
  }

  // DataReceiver dataReceiver = new DataReceiver();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2D172D),
        title: Text(
          'Results',
          style: GoogleFonts.raleway(
              textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          )),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Color(0xFF1D0E1D),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isLoading
                  ? CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Column(children: [
                      Text(
                        '${result[3]}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),Text(
                        '${result[1]}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ]),
              SizedBox(
                height: 30,
              ),
              FlatButton(
                height: 50,
                minWidth: 120,
                color: Colors.green,
                textColor: Colors.white,
                onPressed: () {
                  // dataReceiver.passUcode();
                  // Navigator.of(context).pop();
                  // setState(() {
                  //   flag = false;
                  // });
                },
                child: Text(
                  'Yes',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FlatButton(
                height: 50,
                minWidth: 120,
                color: Colors.redAccent,
                textColor: Colors.white,
                // onPressed: () {
                  onPressed: () async {
                String codeScanner =
                    await BarcodeScanner.scan(); //barcode scanner
                String qrCodeResult = codeScanner;
                print('Sam - ' + qrCodeResult);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Results(argument: qrCodeResult)));
              // },
                  Navigator.of(context).pop();
                  // Navigator.of(context).pushNamed(Otp.routeName);
                  // setState(() {
                  //   flag = false;
                  // });
                },
                child: Text(
                  'Retry',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.argument,
                style: TextStyle(
                  color: Color(0xFF2A112D),
                  fontSize: 6,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}