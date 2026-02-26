import 'package:flutter/material.dart';

class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  // ============== COLORS ==============
  // Primary Color: Nigerian Green (#008751) - Trust & Local Relevance
  static const Color primaryGreen = Color(0xFF008751);
  static const Color primaryGreenLight = Color(0xFF33A97A);
  static const Color primaryGreenDark = Color(0xFF00653D);

  // Secondary Color: Deep Navy (#1E293B) - Professional Text & Backgrounds
  static const Color deepNavy = Color(0xFF1E293B);
  static const Color deepNavyLight = Color(0xFF2D3A4E);
  static const Color deepNavyDark = Color(0xFF0F172A);

  // Accent Color: Amber (#F59E0B) - Recharge & Action Buttons
  static const Color actionAmber = Color(0xFFF59E0B);
  static const Color actionAmberLight = Color(0xFFFBBF24);
  static const Color actionAmberDark = Color(0xFFD97706);

  // Semantic Colors
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);

  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color offWhite = Color(0xFFF8FAFC);
  static const Color lightGray = Color(0xFFE2E8F0);
  static const Color mediumGray = Color(0xFF94A3B8);
  static const Color darkGray = Color(0xFF475569);
  static const Color black = Color(0xFF0F172A);

  // Alias for backward compatibility
  static Color get primaryColor => primaryGreen;

  // Gradient Combinations
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryGreen, primaryGreenDark],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [actionAmber, actionAmberDark],
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

  // Text Styles
  static TextStyle get bodyText => const TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSizeMD,
    fontWeight: regular,
    color: deepNavy,
  );

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
      color: deepNavy.withOpacity(0.05),
      blurRadius: 4,
      offset: const Offset(0, 1),
    ),
  ];

  static List<BoxShadow> shadowMD = [
    BoxShadow(
      color: deepNavy.withOpacity(0.08),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> shadowLG = [
    BoxShadow(
      color: deepNavy.withOpacity(0.12),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> shadowXL = [
    BoxShadow(
      color: deepNavy.withOpacity(0.16),
      blurRadius: 24,
      offset: const Offset(0, 8),
    ),
  ];

  // ============== BUTTON STYLES ==============
  static ButtonStyle get primaryButton => ElevatedButton.styleFrom(
    backgroundColor: primaryGreen,
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
  );

  static ButtonStyle get secondaryButton => OutlinedButton.styleFrom(
    foregroundColor: primaryGreen,
    minimumSize: const Size(double.infinity, 48),
    padding: const EdgeInsets.symmetric(
      horizontal: spacingLG,
      vertical: spacingMD,
    ),
    side: const BorderSide(color: primaryGreen, width: 1.5),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radiusSM),
    ),
    textStyle: const TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSizeMD,
      fontWeight: semiBold,
    ),
  );

  static ButtonStyle get actionButton => FilledButton.styleFrom(
    backgroundColor: actionAmber,
    foregroundColor: deepNavy,
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
  );

  // ============== INPUT DECORATION ==============
  static InputDecoration inputDecoration({
    String? hintText,
    String? labelText,
    IconData? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      labelText: labelText,
      prefixIcon: prefixIcon != null ? Icon(prefixIcon, size: 20, color: mediumGray) : null,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: spacingLG,
        vertical: spacingMD,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusSM),
        borderSide: const BorderSide(color: lightGray, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusSM),
        borderSide: const BorderSide(color: lightGray, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusSM),
        borderSide: const BorderSide(color: primaryGreen, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusSM),
        borderSide: const BorderSide(color: error, width: 1),
      ),
      labelStyle: const TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSizeMD,
        color: darkGray,
      ),
      hintStyle: const TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSizeMD,
        color: mediumGray,
      ),
    );
  }

  // ============== TEXT THEME ==============
  static TextTheme _buildTextTheme(TextTheme base) {
    return base.copyWith(
      displayLarge: base.displayLarge?.copyWith(
        fontFamily: fontFamily,
        fontSize: fontSize5XL,
        fontWeight: bold,
        color: deepNavy,
      ),
      displayMedium: base.displayMedium?.copyWith(
        fontFamily: fontFamily,
        fontSize: fontSize4XL,
        fontWeight: bold,
        color: deepNavy,
      ),
      displaySmall: base.displaySmall?.copyWith(
        fontFamily: fontFamily,
        fontSize: fontSize3XL,
        fontWeight: bold,
        color: deepNavy,
      ),
      headlineMedium: base.headlineMedium?.copyWith(
        fontFamily: fontFamily,
        fontSize: fontSize2XL,
        fontWeight: semiBold,
        color: deepNavy,
      ),
      headlineSmall: base.headlineSmall?.copyWith(
        fontFamily: fontFamily,
        fontSize: fontSizeXL,
        fontWeight: semiBold,
        color: deepNavy,
      ),
      titleLarge: base.titleLarge?.copyWith(
        fontFamily: fontFamily,
        fontSize: fontSizeLG,
        fontWeight: semiBold,
        color: deepNavy,
      ),
      titleMedium: base.titleMedium?.copyWith(
        fontFamily: fontFamily,
        fontSize: fontSizeMD,
        fontWeight: medium,
        color: deepNavy,
      ),
      titleSmall: base.titleSmall?.copyWith(
        fontFamily: fontFamily,
        fontSize: fontSizeSM,
        fontWeight: medium,
        color: darkGray,
      ),
      bodyLarge: base.bodyLarge?.copyWith(
        fontFamily: fontFamily,
        fontSize: fontSizeMD,
        fontWeight: regular,
        color: deepNavy,
      ),
      bodyMedium: base.bodyMedium?.copyWith(
        fontFamily: fontFamily,
        fontSize: fontSizeSM,
        fontWeight: regular,
        color: darkGray,
      ),
      bodySmall: base.bodySmall?.copyWith(
        fontFamily: fontFamily,
        fontSize: fontSizeXS,
        fontWeight: regular,
        color: mediumGray,
      ),
      labelLarge: base.labelLarge?.copyWith(
        fontFamily: fontFamily,
        fontSize: fontSizeSM,
        fontWeight: medium,
        letterSpacing: 0.5,
        color: white,
      ),
      labelMedium: base.labelMedium?.copyWith(
        fontFamily: fontFamily,
        fontSize: fontSizeXS,
        fontWeight: medium,
        letterSpacing: 0.5,
        color: white,
      ),
      labelSmall: base.labelSmall?.copyWith(
        fontFamily: fontFamily,
        fontSize: 8.0,
        fontWeight: medium,
        letterSpacing: 0.5,
        color: white,
      ),
    );
  }

  // ============== LIGHT THEME ==============
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: primaryGreen,
    scaffoldBackgroundColor: offWhite,
    colorScheme: const ColorScheme.light(
      primary: primaryGreen,
      secondary: actionAmber,
      tertiary: deepNavy,
      surface: white,
      background: offWhite,
      error: error,
      onPrimary: white,
      onSecondary: deepNavy,
      onSurface: deepNavy,
      onBackground: deepNavy,
      onError: white,
    ),

    // Text Theme
    textTheme: _buildTextTheme(const TextTheme()),

    // AppBar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: white,
      foregroundColor: deepNavy,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSizeLG,
        fontWeight: semiBold,
        color: deepNavy,
      ),
      iconTheme: IconThemeData(
        color: deepNavy,
        size: 24,
      ),
    ),

    // Button Themes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryGreen,
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

    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: actionAmber,
        foregroundColor: deepNavy,
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
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryGreen,
        minimumSize: const Size(double.infinity, 48),
        padding: const EdgeInsets.symmetric(
          horizontal: spacingLG,
          vertical: spacingMD,
        ),
        side: const BorderSide(color: primaryGreen, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusSM),
        ),
        textStyle: const TextStyle(
          fontFamily: fontFamily,
          fontSize: fontSizeMD,
          fontWeight: semiBold,
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryGreen,
        minimumSize: const Size(44, 44),
        padding: const EdgeInsets.symmetric(
          horizontal: spacingMD,
          vertical: spacingSM,
        ),
        textStyle: const TextStyle(
          fontFamily: fontFamily,
          fontSize: fontSizeMD,
          fontWeight: medium,
        ),
      ),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: spacingLG,
        vertical: spacingMD,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusSM),
        borderSide: const BorderSide(color: lightGray, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusSM),
        borderSide: const BorderSide(color: lightGray, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusSM),
        borderSide: const BorderSide(color: primaryGreen, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusSM),
        borderSide: const BorderSide(color: error, width: 1),
      ),
      labelStyle: const TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSizeMD,
        color: darkGray,
      ),
      hintStyle: const TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSizeMD,
        color: mediumGray,
      ),
      errorStyle: const TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSizeSM,
        color: error,
      ),
    ),

    // Card Theme
    cardTheme: CardThemeData(
      color: white,
      elevation: 2,
      shadowColor: deepNavy.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusMD),
      ),
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
    ),

    // Bottom Sheet Theme
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: white,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(radiusLG),
        ),
      ),
    ),

    // Dialog Theme
    dialogTheme: DialogThemeData(
      backgroundColor: white,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusMD),
      ),
      titleTextStyle: const TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSizeXL,
        fontWeight: semiBold,
        color: deepNavy,
      ),
      contentTextStyle: const TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSizeMD,
        color: darkGray,
      ),
    ),

    // Divider Theme
    dividerTheme: const DividerThemeData(
      color: lightGray,
      thickness: 1,
      space: 1,
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: white,
      selectedItemColor: primaryGreen,
      unselectedItemColor: mediumGray,
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

    // Tab Bar Theme
    tabBarTheme: const TabBarThemeData(
      labelColor: primaryGreen,
      unselectedLabelColor: mediumGray,
      indicatorColor: primaryGreen,
      labelStyle: TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSizeMD,
        fontWeight: medium,
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSizeMD,
        fontWeight: regular,
      ),
    ),

    // Checkbox Theme
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return primaryGreen;
        }
        return null;
      }),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusXS),
      ),
    ),

    // Radio Theme
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return primaryGreen;
        }
        return mediumGray;
      }),
    ),

    // Switch Theme
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return primaryGreen;
        }
        return mediumGray;
      }),
      trackColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return primaryGreenLight;
        }
        return lightGray;
      }),
    ),

    // Progress Indicator Theme
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: primaryGreen,
      circularTrackColor: lightGray,
      linearTrackColor: lightGray,
    ),

    // Floating Action Button Theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: actionAmber,
      foregroundColor: deepNavy,
      elevation: 4,
      shape: CircleBorder(),
    ),

    // Snackbar Theme
    snackBarTheme: SnackBarThemeData(
      backgroundColor: deepNavy,
      contentTextStyle: const TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSizeMD,
        color: white,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusSM),
      ),
      behavior: SnackBarBehavior.floating,
    ),
  );
}

