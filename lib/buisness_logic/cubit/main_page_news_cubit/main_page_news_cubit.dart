import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/news_model.dart';
import '../../../data/repositories/news_api_repository.dart';
import '../../../data/web_services/news_api_web_services.dart';

part 'main_page_news_state.dart';

class MainPageNewsCubit extends Cubit<MainPageNewsState> {
  List<News> countryAndCatogeryNewsLoaded = [];

  MainPageNewsCubit() : super(MainPageNewsInitial());

  List<News> getNewsWithCountryCodeAndCategory({
    required String newsCategory,
    required String countryCode,
  }) {
    emit(MainPageNewsInitial());
    NewsAPIRepository(
      newsAPIWebServices: NewsAPIWebServices(),
    )
        .getNewsWithCountryCodeAndCategory(
            newsCategory: newsCategory, countryCode: countryCode)
        .then((news) {
      emit(
        CountryAndCatogeryNewsLoaded(
          countryAndCatogeryNewsLoaded: news,
        ),
      );
      countryAndCatogeryNewsLoaded = news;
    });
    return countryAndCatogeryNewsLoaded;
  }
}
