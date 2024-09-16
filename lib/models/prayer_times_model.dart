import 'package:adhan/adhan.dart';

class PrayerTimesModel {
  final PrayerTimes prayerTimes;
  final String location;

  PrayerTimesModel({required this.prayerTimes, required this.location});

  factory PrayerTimesModel.empty() {
    return PrayerTimesModel(
      prayerTimes: PrayerTimes(Coordinates(0, 0), DateComponents.from(DateTime.now()), CalculationMethod.egyptian.getParameters()),
      location: 'Unknown',
    );
  }
}