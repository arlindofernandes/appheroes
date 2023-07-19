import 'package:appheroes/pages/home.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: const MaterialColor(0xFFED1C24, {
          50: Color(0xFFFFECEC),
          100: Color(0xFFFFC9CA),
          200: Color(0xFFFE9A9B),
          300: Color(0xFFFE6B6C),
          400: Color(0xFFFD3D3E),
          500: Color(0xFFED1C24),
          600: Color(0xFFD71A20),
          700: Color(0xFFBE171C),
          800: Color(0xFFA41418),
          900: Color(0xFF8A1014),
        }),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
