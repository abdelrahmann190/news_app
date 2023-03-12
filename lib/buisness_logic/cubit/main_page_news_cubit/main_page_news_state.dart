part of 'main_page_news_cubit.dart';

abstract class MainPageNewsState extends Equatable {
  const MainPageNewsState();

  @override
  List<Object> get props => [];
}

class MainPageNewsInitial extends MainPageNewsState {}

class CountryAndCatogeryNewsLoaded extends MainPageNewsState {
  final List<News> countryAndCatogeryNewsLoaded;

  const CountryAndCatogeryNewsLoaded({
    required this.countryAndCatogeryNewsLoaded,
  });
}
