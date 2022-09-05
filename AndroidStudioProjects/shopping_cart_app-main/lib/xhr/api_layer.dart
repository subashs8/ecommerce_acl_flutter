import 'dart:convert';
import 'package:shopping_cart_app/xhr/xhr.dart';

class APIInterface {
  static Future<String> call(
      String method, Uri url, Map<String, String> headers, body) async {
    String jsonResponse = "{}";
    Map bodyMap = {};
    if (method.toLowerCase() != "get" && body != null) {
      bodyMap = (json.decode(body) as Map);
    }

    try {
      headers['Content-Type'] = "application/json";
      headers['Accept'] = "application/json, text/plain, */*";

      headers['Cache-Control'] = "no-cache";
      headers['Connection'] = "keep-alive";

      // add token if needed
      var token = "";
      headers['Authorization'] = "Bearer ${token}";

      await XHR
          .call(method, url, headers, json.encode(bodyMap))
          .then((dynamic response) async {
        if (response != null && response.statusCode == 200) {
          jsonResponse = response.body;
        } else if (response != null && response.statusCode == 400) {
          jsonResponse = response.body;
        } else {
          jsonResponse = '{"success":false,"message":"Something Went Wrong"}';
        }
      });
    } catch (exception) {
      print("");
    }

    return jsonResponse;
  }
}
