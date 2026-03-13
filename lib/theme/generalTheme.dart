import 'package:flutter/material.dart';

class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  // ============== COLORS ==============
  // Primary Colors - Soft sky blue like in the avatar (from the image)
  static const Color primaryPurple = Color(0xFF60A5FA); // Soft sky blue (was purple)
  static const Color primaryPurpleLight = Color(0xFF93C5FD); // Lighter sky blue
  static const Color primaryPurpleDark = Color(0xFF3B82F6); // Slightly darker sky blue

  // Background Colors - Dark theme (from image)
  static const Color darkBackground = Color(0xFF000000); // Pure black background
  static const Color darkSurface = Color(0xFF0A0A0A); // Slightly lighter black for surfaces
  static const Color darkCard = Color(0xFF121212); // Card background
  static const Color darkElevated = Color(0xFF1E1E1E); // Elevated surfaces

  // Background Colors - Light theme (grey background)
  static const Color lightBackground = Color(0xFFF5F5F5); // Light grey background
  static const Color lightSurface = Color(0xFFFFFFFF); // White surfaces
  static const Color lightCard = Color(0xFFFFFFFF); // White cards
  static const Color lightElevated = Color(0xFFFAFAFA); // Slightly off-white

  // Text Colors - Dark theme
  static const Color darkTextPrimary = Color(0xFFFFFFFF); // Pure white primary text
  static const Color darkTextSecondary = Color(0xFFB0B0B0); // Light grey secondary text
  static const Color darkTextHint = Color(0xFF6B6B6B); // Dimmer text for hints

  // Text Colors - Light theme
  static const Color lightTextPrimary = Color(0xFF1E1E1E); // Near black primary text
  static const Color lightTextSecondary = Color(0xFF6B6B6B); // Grey secondary text
  static const Color lightTextHint = Color(0xFF9E9E9E); // Light grey hint text

  // Accent Colors - Soft sky blue like in the avatar (from the image)
  static const Color accentPurple = Color(0xFF60A5FA); // Soft sky blue (was purple)
  static const Color accentPurpleLight = Color(0xFF93C5FD); // Lighter sky blue
  static const Color accentPurpleDark = Color(0xFF3B82F6); // Slightly darker sky blue

  // Semantic Colors (kept the same)
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);

  // Neutral Colors (shared between themes)
  static const Color white = Color(0xFFFFFFFF);
  static const Color offWhite = Color(0xFFF8FAFC);
  static const Color lightGray = Color(0xFFE2E8F0);
  static const Color mediumGray = Color(0xFF94A3B8);
  static const Color darkGray = Color(0xFF475569);
  static const Color black = Color(0xFF000000);

  // Gradient Combinations (using sky blue colors)
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryPurple, primaryPurpleDark],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [accentPurple, accentPurpleDark],
  );

  // ============== TYPOGRAPHY ==============
  // Using Inter as primary font (Montserrat as fallback)
  static const String fontFamily = 'Inter';
  static const String fontFamilyFallback = 'Montserrat';

  // Font Sizes
  static const double fontSizeXS = 10.0;
  static const double fontSizeSM = 12.0;
  static const double fontSizeMD = 14.0;
  static const double fontSizeLG = 16.0;
  static const double fontSizeXL = 18.0;
  static const double fontSize2XL = 20.0;
  static const double fontSize3XL = 24.0;
  static const double fontSize4XL = 30.0;
  static const double fontSize5XL = 36.0;

  // Font Weights
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;

  // ============== SPACING ==============
  static const double spacingXXS = 2.0;
  static const double spacingXS = 4.0;
  static const double spacingSM = 8.0;
  static const double spacingMD = 12.0;
  static const double spacingLG = 16.0;
  static const double spacingXL = 20.0;
  static const double spacing2XL = 24.0;
  static const double spacing3XL = 32.0;
  static const double spacing4XL = 40.0;
  static const double spacing5XL = 48.0;

  // ============== BORDER RADIUS ==============
  static const double radiusXS = 4.0;
  static const double radiusSM = 8.0;
  static const double radiusMD = 12.0;
  static const double radiusLG = 16.0;
  static const double radiusXL = 20.0;
  static const double radius2XL = 24.0;
  static const double radiusCircular = 100.0;

  // ============== DURATIONS ==============
  static const Duration animationFast = Duration(milliseconds: 200);
  static const Duration animationNormal = Duration(milliseconds: 350);
  static const Duration animationSlow = Duration(milliseconds: 600);

  // ============== SHADOWS ==============
  static List<BoxShadow> shadowSM = [
    BoxShadow(
      color: Colors.black.withOpacity(0.05),
      blurRadius: 4,
      offset: const Offset(0, 1),
    ),
  ];

  static List<BoxShadow> shadowMD = [
    BoxShadow(
      color: Colors.black.withOpacity(0.08),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> shadowLG = [
    BoxShadow(
      color: Colors.black.withOpacity(0.12),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> shadowXL = [
    BoxShadow(
      color: Colors.black.withOpacity(0.16),
      blurRadius: 24,
      offset: const Offset(0, 8),
    ),
  ];

  // Dark theme shadows (subtle due to dark background)
  static List<BoxShadow> darkShadowSM = [
    BoxShadow(
      color: Colors.black.withOpacity(0.3),
      blurRadius: 4,
      offset: const Offset(0, 1),
    ),
  ];

  static List<BoxShadow> darkShadowMD = [
    BoxShadow(
      color: Colors.black.withOpacity(0.4),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];

  // ============== BUTTON STYLES ==============
  static ButtonStyle primaryButton(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ElevatedButton.styleFrom(
      backgroundColor: isDark ? accentPurple : primaryPurple,
      foregroundColor: isDark ? darkTextPrimary : white,
      minimumSize: const Size(double.infinity, 48),
      padding: const EdgeInsets.symmetric(
        horizontal: spacingLG,
        vertical: spacingMD,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusSM),
      ),
      textStyle: const TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSizeMD,
        fontWeight: semiBold,
      ),
      elevation: 0,
    );
  }

  static ButtonStyle get secondaryButton => OutlinedButton.styleFrom(
    foregroundColor: primaryPurple,
    minimumSize: const Size(double.infinity, 48),
    padding: const EdgeInsets.symmetric(
      horizontal: spacingLG,
      vertical: spacingMD,
    ),
    side: const BorderSide(color: primaryPurple, width: 1.5),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radiusSM),
    ),
    textStyle: const TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSizeMD,
      fontWeight: semiBold,
    ),
  );

  // ============== INPUT DECORATION ==============
  static InputDecoration inputDecoration({
    required BuildContext context,
    String? hintText,
    String? labelText,
    IconData? prefixIcon,
    Widget? suffixIcon,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InputDecoration(
      hintText: hintText,
      labelText: labelText,
      prefixIcon: prefixIcon != null
          ? Icon(prefixIcon, size: 20, color: isDark ? darkTextSecondary : mediumGray)
          : null,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: isDark ? darkCard : white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: spacingLG,
        vertical: spacingMD,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusSM),
        borderSide: BorderSide(color: isDark ? darkTextHint : lightGray, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusSM),
        borderSide: BorderSide(color: isDark ? darkTextHint : lightGray, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusSM),
        borderSide: const BorderSide(color: primaryPurple, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusSM),
        borderSide: const BorderSide(color: error, width: 1),
      ),
      labelStyle: TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSizeMD,
        color: isDark ? darkTextSecondary : darkGray,
      ),
      hintStyle: TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSizeMD,
        color: isDark ? darkTextHint : mediumGray,
      ),
    );
  }

  // ============== TEXT THEME ==============
  static TextTheme _buildTextTheme(TextTheme base, bool isDark) {
    final textPrimary = isDark ? darkTextPrimary : lightTextPrimary;
    final textSecondary = isDark ? darkTextSecondary : lightTextSecondary;
    final textHint = isDark ? darkTextHint : lightTextHint;

    return base.copyWith(
      displayLarge: base.displayLarge?.copyWith(
        fontFamily: fontFamily,
        fontSize: fontSize5XL,
        fontWeight: bold,
        color: textPrimary,
      ),
      displayMedium: base.displayMedium?.copyWith(
        fontFamily: fontFamily,
        fontSize: fontSize4XL,
        fontWeight: bold,
        color: textPrimary,
      ),
      displaySmall: base.displaySmall?.copyWith(
        fontFamily: fontFamily,
        fontSize: fontSize3XL,
        fontWeight: bold,
        color: textPrimary,
      ),
      headlineMedium: base.headlineMedium?.copyWith(
        fontFamily: fontFamily,
        fontSize: fontSize2XL,
        fontWeight: semiBold,
        color: textPrimary,
      ),
      headlineSmall: base.headlineSmall?.copyWith(
        fontFamily: fontFamily,
        fontSize: fontSizeXL,
        fontWeight: semiBold,
        color: textPrimary,
      ),
      titleLarge: base.titleLarge?.copyWith(
        fontFamily: fontFamily,
        fontSize: fontSizeLG,
        fontWeight: semiBold,
        color: textPrimary,
      ),
      titleMedium: base.titleMedium?.copyWith(
        fontFamily: fontFamily,
        fontSize: fontSizeMD,
        fontWeight: medium,
        color: textPrimary,
      ),
      titleSmall: base.titleSmall?.copyWith(
        fontFamily: fontFamily,
        fontSize: fontSizeSM,
        fontWeight: medium,
        color: textSecondary,
      ),
      bodyLarge: base.bodyLarge?.copyWith(
        fontFamily: fontFamily,
        fontSize: fontSizeMD,
        fontWeight: regular,
        color: textPrimary,
      ),
      bodyMedium: base.bodyMedium?.copyWith(
        fontFamily: fontFamily,
        fontSize: fontSizeSM,
        fontWeight: regular,
        color: textSecondary,
      ),
      bodySmall: base.bodySmall?.copyWith(
        fontFamily: fontFamily,
        fontSize: fontSizeXS,
        fontWeight: regular,
        color: textHint,
      ),
      labelLarge: base.labelLarge?.copyWith(
        fontFamily: fontFamily,
        fontSize: fontSizeSM,
        fontWeight: medium,
        letterSpacing: 0.5,
        color: accentPurple,
      ),
    );
  }

  // ============== LIGHT THEME ==============
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: primaryPurple,
    scaffoldBackgroundColor: lightBackground, // Light grey background
    colorScheme: const ColorScheme.light(
      primary: primaryPurple,
      secondary: accentPurple,
      surface: lightSurface,
      background: lightBackground,
      error: error,
      onPrimary: white,
      onSecondary: white,
      onSurface: lightTextPrimary,
      onBackground: lightTextPrimary,
      onError: white,
    ),

    // Text Theme
    textTheme: _buildTextTheme(const TextTheme(), false),

    // AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: lightSurface,
      foregroundColor: lightTextPrimary,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSizeLG,
        fontWeight: semiBold,
        color: lightTextPrimary,
      ),
      iconTheme: IconThemeData(
        color: lightTextPrimary,
        size: 24,
      ),
    ),

    // Card Theme
    cardTheme: CardThemeData(
      color: lightCard,
      elevation: 1,
      shadowColor: Colors.black.withOpacity(0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusMD),
      ),
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: lightSurface,
      selectedItemColor: primaryPurple,
      unselectedItemColor: lightTextHint,
      selectedLabelStyle: TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSizeXS,
        fontWeight: medium,
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSizeXS,
        fontWeight: medium,
      ),
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),

    // Divider Theme
    dividerTheme: DividerThemeData(
      color: lightGray.withOpacity(0.5),
      thickness: 0.5,
      space: 1,
    ),

    // Keep other themes consistent but with light colors
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryPurple,
        foregroundColor: white,
        minimumSize: const Size(double.infinity, 48),
        padding: const EdgeInsets.symmetric(
          horizontal: spacingLG,
          vertical: spacingMD,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusSM),
        ),
        textStyle: const TextStyle(
          fontFamily: fontFamily,
          fontSize: fontSizeMD,
          fontWeight: semiBold,
        ),
        elevation: 0,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: lightSurface,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: spacingLG,
        vertical: spacingMD,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusSM),
        borderSide: BorderSide(color: lightGray, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusSM),
        borderSide: BorderSide(color: lightGray, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusSM),
        borderSide: const BorderSide(color: primaryPurple, width: 2),
      ),
      labelStyle: TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSizeMD,
        color: lightTextSecondary,
      ),
      hintStyle: TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSizeMD,
        color: lightTextHint,
      ),
    ),
  );

  // ============== DARK THEME ==============
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: accentPurple,
    scaffoldBackgroundColor: darkBackground, // Pure black background like the image
    colorScheme: const ColorScheme.dark(
      primary: accentPurple,
      secondary: accentPurple,
      surface: darkSurface,
      background: darkBackground,
      error: error,
      onPrimary: darkTextPrimary,
      onSecondary: darkTextPrimary,
      onSurface: darkTextPrimary,
      onBackground: darkTextPrimary,
      onError: white,
    ),

    // Text Theme
    textTheme: _buildTextTheme(const TextTheme(), true),

    // AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: darkBackground, // Match background like in the image
      foregroundColor: darkTextPrimary,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSizeLG,
        fontWeight: semiBold,
        color: darkTextPrimary,
      ),
      iconTheme: IconThemeData(
        color: darkTextPrimary,
        size: 24,
      ),
    ),

    // Card Theme
    cardTheme: CardThemeData(
      color: darkCard,
      elevation: 0, // No elevation in the image
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusMD),
      ),
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: darkBackground, // Match background
      selectedItemColor: accentPurple, // Sky blue accent like in the avatar
      unselectedItemColor: darkTextHint,
      selectedLabelStyle: TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSizeXS,
        fontWeight: medium,
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSizeXS,
        fontWeight: medium,
      ),
      type: BottomNavigationBarType.fixed,
      elevation: 0, // No elevation in the image
    ),

    // Divider Theme
    dividerTheme: DividerThemeData(
      color: darkTextHint.withOpacity(0.3),
      thickness: 0.5,
      space: 1,
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: accentPurple,
        foregroundColor: darkTextPrimary,
        minimumSize: const Size(double.infinity, 48),
        padding: const EdgeInsets.symmetric(
          horizontal: spacingLG,
          vertical: spacingMD,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusSM),
        ),
        textStyle: const TextStyle(
          fontFamily: fontFamily,
          fontSize: fontSizeMD,
          fontWeight: semiBold,
        ),
        elevation: 0,
      ),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: darkCard,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: spacingLG,
        vertical: spacingMD,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusSM),
        borderSide: BorderSide(color: darkTextHint.withOpacity(0.3), width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusSM),
        borderSide: BorderSide(color: darkTextHint.withOpacity(0.3), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusSM),
        borderSide: const BorderSide(color: accentPurple, width: 2),
      ),
      labelStyle: TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSizeMD,
        color: darkTextSecondary,
      ),
      hintStyle: TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSizeMD,
        color: darkTextHint,
      ),
    ),

    // Icon Theme
    iconTheme: IconThemeData(
      color: darkTextPrimary,
      size: 24,
    ),

    // List Tile Theme
    listTileTheme: ListTileThemeData(
      textColor: darkTextPrimary,
      iconColor: darkTextSecondary,
      tileColor: Colors.transparent,
    ),
  );

  static TextStyle get bodyText => const TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSizeMD,
    fontWeight: regular,
    // Remove the hardcoded color since it will be set by the extension
  );
}

