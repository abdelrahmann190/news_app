import '../models/news_model.dart';
import '../web_services/news_api_web_services.dart';

class NewsAPIRepository {
  final NewsAPIWebServices newsAPIWebServices;

  NewsAPIRepository({
    required this.newsAPIWebServices,
  });

  Future getTopHeadLineNews({required String countryCode}) async {
    final List newsList = await newsAPIWebServices.getTopHeadLineNews(
      countryCode: countryCode,
    );

    return newsList
        .map(
          (newsList) => News.fromJson(newsList),
        )
        .toList();
  }

  Future getNewsWithSearchKeyword({
    required searchKeyword,
  }) async {
    final List newsList = await newsAPIWebServices.getNewsWithSearchKeyword(
        searchKeyword: searchKeyword);
    print(newsList.map((news) => News.fromJson(news)).toList());
    return newsList.map((news) => News.fromJson(news)).toList();
  }

  Future getNewsWithCountryCodeAndCategory({
    required String newsCategory,
    required String countryCode,
  }) async {
    final List newsList =
        await newsAPIWebServices.getNewsWithCountryCodeAndCategory(
      newsCategory: newsCategory,
      countryCode: countryCode,
    );

    return newsList
        .map(
          (newsJson) => News.fromJson(newsJson),
        )
        .toList();
  }
}
