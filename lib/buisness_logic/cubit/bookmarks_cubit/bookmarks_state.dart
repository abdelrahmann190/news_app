// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'bookmarks_cubit.dart';

abstract class BookmarksState extends Equatable {
  const BookmarksState();

  @override
  List<Object> get props => [];
}

class BookmarksInitial extends BookmarksState {}

class BookmarksLoaded extends BookmarksState {
  List<News> bookMarkedNews = [];
  BookmarksLoaded({
    required this.bookMarkedNews,
  });
}

class NewsBookmarked extends BookmarksState {}
