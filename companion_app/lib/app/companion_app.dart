import 'package:companion_app/features/home/home_page.dart';
import 'package:flutter/material.dart';

class CompanionApp extends StatelessWidget {
  const CompanionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Companion',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3C7A6B),
          brightness: Brightness.light,
        ),
      ),
      home: const HomePage(),
    );
  }
}
