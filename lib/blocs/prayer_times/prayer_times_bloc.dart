import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:adhan/adhan.dart';
import 'package:m3ragapp/blocs/prayer_times/prayer_times-event.dart';
import 'package:m3ragapp/blocs/prayer_times/prayer_times_state.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../models/prayer_times_model.dart';

class PrayerTimesBloc extends Bloc<PrayerTimesEvent, PrayerTimesState> {
  PrayerTimesBloc() : super(PrayerTimesInitial()) {
    on<LoadPrayerTimes>(_onLoadPrayerTimes);
  }

  Future<void> _onLoadPrayerTimes(LoadPrayerTimes event, Emitter<PrayerTimesState> emit) async {
    emit(PrayerTimesLoading());

    try {
      final status = await Permission.location.status;

      if (status.isGranted) {
        final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        final coordinates = Coordinates(position.latitude, position.longitude);
        final params = CalculationMethod.egyptian.getParameters();
        params.madhab = Madhab.shafi;

        final date = DateComponents.from(DateTime.now());
        final prayerTimes = PrayerTimes(coordinates, date, params);

        final location = '${position.latitude.toStringAsFixed(4)}, ${position.longitude.toStringAsFixed(4)}';

        emit(PrayerTimesLoaded(PrayerTimesModel(prayerTimes: prayerTimes, location: location)));
      } else if (status.isDenied) {
        final result = await Permission.location.request();
        if (result.isGranted) {
          add(LoadPrayerTimes());
        } else {
          emit(PrayerTimesError('الرجاء منح إذن الوصول إلى الموقع'));
        }
      } else {
        emit(PrayerTimesError('الرجاء منح إذن الوصول إلى الموقع'));
      }
    } catch (e) {
      emit(PrayerTimesError('حدث خطأ في تحديد الموقع'));
    }
  }
}