extension ThemeExtensions on BuildContext {
  // ============== PRIMARY COLORS ==============
  Color get primaryPurple => AppTheme.primaryPurple;
  Color get primaryPurpleLight => AppTheme.primaryPurpleLight;
  Color get primaryPurpleDark => AppTheme.primaryPurpleDark;
  Color get accentPurple => AppTheme.accentPurple;
  Color get accentPurpleLight => AppTheme.accentPurpleLight;
  Color get accentPurpleDark => AppTheme.accentPurpleDark;

  // Alias for backward compatibility
  Color get primaryColor => AppTheme.primaryPurple;

  // ============== BACKGROUND COLORS ==============
  // Dark theme backgrounds
  Color get darkBackground => AppTheme.darkBackground;
  Color get darkSurface => AppTheme.darkSurface;
  Color get darkCard => AppTheme.darkCard;
  Color get darkElevated => AppTheme.darkElevated;

  // Light theme backgrounds
  Color get lightBackground => AppTheme.lightBackground;
  Color get lightSurface => AppTheme.lightSurface;
  Color get lightCard => AppTheme.lightCard;
  Color get lightElevated => AppTheme.lightElevated;

  // Dynamic backgrounds (based on theme)
  Color get backgroundColor => Theme.of(this).brightness == Brightness.dark
      ? AppTheme.darkBackground
      : AppTheme.lightBackground;

