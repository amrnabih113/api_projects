import 'dart:async';
import 'dart:convert';
import 'package:api_projects/NewsModel.dart';
import 'package:http/http.dart' as http;

class NewsApi {
  List<Articles> datastore = [];

  Future<void> getnews() async {
    Uri url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=c68514bba3e74ddb98cbc3cf9a77e59a");
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      for (var element in jsonData['articles']) {
        if (element['author'] != null &&
            element['urlToImage'] != null &&
            element['content'] != null &&
            element['title'] != null &&
            element['description'] != null) {
          Articles article = Articles(
              author: element['author'],
              title: element['title'],
              description: element['description'],
              urlToImage: element['urlToImage'],
              publishedAt: element['publishedAt'],
              content: element['content']);
          datastore.add(article);
        }
      }
    }
  }
}

class Category {
  List<Articles> datastore = [];

  Future<void> getnews(String category) async {
    Uri url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=eg&category=$category&apiKey=c68514bba3e74ddb98cbc3cf9a77e59a");
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      for (var element in jsonData['articles']) {
        if (element['author'] != null &&
            element['urlToImage'] != null &&
            element['content'] != null &&
            element['title'] != null &&
            element['description'] != null) {
          final Articles article = Articles(
              author: element['author'],
              title: element['title'],
              description: element['description'],
              urlToImage: element['urlToImage'],
              publishedAt: element['publishedAt'],
              content: element['content']);
          datastore.add(article);
        }
      }
    }
  }
}
