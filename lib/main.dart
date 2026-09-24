import 'package:flutter/material.dart';
import 'package:casaget_website/screens/home_screen.dart';
import 'package:casaget_website/screens/admin_login_page.dart';
import 'package:casaget_website/services/content_store.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ContentStore.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _language = 'FR';

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
      theme: ThemeData(fontFamily: 'Arial', useMaterial3: true),
      home: HomeScreen(language: _language, onLanguageChanged: _setLanguage),
      onGenerateRoute: (settings) {
        if (settings.name == '/admin') {
          return MaterialPageRoute(builder: (_) => const AdminLoginPage());
        }
        return null;
      },
    );
  }
}
