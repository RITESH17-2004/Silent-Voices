import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
        primaryColor: const Color(0xFF00BFFF), // Neon Blue
        scaffoldBackgroundColor: const Color(0xFFEFF4F3),
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF00BFFF), // Neon Blue
          secondary: const Color(0xFF5EB3F5), // Soft Blue
          background: Colors.white,
        ),
        textTheme: GoogleFonts.poppinsTextTheme().copyWith(
          headlineLarge: GoogleFonts.poppins(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF00BFFF), // Neon Blue
          ),
          headlineMedium: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF00BFFF), // Neon Blue
          ),
          titleMedium: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF5EB3F5), // Soft Blue
          ),
          bodyLarge: GoogleFonts.poppins(
            fontSize: 18,
            color: Colors.white, // Input text
          ),
          bodyMedium: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.white, // Input text
          ),
          labelMedium: GoogleFonts.poppins(
            fontSize: 16,
            color: Color(0xFFA0AAB8), // Placeholder
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00BFFF), // Neon Blue
            foregroundColor: const Color(0xFF0B1C2C), // Button text black
            textStyle: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            shadowColor: const Color(0xFF00BFFF),
            elevation: 8,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF1A2B3C), // Dark bluish
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF00BFFF)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF00BFFF)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF00BFFF), width: 2),
          ),
          hintStyle: GoogleFonts.poppins(
            color: Color(0xFFA0AAB8), // Placeholder
            fontSize: 16,
          ),
          labelStyle: GoogleFonts.poppins(
            color: Colors.white, // Input text
            fontSize: 16,
          ),
          prefixIconColor: const Color(0xFF00BFFF), // Neon Blue
          contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        ),
        fontFamily: GoogleFonts.poppins().fontFamily,
      );
} 