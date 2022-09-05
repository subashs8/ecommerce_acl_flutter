class Endpoints{

  static const String _baseURL = "https://ecommerce-acl-digital.herokuapp.com";
  static const Map<String, String?> _endURL = {
    "login": "users/login",
    "signup": "users/signup",
    "employee": "employee"
  };

  static Map<String,dynamic> buildServiceUrl(String method, String endUrl, {String id = ""}){
    String? myEndUrl = _endURL[endUrl];
    String buildMyUrl = "$_baseURL/$myEndUrl";

    if(id.isNotEmpty) {
      buildMyUrl = "$buildMyUrl/$id";
    }

    return {
      "method": method.toUpperCase(),"url": Uri.parse(Uri.encodeFull(buildMyUrl))
    };
  }


}