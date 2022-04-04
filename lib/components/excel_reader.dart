// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables, unused_import, import_of_legacy_library_into_null_safe
import 'package:excel/excel.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';

class ExcelReader {
  Future<List> readExcelFile(String fileName, String arg) async {
    ByteData data = await rootBundle.load("assets/$fileName");
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);
    String outputFile = "assets/$fileName";

    int flag = 0, rowNo = 0;
    List result = [];
    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) {
        if (row[2] == arg) {
          rowNo = row[0];
          flag = 1;
        }
        if (row[0] == rowNo && flag == 1) {
          result = row;
          row.insert(8, table);
          // print('Samarth - ' + row[8]);
          
          excel.encode().then((onValue) {
            File(join(outputFile))
              ..createSync(recursive: true)
              ..writeAsBytesSync(onValue);
          });
          return result;
        }
      }
    }
    return result;
  }

  Future<bool> enteredPerson(String fileName, String arg) async {
    String outputFile = "assets/$fileName";
    ByteData data = await rootBundle.load("assets/$fileName");
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);
    var rowNo;
    int flag = 0;
    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) {
        if (row[2] == arg) {
          rowNo = row[0];
          flag = 1;
        }
        if (row[0] == rowNo && flag == 1 && row[7] != 'Entered') {
          row.insert(7, 'Entered');
          excel.encode().then((onValue) {
            File(join(outputFile))
              ..createSync(recursive: true)
              ..writeAsBytesSync(onValue);
          });
          return true;
        }
      }
    }
    // File(join('assets/$fileName'))
    // ..createSync(recursive: true)
    // ..writeAsBytesSync(excel.encode()!);

    return false;
  }
}
