import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../web_services/cloud_firestore_web_services.dart';

import '../models/news_model.dart';

class CloudFirestoreRepository {
  Future getNewsBookMark() async {
    final QuerySnapshot data =
        await CloudFirestoreWebServices().getNewsBookMark();
    // print(data.docs
    //     .map((document) => News.fromSnapshot(document))
    //     .toList()[0]
    //     .creator);
    return data.docs.map((document) => News.fromSnapshot(document)).toList();
  }

  Future getUserData() async {
    final List userData = await CloudFirestoreWebServices().getUserData();
    return userData.map((doc) => UserModel.fromSnapshot(doc)).toList();
  }
}