// ============== EXTENSIONS FOR EASY ACCESS ==============
extension ThemeExtensions on BuildContext {
  // Access theme colors easily
  Color get primaryGreen => AppTheme.primaryGreen;
  Color get primaryGreenLight => AppTheme.primaryGreenLight;
  Color get primaryGreenDark => AppTheme.primaryGreenDark;
  Color get deepNavy => AppTheme.deepNavy;
  Color get deepNavyLight => AppTheme.deepNavyLight;
  Color get deepNavyDark => AppTheme.deepNavyDark;
  Color get actionAmber => AppTheme.actionAmber;
  Color get actionAmberLight => AppTheme.actionAmberLight;
  Color get actionAmberDark => AppTheme.actionAmberDark;
  Color get success => AppTheme.success;
  Color get error => AppTheme.error;
  Color get warning => AppTheme.warning;
  Color get info => AppTheme.info;
  Color get white => AppTheme.white;
  Color get offWhite => AppTheme.offWhite;
  Color get lightGray => AppTheme.lightGray;
  Color get mediumGray => AppTheme.mediumGray;
  Color get darkGray => AppTheme.darkGray;
  Color get black => AppTheme.black;
  Color get primaryColor => AppTheme.primaryGreen; // Alias for primaryColor

  // Access text styles easily
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
  TextStyle get bodyText => AppTheme.bodyText; // Alias for bodyText

