import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Models/NewsCategoryModel.dart';
import '../Models/NewsChannelHeadlinesModel.dart';

class NewsRepositories {
  Future<NewsChannelHeadlinesModel> fetchNewsHeadlinesChannel() async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=6ff6f3247921425a903a334bb666678b";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelHeadlinesModel.fromJson(body);
    }

    throw Exception("Error");
  }

  Future<NewsCategoryModel> fetchNewsCategory(String category) async {
    String url =
        "https://newsapi.org/v2/everything?q=$category&apiKey=6ff6f3247921425a903a334bb666678b";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsCategoryModel.fromJson(body);
    }

    throw Exception("Error");
  }
}
