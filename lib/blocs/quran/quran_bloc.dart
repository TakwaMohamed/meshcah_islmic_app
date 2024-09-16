import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:m3ragapp/blocs/quran/quran_event.dart';
import 'package:m3ragapp/blocs/quran/quran_state.dart';

import '../../models/quran_model.dart';

class QuranBloc extends Bloc<QuranEvent, QuranState> {
  QuranBloc() : super(QuranInitial()) {
    on<FetchSurahs>(_onFetchSurahs);
  }

  Future<void> _onFetchSurahs(FetchSurahs event, Emitter<QuranState> emit) async {
    emit(QuranLoading());
    try {
      final response = await http.get(Uri.parse('http://api.alquran.cloud/v1/surah'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<Surah> surahs = (data['data'] as List)
            .map((surahJson) => Surah.fromJson(surahJson))
            .toList();
        emit(QuranLoaded(surahs));
      } else {
        emit(QuranError('Failed to load surahs'));
      }
    } catch (e) {
      emit(QuranError('An error occurred: $e'));
    }
  }
}