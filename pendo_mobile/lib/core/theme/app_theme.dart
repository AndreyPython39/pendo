import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF6200EE), // Royal Purple
        primary: const Color(0xFF6200EE), // Royal Purple
        secondary: const Color(0xFFE4A01B), // African Gold
        tertiary: const Color(0xFFD35400), // Terracotta
        surface: const Color(0xFFFFFBF5), // Warm White
        background: const Color(0xFFFFF8E1), // Warm Background
        error: const Color(0xFFC0392B), // Earth Red
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'AfricanSpirit',
          color: Color(0xFF1A1A1A),
        ),
        bodyLarge: TextStyle(
          fontFamily: 'NotoSans',
          color: Color(0xFF1A1A1A),
        ),
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xFFFFFBF5),
      ),
      cardTheme: CardTheme(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: const Color(0xFFFFFBF5),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFFE4A01B), // African Gold
          ),
        ),
        filled: true,
        fillColor: const Color(0xFFFFFBF5),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6200EE), // Royal Purple
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF6200EE), // Royal Purple
          side: const BorderSide(
            color: Color(0xFF6200EE), // Royal Purple
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFFE4A01B).withOpacity(0.1), // African Gold
        selectedColor: const Color(0xFFE4A01B), // African Gold
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        elevation: 8,
        selectedItemColor: Color(0xFF6200EE), // Royal Purple
        unselectedItemColor: Color(0xFF757575),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF1A1A1A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: const Color(0xFFFFFBF5),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Color(0xFFFFFBF5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFFBB86FC), // Light Purple
        brightness: Brightness.dark,
        primary: const Color(0xFFBB86FC), // Light Purple
        secondary: const Color(0xFFFFC107), // Gold
        tertiary: const Color(0xFFFF6B35), // Sunset Orange
        surface: const Color(0xFF1E1E1E),
        background: const Color(0xFF121212),
        error: const Color(0xFFCF6679),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'AfricanSpirit',
          color: Color(0xFFFFFFFF),
        ),
        bodyLarge: TextStyle(
          fontFamily: 'NotoSans',
          color: Color(0xFFFFFFFF),
        ),
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xFF1E1E1E),
      ),
      cardTheme: CardTheme(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: const Color(0xFF1E1E1E),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFFFFC107), // Gold
          ),
        ),
        filled: true,
        fillColor: const Color(0xFF1E1E1E),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFBB86FC), // Light Purple
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFFBB86FC), // Light Purple
          side: const BorderSide(
            color: Color(0xFFBB86FC), // Light Purple
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFFFFC107).withOpacity(0.1), // Gold
        selectedColor: const Color(0xFFFFC107), // Gold
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        elevation: 8,
        selectedItemColor: Color(0xFFBB86FC), // Light Purple
        unselectedItemColor: Color(0xFF757575),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF2D2D2D),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: const Color(0xFF1E1E1E),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
      ),
    );
  }
}
