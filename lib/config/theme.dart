import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Modern Professional Light Theme Color Palette
class AppColors {
  // Primary Brand Colors (Professional Blue)
  static const Color primary = Color(0xFF2563EB); // Modern Blue
  static const Color primaryDark = Color(0xFF1E40AF); // Dark Blue
  static const Color primaryLight = Color(0xFF60A5FA); // Light Blue
  static const Color accent = Color(0xFF3B82F6); // Bright Blue
  
  // Secondary Colors (Professional Teal/Cyan)
  static const Color secondary = Color(0xFF06B6D4); // Cyan
  static const Color secondaryDark = Color(0xFF0891B2); // Dark Cyan
  static const Color secondaryLight = Color(0xFF22D3EE); // Light Cyan
  
  // Light Theme Background Colors
  static const Color background = Color(0xFFF8FAFC); // Off-white background
  static const Color surface = Color(0xFFFFFFFF); // Pure white surface
  static const Color surfaceVariant = Color(0xFFF1F5F9); // Light gray variant
  static const Color cardBackground = Color(0xFFFFFFFF); // White cards
  
  // Accent Colors for Features
  static const Color orange = Color(0xFFF97316); // Vibrant orange
  static const Color purple = Color(0xFF8B5CF6); // Soft purple
  static const Color green = Color(0xFF10B981); // Fresh green
  static const Color pink = Color(0xFFEC4899); // Modern pink
  
  // Status Colors
  static const Color success = Color(0xFF10B981); // Green
  static const Color warning = Color(0xFFF59E0B); // Amber
  static const Color error = Color(0xFFEF4444); // Red
  static const Color info = Color(0xFF3B82F6); // Blue
  
  // Text Colors (Dark on Light)
  static const Color textPrimary = Color(0xFF0F172A); // Almost black
  static const Color textSecondary = Color(0xFF64748B); // Medium gray
  static const Color textTertiary = Color(0xFF94A3B8); // Light gray
  static const Color textOnPrimary = Color(0xFFFFFFFF); // White on colored bg
  
  // Border & Divider Colors
  static const Color border = Color(0xFFE2E8F0); // Light border
  static const Color divider = Color(0xFFCBD5E1); // Subtle divider
  
  // Shadow Colors
  static const Color shadow = Color(0x0F000000); // Subtle shadow
  static const Color shadowMedium = Color(0x1A000000); // Medium shadow
}

// Gradient Definitions (Subtle and Professional)
class AppGradients {
  // Subtle Blue Gradient
  static const LinearGradient blueGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF3B82F6),
      Color(0xFF2563EB),
    ],
  );
  
  // Cyan to Blue Gradient
  static const LinearGradient cyanBlueGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF06B6D4),
      Color(0xFF3B82F6),
    ],
  );
  
  // Soft Background Gradient
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFFFFFFF),
      Color(0xFFF8FAFC),
    ],
  );
  
  // Card Gradient (very subtle)
  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFFFFFF),
      Color(0xFFFAFAFA),
    ],
  );
  
  // Overlay Gradient
  static const LinearGradient overlayGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0x10000000),
      Color(0x05000000),
    ],
  );
}

// App Theme (Modern Light Theme)
ThemeData appTheme = ThemeData(
  // Color Scheme - Light
  brightness: Brightness.light,
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.background,
  colorScheme: const ColorScheme.light(
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    surface: AppColors.surface,
    surfaceContainerHighest: AppColors.surfaceVariant,
    error: AppColors.error,
    onPrimary: AppColors.textOnPrimary,
    onSecondary: AppColors.textOnPrimary,
    onSurface: AppColors.textPrimary,
    onError: AppColors.textOnPrimary,
  ),

  // Text Theme with Google Fonts
  textTheme: GoogleFonts.poppinsTextTheme(
    const TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
        letterSpacing: -0.5,
      ),
      displayMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
        letterSpacing: -0.5,
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
    backgroundColor: AppColors.surface,
    foregroundColor: AppColors.textPrimary,
    elevation: 0,
    centerTitle: true,
    surfaceTintColor: Colors.transparent,
    shadowColor: AppColors.shadowMedium,
    titleTextStyle: GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
      letterSpacing: -0.5,
    ),
    iconTheme: const IconThemeData(
      color: AppColors.textPrimary,
    ),
  ),

  // Card Theme
  cardTheme: CardThemeData(
    elevation: 2,
    shadowColor: AppColors.shadowMedium,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    color: AppColors.cardBackground,
    surfaceTintColor: Colors.transparent,
  ),

  // Button Themes
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textOnPrimary,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      shadowColor: AppColors.primary.withOpacity(0.3),
      textStyle: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.primary,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      side: const BorderSide(color: AppColors.primary, width: 1.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      textStyle: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.primary,
      textStyle: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),

  // Input Decoration Theme
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surface,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.border),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.border),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.primary, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.error),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.error, width: 2),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    labelStyle: GoogleFonts.poppins(color: AppColors.textSecondary),
    hintStyle: GoogleFonts.poppins(color: AppColors.textTertiary),
  ),

  // Icon Theme
  iconTheme: const IconThemeData(
    color: AppColors.textPrimary,
    size: 24,
  ),

  // FloatingActionButton Theme
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.textOnPrimary,
    elevation: 4,
  ),

  // Bottom Navigation Bar Theme
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.surface,
    selectedItemColor: AppColors.primary,
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
    color: AppColors.divider,
    thickness: 1,
    space: 1,
  ),

  // Use Material 3
  useMaterial3: true,
);

