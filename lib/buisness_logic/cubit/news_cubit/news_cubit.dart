import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/news_model.dart';
import '../../../data/repositories/news_api_repository.dart';
import '../../../data/web_services/news_api_web_services.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  List<News> topNewsArticles = [];

  NewsCubit() : super(NewsInitial());

  List<News> getTopNewsArticles({
    required String countryCode,
  }) {
    emit(
      NewsInitial(),
    );
    NewsAPIRepository(newsAPIWebServices: NewsAPIWebServices())
        .getTopHeadLineNews(
      countryCode: countryCode,
    )
        .then((news) {
      emit(
        TopNewsArticlesLoaded(topNewsArticles: news),
      );
      topNewsArticles = news;
    });
    return topNewsArticles;
  }
}
