import 'package:flutter/material.dart';
import 'package:money_tracker/google_sheet_api.dart';
import 'package:money_tracker/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  GoogleSheetApi().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purpleAccent[100]!,
        ),
      ),
      home: SafeArea(child: Homepage()),
    );
  }
}
