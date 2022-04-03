// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables, unused_import, import_of_legacy_library_into_null_safe
import 'package:excel/excel.dart';
import 'package:flutter/services.dart';

class ExcelReader {
  Future<List> readExcelFile(String fileName, String arg) async {
    ByteData data = await rootBundle.load("assets/$fileName");
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);
    var rowNo;
    int flag = 0;
    List result = [];
    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) {
        if (row[2] == arg) {
          rowNo = row[0];
          flag = 1;
        }
        if (row[0] == rowNo && flag == 1) {
          result = row;
          return result;
        }
      }
    }
    return result;
  }
}
