part of 'user_data_cubit.dart';

abstract class UserDataState extends Equatable {
  const UserDataState();

  @override
  List<Object> get props => [];
}

class UserDataInitial extends UserDataState {}

class UserDataLoaded extends UserDataState {
  final List<UserModel> userDataList;

  const UserDataLoaded({required this.userDataList});
}
