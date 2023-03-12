class UserModel {
  late String email;
  late String firstName;
  late String lastName;
  late String phoneNumber;

  UserModel.fromSnapshot(dynamic doc) {
    email = doc['email'];
    firstName = doc['firstName'];
    lastName = doc['lastName'];
    phoneNumber = doc['phoneNumber'];
  }
}
