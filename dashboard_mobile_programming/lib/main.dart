import 'package:flutter/material.dart';
import 'pages/main_navigation_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard Mobile Programming',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xffF5F7FB),
        fontFamily: 'Roboto',
      ),
      home: const MainNavigationPage(),
    );
  }
}