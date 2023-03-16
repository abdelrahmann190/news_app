import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/news_model.dart';
import '../../../data/web_services/news_api_web_services.dart';

import '../../../data/repositories/news_api_repository.dart';

part 'search_news_dart_state.dart';

class SearchNewsCubit extends Cubit<SearchNewsState> {
  SearchNewsCubit() : super(SearchNewsDartInitial());

  void getNewsWithSearchKeyword({
    required String searchKeyword,
  }) {
    emit(
      SearchNewsDartInitial(),
    );
    NewsAPIRepository(newsAPIWebServices: NewsAPIWebServices())
        .getNewsWithSearchKeyword(searchKeyword: searchKeyword)
        .then((newsList) {
      emit(SearchNewsLoaded(searchNewsList: newsList));
    });
  }
}
