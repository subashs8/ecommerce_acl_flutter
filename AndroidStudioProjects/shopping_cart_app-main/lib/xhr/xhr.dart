import 'dart:async';
import 'package:http/http.dart' as http;

class XHR {
  static Future<dynamic> call(String method,Uri url,header, body) async{
    dynamic response;
    try{
      switch (method.toUpperCase()) {
        case 'GET':
          response = await http.get(
            url,
            headers: header,
          );
          break;

        case 'POST':
          response = await http.post(
            url,
            body: body,
            headers: header,
          );
          break;

        case 'PUT':
          response = await http.put(
            url,
            body: body,
            headers: header,
          );
          break;
      }

    }catch(exception){
      //response['statusCode'] = 0;
      print(exception);
    }

    dynamic jsonResponse = "";
    if(response.statusCode == 200) {
      jsonResponse = response.body;
    } else if(response.statusCode == 401){
    }
    else{
      jsonResponse = '{"success":false,"message":""}';
    }
    return response;

  }

  add() {}
}
