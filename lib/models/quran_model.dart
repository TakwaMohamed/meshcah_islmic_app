class Surah {
  final int number;
  final String name;
  final int numberOfAyahs;

  Surah({required this.number, required this.name, required this.numberOfAyahs});

  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
      number: json['number'],
      name: json['name'],
      numberOfAyahs: json['numberOfAyahs'],
    );
  }
}

class Ayah {
  final String text;
  final int numberInSurah;

  Ayah({required this.text, required this.numberInSurah});

  factory Ayah.fromJson(Map<String, dynamic> json) {
    return Ayah(
      text: json['text'],
      numberInSurah: json['numberInSurah'],
    );
  }
}