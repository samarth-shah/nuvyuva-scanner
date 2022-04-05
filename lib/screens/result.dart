// ignore_for_file: use_key_in_widget_constructors, prefer_const_declarations, unnecessary_new, avoid_print, prefer_const_constructors, deprecated_member_use, import_of_legacy_library_into_null_safe

import 'package:barcode_scan_fix/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nuvyuva_qrscanner/components/details.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:nuvyuva_qrscanner/components/excel_reader.dart';

import '../model/get_user_details_exchange.dart';

// ignore: must_be_immutable
class Results extends StatefulWidget {
  @override
  _ResultsState createState() => _ResultsState();
  String uuid;
  Results({
    Key? key,
    required this.uuid,
  }) : super(key: key);
}

class _ResultsState extends State<Results> {
  bool flag = false;
  bool isLoading = true;
  ExcelReader excelReader = new ExcelReader();
  Details result = Details(name: 'null', namespace: 'null', type: 'null', repeat: false);

  void getNameFromApi() async {
    // result = await excelReader.readExcelFile(fileName, widget.argument);
    result = await UserDetailsExchange().getUser(widget.uuid);
    setState(() {
      isLoading = false;
    });
    print('Sam - '+result.toString());

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
          // style: GoogleFonts.raleway(
          //     textStyle: TextStyle(
          //   fontWeight: FontWeight.bold,
          //   fontSize: 24,
          // )),
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
                        '${result.name}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        '${result.namespace}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        '${result.type}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
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
                disabledColor: Colors.grey,
                onPressed: result.repeat
                    ? null
                    : () async {
                        Fluttertoast.showToast(msg: 'Successfully Entered');
                        Navigator.pop(context);
                      },
                child: Text(
                  !result.repeat ? 'Yes' : 'Already Entered',
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
                  // String codeScanner = await BarcodeScanner.scan();
                  // String qrCodeResult = codeScanner;
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => Results(uuid: qrCodeResult)));
                  Navigator.of(context).pop();
                },
                child: Text(
                  'No',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              // SizedBox(
              //   height: 10,
              // ),
              // Text(
              //   widget.uuid,
              //   style: TextStyle(
              //     color: Color(0xFF2A112D),
              //     fontSize: 6,
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
