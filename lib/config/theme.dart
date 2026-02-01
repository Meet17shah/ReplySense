import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Rich Purple Gradient Color Palette with Dark Theme
class AppColors {
  // Primary Purple Gradient Colors (More vibrant)
  static const Color primaryPurple = Color(0xFF9C27B0); // Vibrant Purple
  static const Color primaryPurpleDark = Color(0xFF6A1B9A); // Deep Purple
  static const Color primaryPurpleLight = Color(0xFFBA68C8); // Light Purple
  static const Color accentPurple = Color(0xFFCE93D8); // Accent Purple
  static const Color lavender = Color(0xFFE1BEE7); // Light Lavender
  
  // Gradient Colors for Rich UI (More vibrant on dark)
  static const Color gradientStart = Color(0xFF7B1FA2); // Vivid Purple
  static const Color gradientMiddle = Color(0xFF9C27B0); // Bright Purple
  static const Color gradientEnd = Color(0xFFAB47BC); // Light Purple
  static const Color neonPurple = Color(0xFFD500F9); // Neon Purple
  
  // Dark Theme Colors (Navy/Black)
  static const Color darkBackground = Color(0xFF0A0E27); // Dark Navy
  static const Color darkSurface = Color(0xFF1A1F3A); // Navy Surface
  static const Color darkCard = Color(0xFF1A1F3A); // Navy Card
  
  // Accent Border Colors
  static const Color cyan = Color(0xFF00D9FF); // Cyan accent
  static const Color orange = Color(0xFFFF9500); // Orange accent
  static const Color blue = Color(0xFF5E81F4); // Blue accent
  
  // Additional colors
  static const Color gold = Color(0xFFFFD700); // Gold accent
  static const Color neonGreen = Color(0xFF00D9FF); // Cyan Green
  static const Color success = Color(0xFF4CAF50); // Green
  static const Color warning = Color(0xFFFFC107); // Amber
  static const Color error = Color(0xFFF44336); // Red
  static const Color background = Color(0xFF000000); // Black background
  static const Color surface = Color(0xFF1E1E1E); // Dark surface
  static const Color textPrimary = Color(0xFFFFFFFF); // White text
  static const Color textSecondary = Color(0xFFB0B0B0); // Gray text
  static const Color textOnPurple = Color(0xFFFFFFFF);
}

// Gradient Definitions (Vibrant on Dark)
class AppGradients {
  static const LinearGradient purpleGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF7B1FA2),
      Color(0xFF9C27B0),
      Color(0xFFBA68C8),
    ],
  );
  
  static const LinearGradient neonPurpleGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF6A1B9A),
      Color(0xFF9C27B0),
      Color(0xFFCE93D8),
      Color(0xFFE1BEE7),
    ],
  );
  
  static const LinearGradient purpleGradientVertical = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF7B1FA2),
      Color(0xFF9C27B0),
      Color(0xFFBA68C8),
    ],
  );
  
  static const LinearGradient darkPurpleGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF4A148C),
      Color(0xFF6A1B9A),
      Color(0xFF9C27B0),
    ],
  );
  
  static const LinearGradient glassGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0x20FFFFFF),
      Color(0x10FFFFFF),
    ],
  );
}

// App Theme (Dark with Gradient)
ThemeData appTheme = ThemeData(
  // Color Scheme
  brightness: Brightness.dark,
  primaryColor: AppColors.primaryPurple,
  primaryColorDark: AppColors.primaryPurpleDark,
  primaryColorLight: AppColors.primaryPurpleLight,
  scaffoldBackgroundColor: const Color(0xFF0A0E27),
  colorScheme: const ColorScheme.dark(
    primary: AppColors.primaryPurple,
    secondary: AppColors.accentPurple,
    surface: Color(0xFF1A1F3A),
    error: AppColors.error,
  ),

  // Text Theme with Google Fonts
  textTheme: GoogleFonts.poppinsTextTheme(
    const TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
      displayMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
      displaySmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      headlineSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      titleLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: AppColors.textPrimary,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: AppColors.textSecondary,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: AppColors.textSecondary,
      ),
    ),
  ),

  // AppBar Theme
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    foregroundColor: AppColors.textOnPurple,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: AppColors.textOnPurple,
    ),
  ),

  // Card Theme
  cardTheme: CardThemeData(
    elevation: 4,
    shadowColor: Colors.black.withOpacity(0.3),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    color: const Color(0xFF1A1F3A),
  ),

  // Button Themes
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryPurple,
      foregroundColor: AppColors.textOnPurple,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      shadowColor: AppColors.primaryPurple.withOpacity(0.5),
      textStyle: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.primaryPurple,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      side: const BorderSide(color: AppColors.primaryPurple, width: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      textStyle: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.primaryPurple,
      textStyle: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),

  // Input Decoration Theme
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFF1A1F3A),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: AppColors.primaryPurple.withOpacity(0.3)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: AppColors.primaryPurple.withOpacity(0.3)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: AppColors.primaryPurple, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: AppColors.error),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: AppColors.error, width: 2),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    labelStyle: GoogleFonts.poppins(color: AppColors.textSecondary),
    hintStyle: GoogleFonts.poppins(color: AppColors.textSecondary),
  ),

  // Icon Theme
  iconTheme: const IconThemeData(
    color: AppColors.textPrimary,
    size: 24,
  ),

  // FloatingActionButton Theme
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.primaryPurple,
    foregroundColor: AppColors.textOnPurple,
    elevation: 6,
  ),

  // Bottom Navigation Bar Theme
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: const Color(0xFF1A1F3A),
    selectedItemColor: AppColors.primaryPurple,
    unselectedItemColor: AppColors.textSecondary,
    type: BottomNavigationBarType.fixed,
    elevation: 8,
    selectedLabelStyle: GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.w600,
    ),
    unselectedLabelStyle: GoogleFonts.poppins(
      fontSize: 12,
    ),
  ),

  // Divider Theme
  dividerTheme: const DividerThemeData(
    color: Color(0xFF424242),
    thickness: 1,
    space: 1,
  ),

  // Use Material 3
  useMaterial3: true,
);

