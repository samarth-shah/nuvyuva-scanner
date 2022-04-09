import 'package:nuvyuva_qrscanner/components/details.dart';
import 'package:dio/dio.dart';

class UserDetailsExchange {
  var dio = Dio();
  @override
  Future getUser(String uuid) async {
    var url = Uri.parse(
        'http://nuvyuvafullproduction-env.eba-4hxpmamt.us-east-1.elasticbeanstalk.com/GetData_from_uuid');
        print('UUID : '+ uuid);

    final queryParameters = {
      'uuid': uuid.trim(),
    };

    final response = await Dio().post(
      url.toString(),
      queryParameters: queryParameters,
    );
    print('Response Code: ${response.statusCode}');
    print('Response Data: ${response.data}');
    print('Response body: $response');

    return Details.fromMap(response.data);
  }
}