  Color get surfaceColor => Theme.of(this).brightness == Brightness.dark
      ? AppTheme.darkSurface
      : AppTheme.lightSurface;

  Color get cardColor => Theme.of(this).brightness == Brightness.dark
      ? AppTheme.darkCard
      : AppTheme.lightCard;

  // ============== TEXT COLORS ==============
  // Dark text colors
  Color get darkTextPrimary => AppTheme.darkTextPrimary;
  Color get darkTextSecondary => AppTheme.darkTextSecondary;
  Color get darkTextHint => AppTheme.darkTextHint;

  // Light text colors
  Color get lightTextPrimary => AppTheme.lightTextPrimary;
  Color get lightTextSecondary => AppTheme.lightTextSecondary;
  Color get lightTextHint => AppTheme.lightTextHint;

  // Dynamic text colors (based on theme)
  Color get textPrimary => Theme.of(this).brightness == Brightness.dark
      ? AppTheme.darkTextPrimary
      : AppTheme.lightTextPrimary;

  Color get textSecondary => Theme.of(this).brightness == Brightness.dark
      ? AppTheme.darkTextSecondary
      : AppTheme.lightTextSecondary;

  Color get textHint => Theme.of(this).brightness == Brightness.dark
      ? AppTheme.darkTextHint
      : AppTheme.lightTextHint;

