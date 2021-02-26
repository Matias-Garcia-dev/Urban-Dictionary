import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/define_term_response.dart';
import 'package:my_app/term.dart';

class NetworkingService {
  Future<List<Term>> defineTerm(String searchTerm) async {


    final queryParameters = {'term': searchTerm};

    final uri = Uri.https('mashape-community-urban-dictionary.p.rapidapi.com','define',queryParameters);

    final headers = {
      "x-rapidapi-key": "f1510f47bbmsh653c9cc43af2185p1ca1bejsn1b7745a5be4c",
      "x-rapidapi-host": "mashape-community-urban-dictionary.p.rapidapi.com"
    };
    final response = await http.get(uri,headers: headers);

    if (response.statusCode == 200){
      final decodedBody = jsonDecode(response.body);
      final defineTermsResponse = DefineTermResponse.fromJson(decodedBody);
      return defineTermsResponse.list;

    }else{
      throw Exception('Failed to define term');
    }
  }
}