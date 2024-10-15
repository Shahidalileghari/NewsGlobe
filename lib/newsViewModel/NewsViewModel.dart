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
}
