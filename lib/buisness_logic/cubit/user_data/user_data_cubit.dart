import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/firebase_firestore_repositories.dart';

part 'user_data_state.dart';

class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit() : super(UserDataInitial());

  void getUserData() {
    CloudFirestoreRepository().getUserData().then((userDataList) {
      emit(
        UserDataLoaded(userDataList: userDataList),
      );
    });
  }
}
