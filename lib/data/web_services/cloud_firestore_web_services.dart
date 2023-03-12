import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CloudFirestoreWebServices {
  Future postNewsBookMark({
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
    await FirebaseFirestore.instance.collection(_currentUser.uid).doc(id).set({
      'id': id,
      "creator": authorName,
      "title": newsTitle,
      "description": newsDescribtion,
      'content': '',
      "pubDate": publishedAt,
      'url': url,
      'image_url': imageUrl,
      'language': language,
      'category': category,
      'video_url': videoUrl,
    });
  }

  Future getNewsBookMark() async {
    User? _currentUser = FirebaseAuth.instance.currentUser;
    if (_currentUser == null) {
      return;
    }
    final document = await FirebaseFirestore.instance
        .collection(_currentUser.uid)
        .where('field')
        .get();
    if (document == null) {
      return;
    }
    return document;
  }

  Future getUserData() async {
    User? _currentUser = FirebaseAuth.instance.currentUser;
    if (_currentUser == null) {
      return;
    }
    final userData = await FirebaseFirestore.instance
        .collection('user')
        .where('email', isEqualTo: _currentUser.email!)
        .get();
    return userData.docs;
  }
}
