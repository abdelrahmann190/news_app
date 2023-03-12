import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:meta/meta.dart';
import '../../../utils/auth_errors_handling.dart';

import '../../../utils/upload_profile_image.dart';

part 'app_auth_event.dart';
part 'app_auth_state.dart';

class AppAuthBloc extends Bloc<AppAuthEvent, AppAuthState> {
  AppAuthBloc()
      : super(AppAuthStateLoggedOut(
          isLoading: false,
        )) {
    on<AppAuthEventInitialized>(
      (event, emit) async {
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          emit(
            AppAuthStateShowSplashPage(isLoading: false),
          );
          return;
        }
        emit(
          AppAuthStateLoggedIn(
            currentUser: user,
            isLoading: false,
          ),
        );
      },
    );
    on<AppAuthEventGoToRegisterPage>(
      (event, emit) {
        emit(AppAuthStateShowRegisterPage(isLoading: false));
      },
    );

    on<AppAuthEventGoToLogInPage>(
      (event, emit) {
        emit(AppAuthStateShowLogInPage(isLoading: false));
      },
    );

    on<AppAuthEventGoToMainEntryPage>(
      (event, emit) {
        emit(AppAuthStateShowMainEntryPage(isLoading: false));
      },
    );

    on<AppAuthEventRegisterationRequested>((event, emit) async {
      emit(
        AppAuthStateLoggedOut(
          isLoading: true,
        ),
      );
      final String email = event.email;
      final String password = event.password;
      try {
        final credentials =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        emit(
          AppAuthStateShowUserDataEntryPage(
            currentUser: credentials.user!,
            isLoading: false,
          ),
        );
      } on FirebaseAuthException catch (e) {
        emit(
          AppAuthStateShowRegisterPage(
            isLoading: false,
            authError: AuthError.from(e),
          ),
        );
      }
    });

    on<AppAuthEventUploadUserData>(
      (event, emit) async {
        final User user = FirebaseAuth.instance.currentUser!;
        if (user == null) {
          emit(AppAuthStateLoggedOut(isLoading: false));
          return;
        }
        emit(
          AppAuthStateShowUserDataEntryPage(
            currentUser: user,
            isLoading: true,
          ),
        );
        try {
          await postSignUpDetails(
            email: user.email!,
            firstName: event.firstName,
            lastName: event.lastName,
            phoneNumber: event.phoneNumber ?? '',
          );

          emit(
            AppAuthStateLoggedIn(
              currentUser: user,
              isLoading: false,
              profilePic: await _getProfilePicture(
                user.uid,
              ),
            ),
          );
        } catch (e) {
          emit(
            AppAuthStateLoggedIn(currentUser: user, isLoading: false),
          );
        }
      },
    );

    on<AppAuthEventLogInRequested>(
      (event, emit) async {
        emit(
          AppAuthStateLoggedOut(isLoading: true),
        );
        final String email = event.email;
        final String password = event.password;

        try {
          final userCredentials =
              await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password: password,
          );

          emit(
            AppAuthStateLoggedIn(
              currentUser: userCredentials.user!,
              isLoading: false,
              profilePic: await _getProfilePicture(
                userCredentials.user!.uid,
              ),
            ),
          );
        } on FirebaseAuthException catch (e) {
          emit(
            AppAuthStateLoggedOut(
              isLoading: false,
              authError: AuthError.from(e),
            ),
          );
        }
      },
    );

    on<AppAuthEventLogOutRequested>(
      (event, emit) async {
        emit(
          AppAuthStateLoggedOut(isLoading: true),
        );
        await FirebaseAuth.instance.signOut();
        emit(
          AppAuthStateLoggedOut(isLoading: false),
        );
      },
    );

    on<AppAuthEventUploadUserImage>(
      (event, emit) async {
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          emit(
            AppAuthStateLoggedOut(
              isLoading: false,
            ),
          );
          return;
        }
        emit(
          AppAuthStateLoggedIn(currentUser: user, isLoading: true),
        );
        final imageFile = File(event.imageFilePath);
        await uploadProfileImage(
          file: imageFile,
          userId: user.uid,
        );
      },
    );
  }

  Future<Iterable<Reference>> _getProfilePicture(String userId) {
    return FirebaseStorage.instance
        .ref(userId)
        .child('profile-pic')
        .list()
        .then((result) => result.items);
  }

  Future postSignUpDetails({
    required String firstName,
    required String lastName,
    required String email,
    String? phoneNumber,
  }) async {
    await FirebaseFirestore.instance.collection("user").add({
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "phoneNumber": phoneNumber ?? '',
    });
  }
}
