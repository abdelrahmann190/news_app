import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../utils/strings.dart';

part 'location_state.dart';

String _location = '';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit()
      : super(_location.isEmpty
            ? LocationInitial()
            : LocationLoaded(
                currentLoaction: _location,
              ));
  void getCurrentLocation(String location) {
    emit(LocationInitial());
    _location = location;
    countryCode = location;
    emit(
      LocationLoaded(
        currentLoaction: location,
      ),
    );
  }
}
