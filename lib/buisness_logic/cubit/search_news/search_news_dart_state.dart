part of 'search_news_dart_cubit.dart';

abstract class SearchNewsState extends Equatable {
  const SearchNewsState();

  @override
  List<Object> get props => [];
}

class SearchNewsDartInitial extends SearchNewsState {}

class SearchNewsLoaded extends SearchNewsState {
  final List<News> searchNewsList;

  const SearchNewsLoaded({
    required this.searchNewsList,
  });
}
