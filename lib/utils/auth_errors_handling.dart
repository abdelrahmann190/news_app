import 'package:firebase_core/firebase_core.dart';

Map<String, AuthError> firebaseErrorsMap = {
  'operation-not-allowed': AuthErrorOperationNotAllowed(),
  'user-not-found': AuthErrorUserNotFound(),
  'email-already-in-use': AuthErrorEmailAlreadyExists(),
  'invalid-password': AuthErrorWeakPassword(),
  'invalid-user-import': AuthErrorNoCurrentUser(),
  'requires-recent-login': AuthErrorRequiresRecentLogin(),
};

abstract class AuthError {
  final String errorHeader;
  final String errorDescription;

  AuthError({
    required this.errorHeader,
    required this.errorDescription,
  });

  factory AuthError.from(FirebaseException exception) {
    print("The error is : ${exception.code}");
    return firebaseErrorsMap[exception.code.toLowerCase().trim()] ??
        AuthErrorUnknown();
  }
}

class AuthErrorUnknown extends AuthError {
  AuthErrorUnknown({
    String errorHeader = 'Auth Error Unknown',
    String errorDescription =
        'An unknown error just happened please try again later',
  }) : super(
          errorHeader: errorHeader,
          errorDescription: errorDescription,
        );
}

class AuthErrorNoCurrentUser extends AuthError {
  AuthErrorNoCurrentUser()
      : super(
            errorHeader: "No Current User",
            errorDescription:
                'No current user with this information was found');
}

class AuthErrorRequiresRecentLogin extends AuthError {
  AuthErrorRequiresRecentLogin()
      : super(
            errorHeader: "Requires Recent Login",
            errorDescription:
                'You need to logout and login again to perform this operation');
}

class AuthErrorEmailAlreadyExists extends AuthError {
  AuthErrorEmailAlreadyExists()
      : super(
            errorHeader: "Email Already Exists",
            errorDescription:
                'The provided email is already in use by an existing user. Each user must have a unique email.');
}

class AuthErrorOperationNotAllowed extends AuthError {
  AuthErrorOperationNotAllowed()
      : super(
            errorHeader: "Operation not allowed",
            errorDescription:
                'You cannot register using this method this time.');
}

class AuthErrorUserNotFound extends AuthError {
  AuthErrorUserNotFound()
      : super(
          errorHeader: "User not found",
          errorDescription:
              'You cannot login using this email because it does not exist on the server.',
        );
}

class AuthErrorWeakPassword extends AuthError {
  AuthErrorWeakPassword()
      : super(
          errorHeader: 'Weak Passwrod',
          errorDescription:
              'The provided value for the password user property is invalid. It must be a string with at least six characters.',
        );
}

class AuthErrorWrongEmailFormat extends AuthError {
  AuthErrorWrongEmailFormat()
      : super(
            errorHeader: 'Invalid Email Format',
            errorDescription:
                'The provided value for the email user property is invalid. It must be a string email address.');
}