  // ============== NEUTRAL COLORS ==============
  Color get white => AppTheme.white;
  Color get offWhite => AppTheme.offWhite;
  Color get lightGray => AppTheme.lightGray;
  Color get mediumGray => AppTheme.mediumGray;
  Color get darkGray => AppTheme.darkGray;
  Color get black => AppTheme.black;

  // ============== SEMANTIC COLORS ==============
  Color get success => AppTheme.success;
  Color get error => AppTheme.error;
  Color get warning => AppTheme.warning;
  Color get info => AppTheme.info;

  // ============== GRADIENTS ==============
  LinearGradient get primaryGradient => AppTheme.primaryGradient;
  LinearGradient get accentGradient => AppTheme.accentGradient;

  // ============== SHADOWS ==============
  List<BoxShadow> get shadowSM => Theme.of(this).brightness == Brightness.dark
      ? AppTheme.darkShadowSM
      : AppTheme.shadowSM;

  List<BoxShadow> get shadowMD => Theme.of(this).brightness == Brightness.dark
      ? AppTheme.darkShadowMD
      : AppTheme.shadowMD;

  List<BoxShadow> get shadowLG => AppTheme.shadowLG;
  List<BoxShadow> get shadowXL => AppTheme.shadowXL;

  // ============== TEXT STYLES ==============
  TextStyle? get displayLarge => Theme.of(this).textTheme.displayLarge;
  TextStyle? get displayMedium => Theme.of(this).textTheme.displayMedium;
  TextStyle? get displaySmall => Theme.of(this).textTheme.displaySmall;
  TextStyle? get headlineMedium => Theme.of(this).textTheme.headlineMedium;
  TextStyle? get headlineSmall => Theme.of(this).textTheme.headlineSmall;
  TextStyle? get titleLarge => Theme.of(this).textTheme.titleLarge;
  TextStyle? get titleMedium => Theme.of(this).textTheme.titleMedium;
  TextStyle? get titleSmall => Theme.of(this).textTheme.titleSmall;
  TextStyle? get bodyLarge => Theme.of(this).textTheme.bodyLarge;
  TextStyle? get bodyMedium => Theme.of(this).textTheme.bodyMedium;
  TextStyle? get bodySmall => Theme.of(this).textTheme.bodySmall;
  TextStyle? get labelLarge => Theme.of(this).textTheme.labelLarge;
  TextStyle? get labelMedium => Theme.of(this).textTheme.labelMedium;
  TextStyle? get labelSmall => Theme.of(this).textTheme.labelSmall;