  // Access button styles
  ButtonStyle get primaryButton => AppTheme.primaryButton;
  ButtonStyle get secondaryButton => AppTheme.secondaryButton;
  ButtonStyle get actionButton => AppTheme.actionButton;

  // Access input decoration
  InputDecoration inputDecoration({
    String? hintText,
    String? labelText,
    IconData? prefixIcon,
    Widget? suffixIcon,
  }) => AppTheme.inputDecoration(
    hintText: hintText,
    labelText: labelText,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
  );

  // Access spacing easily
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

  // Access border radius easily
  double get radiusXS => AppTheme.radiusXS;
  double get radiusSM => AppTheme.radiusSM;
  double get radiusMD => AppTheme.radiusMD;
  double get radiusLG => AppTheme.radiusLG;
  double get radiusXL => AppTheme.radiusXL;
  double get radius2XL => AppTheme.radius2XL;
  double get radiusCircular => AppTheme.radiusCircular;

  // Access gradients
  LinearGradient get primaryGradient => AppTheme.primaryGradient;
  LinearGradient get accentGradient => AppTheme.accentGradient;

  // Access shadows
  List<BoxShadow> get shadowSM => AppTheme.shadowSM;
  List<BoxShadow> get shadowMD => AppTheme.shadowMD;
  List<BoxShadow> get shadowLG => AppTheme.shadowLG;
  List<BoxShadow> get shadowXL => AppTheme.shadowXL;
}