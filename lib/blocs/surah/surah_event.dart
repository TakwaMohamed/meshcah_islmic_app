abstract class SurahEvent {}

class FetchAyahs extends SurahEvent {
  final int surahNumber;

  FetchAyahs(this.surahNumber);
}