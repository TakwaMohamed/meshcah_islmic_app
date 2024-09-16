import '../../models/quran_model.dart';

abstract class SurahState {}

class SurahInitial extends SurahState {}

class SurahLoading extends SurahState {}

class SurahLoaded extends SurahState {
  final List<Ayah> ayahs;

  SurahLoaded(this.ayahs);
}

class SurahError extends SurahState {
  final String message;

  SurahError(this.message);
}