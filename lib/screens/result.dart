// ignore_for_file: use_key_in_widget_constructors, prefer_const_declarations, unnecessary_new, avoid_print, prefer_const_constructors, deprecated_member_use, import_of_legacy_library_into_null_safe

import 'package:barcode_scan_fix/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:nuvyuva_qrscanner/components/excel_reader.dart';

// ignore: must_be_immutable
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
  String fileName = 'FInalList.xlsx';
  ExcelReader excelReader = new ExcelReader();

  List result = [];

  void getNameFromApi() async {
    result = await excelReader.readExcelFile(fileName, widget.argument);
    setState(() {
      isLoading = false;
    });

    if (result[0] == null) {
      result = [
        'Not Alloted',
        ' ${widget.argument}',
        'Not Alloted',
        'Not Alloted'
      ];
    }
  }

  @override
  void initState() {
    super.initState();
    getNameFromApi();
  }

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
                      // SizedBox(
                      //   height: 30,
                      // ),
                      // Text(
                      //   '${result[8]}',
                      //   style: TextStyle(
                      //     color: Colors.white,
                      //     fontSize: 24,
                      //   ),
                      // ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
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
                onPressed: () async {
                  //TODO: add something so that that person come's again so it shows some error
                  bool flag = await excelReader.enteredPerson(
                      fileName, widget.argument);

                  if (flag) {
                    Fluttertoast.showToast(msg: 'Successfully Entered');
                    Navigator.pop(context);
                  }
                  else{
                    Fluttertoast.showToast(msg: 'Already Entered');
                  }
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
                onPressed: () async {
                  String codeScanner = await BarcodeScanner.scan();
                  String qrCodeResult = codeScanner;
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Results(argument: qrCodeResult)));
                  Navigator.of(context).pop();
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
