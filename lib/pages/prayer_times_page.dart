import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../blocs/prayer_times/prayer_times-event.dart';
import '../blocs/prayer_times/prayer_times_bloc.dart';
import '../blocs/prayer_times/prayer_times_state.dart';
import '../models/prayer_times_model.dart';

class PrayerTimesPage extends StatelessWidget {
  const PrayerTimesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PrayerTimesBloc()..add(LoadPrayerTimes()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('مواقيت الصلاة',
              style: GoogleFonts.cairo(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.deepPurple,
        ),
        body: BlocBuilder<PrayerTimesBloc, PrayerTimesState>(
          builder: (context, state) {
            if (state is PrayerTimesLoading) {
              return const Center(child: CircularProgressIndicator(color: Colors.deepPurple));
            } else if (state is PrayerTimesLoaded) {
              return _buildPrayerTimesContent(state.prayerTimes);
            } else if (state is PrayerTimesError) {
              return Center(child: Text(state.message, style: GoogleFonts.cairo()));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildPrayerTimesContent(PrayerTimesModel model) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.deepPurple.shade100, Colors.white],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'مواقيت الصلاة',
              style: GoogleFonts.cairo(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 20),
            _buildPrayerTimeCard('الفجر', model.prayerTimes.fajr),
            _buildPrayerTimeCard('الشروق', model.prayerTimes.sunrise),
            _buildPrayerTimeCard('الظهر', model.prayerTimes.dhuhr),
            _buildPrayerTimeCard('العصر', model.prayerTimes.asr),
            _buildPrayerTimeCard('المغرب', model.prayerTimes.maghrib),
            _buildPrayerTimeCard('العشاء', model.prayerTimes.isha),
            const SizedBox(height: 20),
            Text(
              model.location,
              style: GoogleFonts.cairo(
                  fontSize: 14, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrayerTimeCard(String prayerName, DateTime? time) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              prayerName,
              style: GoogleFonts.cairo(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            Text(
              _formatTime(time),
              style: GoogleFonts.cairo(fontSize: 18, color: Colors.amber[800]),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime? time) {
    return time != null ? DateFormat.jm().format(time.toLocal()) : 'N/A';
  }
}