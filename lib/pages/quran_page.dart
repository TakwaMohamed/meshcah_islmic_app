import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../blocs/quran/quran_bloc.dart';
import '../blocs/quran/quran_event.dart';
import '../blocs/quran/quran_state.dart';
import '../models/quran_model.dart';
import 'surah_page.dart';

class QuranPage extends StatelessWidget {
  const QuranPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuranBloc()..add(FetchSurahs()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('القرآن الكريم',
              style: GoogleFonts.cairo(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.deepPurple,
        ),
        body: BlocBuilder<QuranBloc, QuranState>(
          builder: (context, state) {
            if (state is QuranLoading) {
              return const Center(child: CircularProgressIndicator(color: Colors.deepPurple));
            } else if (state is QuranLoaded) {
              return _buildSurahList(context, state.surahs);
            } else if (state is QuranError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return const Center(child: Text('Unknown state'));
          },
        ),
      ),
    );
  }

  Widget _buildSurahList(BuildContext context, List<Surah> surahs) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.deepPurple.shade100, Colors.white],
        ),
      ),
      child: ListView.builder(
        itemCount: surahs.length,
        itemBuilder: (context, index) {
          final surah = surahs[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              title: Text(
                surah.name,
                textDirection: TextDirection.rtl,
                style: GoogleFonts.cairo(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              subtitle: Text(
                'عدد الآيات: ${surah.numberOfAyahs}',
                style: GoogleFonts.cairo(color: Colors.grey[600]),
              ),
              leading: CircleAvatar(
                backgroundColor: Colors.amber,
                child: Text(
                  '${surah.number}',
                  style: const TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SurahPage(
                      surahNumber: surah.number,
                      surahName: surah.name,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}