  // Alias for bodyText (backward compatibility)
  TextStyle get bodyText => const TextStyle(
    fontFamily: AppTheme.fontFamily,
    fontSize: AppTheme.fontSizeMD,
    fontWeight: AppTheme.regular,
  ).copyWith(color: textPrimary);

  // ============== BUTTON STYLES - FIXED ==============
  // These are now properties that return ButtonStyle directly
  ButtonStyle get primaryButton => ElevatedButton.styleFrom(
    backgroundColor: Theme.of(this).brightness == Brightness.dark
        ? accentPurple
        : primaryPurple,
    foregroundColor: Theme.of(this).brightness == Brightness.dark
        ? darkTextPrimary
        : white,
    minimumSize: const Size(double.infinity, 48),
    padding: const EdgeInsets.symmetric(
      horizontal: AppTheme.spacingLG,
      vertical: AppTheme.spacingMD,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppTheme.radiusSM),
    ),
    textStyle: const TextStyle(
      fontFamily: AppTheme.fontFamily,
      fontSize: AppTheme.fontSizeMD,
      fontWeight: AppTheme.semiBold,
    ),
    elevation: 0,
  );

  ButtonStyle get secondaryButton => OutlinedButton.styleFrom(
    foregroundColor: Theme.of(this).brightness == Brightness.dark
        ? accentPurple
        : primaryPurple,
    minimumSize: const Size(double.infinity, 48),
    padding: const EdgeInsets.symmetric(
      horizontal: AppTheme.spacingLG,
      vertical: AppTheme.spacingMD,
    ),
    side: BorderSide(
        color: Theme.of(this).brightness == Brightness.dark
            ? accentPurple
            : primaryPurple,
        width: 1.5
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppTheme.radiusSM),
    ),
    textStyle: const TextStyle(
      fontFamily: AppTheme.fontFamily,
      fontSize: AppTheme.fontSizeMD,
      fontWeight: AppTheme.semiBold,
    ),
  );

  // ============== INPUT DECORATION ==============
  InputDecoration inputDecoration({
    String? hintText,
    String? labelText,
    IconData? prefixIcon,
    Widget? suffixIcon,
  }) {
    final isDark = Theme.of(this).brightness == Brightness.dark;
    return InputDecoration(
      hintText: hintText,
      labelText: labelText,
      prefixIcon: prefixIcon != null
          ? Icon(prefixIcon, size: 20, color: isDark ? darkTextSecondary : mediumGray)
          : null,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: isDark ? darkCard : white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingLG,
        vertical: AppTheme.spacingMD,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusSM),
        borderSide: BorderSide(color: isDark ? darkTextHint.withOpacity(0.3) : lightGray, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusSM),
        borderSide: BorderSide(color: isDark ? darkTextHint.withOpacity(0.3) : lightGray, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusSM),
        borderSide: BorderSide(color: isDark ? accentPurple : primaryPurple, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusSM),
        borderSide: const BorderSide(color: AppTheme.error, width: 1),
      ),
      labelStyle: TextStyle(
        fontFamily: AppTheme.fontFamily,
        fontSize: AppTheme.fontSizeMD,
        color: isDark ? darkTextSecondary : darkGray,
      ),
      hintStyle: TextStyle(
        fontFamily: AppTheme.fontFamily,
        fontSize: AppTheme.fontSizeMD,
        color: isDark ? darkTextHint : mediumGray,
      ),
    );
  }

  // ============== SPACING ==============
  double get spacingXXS => AppTheme.spacingXXS;
  double get spacingXS => AppTheme.spacingXS;
  double get spacingSM => AppTheme.spacingSM;
  double get spacingMD => AppTheme.spacingMD;
  double get spacingLG => AppTheme.spacingLG;
  double get spacingXL => AppTheme.spacingXL;
  double get spacing2XL => AppTheme.spacing2XL;
  double get spacing3XL => AppTheme.spacing3XL;
  double get spacing4XL => AppTheme.spacing4XL;
  double get spacing5XL => AppTheme.spacing5XL;

  // ============== BORDER RADIUS ==============
  double get radiusXS => AppTheme.radiusXS;
  double get radiusSM => AppTheme.radiusSM;
  double get radiusMD => AppTheme.radiusMD;
  double get radiusLG => AppTheme.radiusLG;
  double get radiusXL => AppTheme.radiusXL;
  double get radius2XL => AppTheme.radius2XL;
  double get radiusCircular => AppTheme.radiusCircular;
}