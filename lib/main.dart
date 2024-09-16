
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/azkar_page.dart';
import 'pages/prayer_times_page.dart';
import 'pages/qibla_page.dart';
import 'pages/quran_page.dart';
import 'pages/tasbeeh_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'مشكاة',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        primaryColor: Colors.amber,
        fontFamily: GoogleFonts.cairo().fontFamily,
        textTheme: GoogleFonts.cairoTextTheme(),
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepPurple.shade700, Colors.deepPurple.shade300],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 40),
              Text(
                'مشكاه',
                style: GoogleFonts.cairo(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'استغفر الله الذي لا اله\nالا هو الحي القيوم واتوب اليه',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(30),),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                     return Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         _buildNavButton(context, 'القرآن الكريم', () {
                           Navigator.push(
                           context,
                           MaterialPageRoute(
                               builder: (context) => const QuranPage())
                           );
                         }),
                         const SizedBox(width:  20),
                         _buildNavButton(context, 'مواقيت الصلاة', () {
                           Navigator.push(
                             context,
                             MaterialPageRoute(
                                 builder: (context) => const PrayerTimesPage()),
                           );
                         }),
                         const SizedBox(width: 20),
                         _buildNavButton(context, 'القبلة', () {
                           Navigator.push(
                             context,
                             MaterialPageRoute(
                                 builder: (context) => const QiblahScreen()),
                           );
                         }),
                         const SizedBox(width: 20),
                         _buildNavButton(context, ' السبحة', () {
                           Navigator.push(
                             context,
                             MaterialPageRoute(
                                 builder: (context) => const ElectronicTasbeeh()),
                           );
                         }),
                       ],
                     );
                     },),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'قائمة الأذكار',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
            Column(
             mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AzkarPage(fileName: 'azkar_sabah.json', title: 'أذكار الصباح')),
                    );
                    },
                  child: Text('أذكار الصباح'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AzkarPage(fileName: 'azkar_massa.json', title: 'أذكار المساء')),
                    );
                    },
                  child: Text('أذكار المساء'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AzkarPage(fileName: 'PostPrayer_azkar.json', title: 'أذكار بعد الصلاة')),
                    );
                    },
                  child: Text('أذكار بعد الصلاة'),
                ),
              ],
           ),],
          ),
        ),
      ),
    );
  }
}


  Widget _buildNavButton(
      BuildContext context, String title, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.amber,
        foregroundColor: Colors.deepPurple,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Text(
        title,
        style: GoogleFonts.cairo(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
