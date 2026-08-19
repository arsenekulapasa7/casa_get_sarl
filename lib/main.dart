import 'package:flutter/material.dart';
import 'package:casaget_website/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _language = 'EN';

  void _setLanguage(String language) {
    if (language == _language) return;

    setState(() {
      _language = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CASA GET SARL',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Arial',
        useMaterial3: true,
      ),
      home: HomeScreen(
        language: _language,
        onLanguageChanged: _setLanguage,
      ),
    );
  }
}
