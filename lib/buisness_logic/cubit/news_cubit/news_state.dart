part of 'news_cubit.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class NewsInitial extends NewsState {}

class TopNewsArticlesLoaded extends NewsState {
  final List<News> topNewsArticles;

  const TopNewsArticlesLoaded({
    required this.topNewsArticles,
  });
}
