import 'package:bin/services/generate_auth_token.dart';


import 'package:http/http.dart' as http;


class AzureCosmosDB {
  String data;
  Future<String> readData({String userId}) async {
    GenerateAuthToken authToken = GenerateAuthToken();
    Map<String, String> authentication = authToken.createToken();
    print(authentication['authToken']);
    Map<String, String> httpHeader = {
      'Accept': 'application/json',
      'x-ms-version': '2016-07-11',
      'Authorization': authentication['authToken'],
      'x-ms-date': authentication['date'],
      'x-ms-documentdb-partitionkey': '["$userId"]'
    };
    try {
      var response = await http.get(
          'YOUR HOST AND QUERY/$userId',
          headers: httpHeader);
      print(response.statusCode);
      if(response.statusCode ==200){
        return response.body;
      }
      else{
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}


