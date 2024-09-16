import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../blocs/surah/surah_bloc.dart';
import '../blocs/surah/surah_event.dart';
import '../blocs/surah/surah_state.dart';
import '../models/quran_model.dart';


class SurahPage extends StatelessWidget {
  final int surahNumber;
  final String surahName;

  const SurahPage({Key? key, required this.surahNumber, required this.surahName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SurahBloc()..add(FetchAyahs(surahNumber)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(surahName,
              style: GoogleFonts.cairo(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.deepPurple,
        ),
        body: BlocBuilder<SurahBloc, SurahState>(
          builder: (context, state) {
            if (state is SurahLoading) {
              return const Center(child: CircularProgressIndicator(color: Colors.deepPurple));
            } else if (state is SurahLoaded) {
              return _buildAyahList(context, state.ayahs);
            } else if (state is SurahError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return const Center(child: Text('Unknown state'));
          },
        ),
      ),
    );
  }

  Widget _buildAyahList(BuildContext context, List<Ayah> ayahs) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.deepPurple.shade100, Colors.white],
        ),
      ),
      child: ListView.builder(
        itemCount: ayahs.length,
        itemBuilder: (context, index) {
          final ayah = ayahs[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(
                ayah.text,
                textDirection: TextDirection.rtl,
                style: GoogleFonts.amiri(fontSize: 20, color: Colors.deepPurple[700]),
              ),
              leading: CircleAvatar(
                backgroundColor: Colors.amber,
                child: Text(
                  ayah.numberInSurah.toString(),
                  style: const TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}