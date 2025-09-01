import 'dart:convert';

import 'package:api_projects/Api_dictionary/DictionaryModel.dart';
import 'package:http/http.dart' as http;

class Apiservices {
  static String baseurl = "https://api.dictionaryapi.dev/api/v2/entries/en/";
  static Future<DictionaryModel?> getdata(String word) async {
    Uri url = Uri.parse("$baseurl$word");
    var responce = await http.get(url);
    var json = jsonDecode(responce.body);
    try {
      if (responce.statusCode == 200) {
        return DictionaryModel.fromJson(json[0]);
      } else {
        throw Exception("Falied to git the meaning ");
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
