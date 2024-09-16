import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:m3ragapp/blocs/surah/surah_event.dart';
import 'package:m3ragapp/blocs/surah/surah_state.dart';

import '../../models/quran_model.dart';

class SurahBloc extends Bloc<SurahEvent, SurahState> {
  SurahBloc() : super(SurahInitial()) {
    on<FetchAyahs>(_onFetchAyahs);
  }

  Future<void> _onFetchAyahs(FetchAyahs event, Emitter<SurahState> emit) async {
    emit(SurahLoading());
    try {
      final response = await http.get(Uri.parse('http://api.alquran.cloud/v1/surah/${event.surahNumber}'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<Ayah> ayahs = (data['data']['ayahs'] as List)
            .map((ayahJson) => Ayah.fromJson(ayahJson))
            .toList();
        emit(SurahLoaded(ayahs));
      } else {
        emit(SurahError('Failed to load ayahs'));
      }
    } catch (e) {
      emit(SurahError('An error occurred: $e'));
    }
  }
}