part of 'location_cubit.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {}

class LocationLoaded extends LocationState {
  final String currentLoaction;

  const LocationLoaded({
    required this.currentLoaction,
  });
}
