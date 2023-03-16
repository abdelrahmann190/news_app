import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../data/models/news_model.dart';
import '../../../data/repositories/firebase_firestore_repositories.dart';
import '../../../data/web_services/cloud_firestore_web_services.dart';

part 'bookmarks_state.dart';

class BookmarksCubit extends Cubit<BookmarksState> {
  BookmarksCubit() : super(BookmarksInitial());

  void getNewsBookMark() {
    emit(BookmarksInitial());
    CloudFirestoreRepository().getNewsBookMark().then((bookMarks) {
      emit(
        BookmarksLoaded(bookMarkedNews: bookMarks),
      );
    });
  }

  void deleteBookmark({
    required String id,
  }) async {
    User? _currentUser = FirebaseAuth.instance.currentUser;
    if (_currentUser == null) {
      return;
    }
    await FirebaseFirestore.instance
        .collection(_currentUser.uid)
        .doc(id)
        .delete();
    getNewsBookMark();
  }

  void checkIfNewsBookmarked({
    required String id,
  }) async {
    emit(BookmarksInitial());
    User? _currentUser = FirebaseAuth.instance.currentUser;
    if (_currentUser == null) {
      return;
    }
    final QuerySnapshot validateWithNewsId = await FirebaseFirestore.instance
        .collection(_currentUser.uid)
        .where('id', isEqualTo: id)
        .get();
    if (validateWithNewsId.docs.isNotEmpty) {
      emit(
        NewsBookmarked(),
      );
    } else {
      emit(
        BookmarksInitial(),
      );
    }
  }

  void postNewsBookMark({
    required String authorName,
    required String newsTitle,
    required String newsDescribtion,
    required String publishedAt,
    required String url,
    required String imageUrl,
    required String language,
    required String category,
    required String id,
    required String videoUrl,
  }) async {
    User? _currentUser = FirebaseAuth.instance.currentUser;
    if (_currentUser == null) {
      return;
    }
    final QuerySnapshot validateWithNewsId = await FirebaseFirestore.instance
        .collection(_currentUser.uid)
        .where('id', isEqualTo: id)
        .get();
    if (validateWithNewsId.docs.isEmpty) {
      CloudFirestoreWebServices().postNewsBookMark(
        authorName: authorName,
        newsTitle: newsTitle,
        newsDescribtion: newsDescribtion,
        publishedAt: publishedAt,
        url: url,
        imageUrl: imageUrl,
        language: language,
        category: category,
        id: id,
        videoUrl: videoUrl,
      );
    } else {
      emit(NewsBookmarked());
    }
  }
}
