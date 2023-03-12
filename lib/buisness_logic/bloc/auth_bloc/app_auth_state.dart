// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'app_auth_bloc.dart';

abstract class AppAuthState {
  final bool isLoading;
  AuthError? authError;

  AppAuthState({
    this.authError,
    required this.isLoading,
  });
}

class AppAuthStateShowSplashPage extends AppAuthState {
  AppAuthStateShowSplashPage({
    AuthError? authError,
    required bool isLoading,
  }) : super(
          isLoading: isLoading,
          authError: authError,
        );
}

class AppAuthStateShowRegisterPage extends AppAuthState {
  AppAuthStateShowRegisterPage({
    AuthError? authError,
    required bool isLoading,
  }) : super(
          isLoading: isLoading,
          authError: authError,
        );
}

class AppAuthStateShowLogInPage extends AppAuthState {
  AppAuthStateShowLogInPage({
    AuthError? authError,
    required bool isLoading,
  }) : super(
          isLoading: isLoading,
          authError: authError,
        );
}

class AppAuthStateShowMainEntryPage extends AppAuthState {
  AppAuthStateShowMainEntryPage({
    AuthError? authError,
    required bool isLoading,
  }) : super(
          isLoading: isLoading,
          authError: authError,
        );
}

class AppAuthStateShowUserDataEntryPage extends AppAuthState {
  final User currentUser;
  AppAuthStateShowUserDataEntryPage({
    AuthError? authError,
    required bool isLoading,
    required this.currentUser,
  }) : super(
          isLoading: isLoading,
          authError: authError,
        );
}

class AppAuthStateLoggedIn extends AppAuthState {
  final User currentUser;
  Iterable<Reference>? profilePic;
  AppAuthStateLoggedIn({
    required this.currentUser,
    AuthError? authError,
    required bool isLoading,
    this.profilePic,
  }) : super(
          isLoading: isLoading,
          authError: authError,
        );
}

class AppAuthStateLoggedOut extends AppAuthState {
  AppAuthStateLoggedOut({
    AuthError? authError,
    required bool isLoading,
  }) : super(
          isLoading: isLoading,
          authError: authError,
        );
}

extension CurrentUser on AppAuthState {
  get currentUser {
    final cls = this;
    if (cls is AppAuthStateLoggedIn) {
      return cls.currentUser;
    } else {
      return null;
    }
  }
}
