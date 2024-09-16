import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AzkarPage extends StatefulWidget {
  final String fileName;
  final String title;

  AzkarPage({required this.fileName, required this.title});

  @override
  _AzkarPageState createState() => _AzkarPageState();
}

class _AzkarPageState extends State<AzkarPage> {
  List<dynamic> azkarList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadAzkar();
  }
  // تحميل ملفات JSON
  Future<void> loadAzkar() async {
    try {
      String jsonString = await rootBundle.loadString('assets/${widget.fileName}');
      Map<String, dynamic> jsonData = json.decode(jsonString);
      setState(() {
        azkarList = jsonData['content'];
        isLoading = false;
      });
    } catch (e) {
      print("Error loading JSON: $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: azkarList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(azkarList[index]['zekr']),
            subtitle: Text(
                "التكرار: ${azkarList[index]['repeat']} | الفضل: ${azkarList[index]['bless']}"),
          );
        },
      ),
    );
  }
}