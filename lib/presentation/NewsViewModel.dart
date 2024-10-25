import '../Models/NewsCategoryModel.dart';
import '../Models/NewsChannelHeadlinesModel.dart';
import '../NewsRepositories/NewsRepositories.dart';

class NewsViewModel {
  final repo = NewsRepositories();
  Future<NewsChannelHeadlinesModel> fetchNewsChannelHeadlinesAPIs() async {
    final response = await repo.fetchNewsHeadlinesChannel();
    return response;
  }

  Future<NewsCategoryModel> fetchNewsCategoryModel(String category) async {
    final response = await repo.fetchNewsCategory(category);
    return response;
  }

  // Future<List<Articles>> searchNews(String query) async {
  //   String url = "https://newsapi.org/v2/everything?q=$query&apiKey=YOUR_API_KEY";
  //   final response = await http.get(Uri.parse(url));
  //   if (response.statusCode == 200) {
  //     final body = jsonDecode(response.body);
  //     List<Articles> articles = (body['articles'] as List).map((e) => Articles.fromJson(e)).toList();
  //     return articles;
  //   }
  //   throw Exception("Error fetching search results");
  // }
}
