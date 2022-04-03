// ignore_for_file: file_names, prefer_typing_uninitialized_variables, unused_field, unnecessary_string_interpolations, avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

class DataReceiver {
  String url = 'https://belly-bolly.herokuapp.com';
  var decodedData;
  String _name = '';
  var _number = '';
  var _uCode = '';
  var _jwtCode = '';

  void getJwtCode(var code) {
    _jwtCode = code;
  }

  Future<http.Response> getName() async {
    String userName = '';
    var num = '';
    var uCode = '';

    final response = await http.post(
      Uri.parse('https://belly-bolly.herokuapp.com/checkQREncode'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'jwtToken': '$_jwtCode',
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
      decodedData = jsonDecode(response.body);
      userName = decodedData['Name'];
      num = decodedData['Contact'];
      uCode = decodedData['U_Code'];
    }
    _name = userName;
    _number = num;
    _uCode = uCode;
    return response;
  }

  // void printDetails() {
  //   print(getName());
  // }

  // Future<String> passName() async {
  //   await getName();
  //   return _name;
  // }

  // Future<String> passNumber() async {
  //   await getName();
  //   return _number;
  // }

  // Future<String> passUCode() async {
  //   await getName();
  //   return _uCode;
  // }

  Future<http.Response> passUcode() async {
    print('Ucode : $_uCode');
    final response = await http.post(
      Uri.parse('https://belly-bolly.herokuapp.com/checkin'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'U_Code': '$_uCode',
        'checkin': 'TRUE',
      }),
    );
    return response;
  }
}
