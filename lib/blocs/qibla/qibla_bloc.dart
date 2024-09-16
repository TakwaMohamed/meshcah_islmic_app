import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:geolocator/geolocator.dart';
import 'package:m3ragapp/blocs/qibla/qibla_event.dart';
import 'package:m3ragapp/blocs/qibla/qibla_state.dart';

import '../../models/qibla_model.dart';

class QiblaBloc extends Bloc<QiblaEvent, QiblaState> {
  QiblaBloc() : super(QiblaInitial()) {
    on<LoadQiblaDirection>(_onLoadQiblaDirection);
    on<UpdateQiblaDirection>(_onUpdateQiblaDirection);
    on<UpdateLocationStatus>(_onUpdateLocationStatus);
  }

  Future<void> _onLoadQiblaDirection(LoadQiblaDirection event, Emitter<QiblaState> emit) async {
    emit(QiblaLoading());
    try {
      final locationStatus = await FlutterQiblah.checkLocationStatus();
      if (locationStatus.status == LocationPermission.always ||
          locationStatus.status == LocationPermission.whileInUse) {
        FlutterQiblah.qiblahStream.listen((qiblahDirection) {
          add(UpdateQiblaDirection(qiblahDirection.direction, qiblahDirection.offset));
        });
        add(UpdateLocationStatus(locationStatus));
      } else {
        emit(QiblaError("Please enable Location service"));
      }
    } catch (e) {
      emit(QiblaError("Error loading Qibla direction: $e"));
    }
  }

  void _onUpdateQiblaDirection(UpdateQiblaDirection event, Emitter<QiblaState> emit) {
    if (state is QiblaLoaded) {
      final currentState = state as QiblaLoaded;
      emit(QiblaLoaded(QiblaDirectionModel(
        direction: event.direction,
        offset: event.offset,
        locationStatus: currentState.model.locationStatus,
      )));
    }
  }

  void _onUpdateLocationStatus(UpdateLocationStatus event, Emitter<QiblaState> emit) {
    if (state is QiblaLoaded) {
      final currentState = state as QiblaLoaded;
      emit(QiblaLoaded(QiblaDirectionModel(
        direction: currentState.model.direction,
        offset: currentState.model.offset,
        locationStatus: event.status,
      )));
    } else {
      emit(QiblaLoaded(QiblaDirectionModel(
        direction: 0,
        offset: 0,
        locationStatus: event.status,
      )));
    }
  }
}