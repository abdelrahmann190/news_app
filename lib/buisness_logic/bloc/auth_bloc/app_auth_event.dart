// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'app_auth_bloc.dart';

@immutable
abstract class AppAuthEvent {}

class AppAuthEventInitialized extends AppAuthEvent {}

class AppAuthEventLogInRequested extends AppAuthEvent {
  final String email;
  final String password;

  AppAuthEventLogInRequested({
    required this.email,
    required this.password,
  });
}

class AppAuthEventRegisterationRequested extends AppAuthEvent {
  final String email;
  final String password;

  AppAuthEventRegisterationRequested({
    required this.email,
    required this.password,
  });
}

class AppAuthEventGoToMainEntryPage extends AppAuthEvent {
  AppAuthEventGoToMainEntryPage();
}

class AppAuthEventGoToLogInPage extends AppAuthEvent {
  AppAuthEventGoToLogInPage();
}

class AppAuthEventGoToUserDataEntryPage extends AppAuthEvent {
  AppAuthEventGoToUserDataEntryPage();
}

class AppAuthEventGoToRegisterPage extends AppAuthEvent {
  AppAuthEventGoToRegisterPage();
}

class AppAuthEventLogOutRequested extends AppAuthEvent {
  AppAuthEventLogOutRequested();
}

class AppAuthEventUploadUserImage extends AppAuthEvent {
  final String imageFilePath;
  AppAuthEventUploadUserImage({
    required this.imageFilePath,
  });
}

class AppAuthEventUploadUserData extends AppAuthEvent {
  final String firstName;
  final String lastName;
  String? phoneNumber;

  AppAuthEventUploadUserData({
    required this.firstName,
    required this.lastName,
    this.phoneNumber,
  });
}
