import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('user');

Future<void> getProfileData() async {
  // Get docs from collection reference
  QuerySnapshot querySnapshot = await _collectionRef.get();

  // Get data from docs and convert map to List
  final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

  print(allData);
}
