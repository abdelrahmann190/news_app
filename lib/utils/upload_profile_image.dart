import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

Future<bool> uploadProfileImage({
  required File file,
  required String userId,
}) {
  return FirebaseStorage.instance
      .ref(userId)
      .child('profile-pic')
      .child(const Uuid().v4())
      .putFile(file)
      .then((_) => true)
      .catchError((_) => false);
}
