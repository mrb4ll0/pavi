import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pavi/auth/signup_page.dart';
import '../theme/generalTheme.dart';




class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  bool _rememberMe = false;
  bool _isEmailValidated = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  void _validateEmailAndProceed() {
    if (_emailController.text.isEmpty) {
      _showSnackBar('Please enter your email', isError: true);
      return;
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(_emailController.text)) {
      _showSnackBar('Please enter a valid email', isError: true);
      return;
    }

    setState(() {
      _isEmailValidated = true;
    });
  }

  void _handleLogin() {
    if (_passwordController.text.isEmpty) {
      _showSnackBar('Please enter your password', isError: true);
      return;
    }

    if (_passwordController.text.length < 6) {
      _showSnackBar('Password must be at least 6 characters', isError: true);
      return;
    }

    setState(() => _isLoading = true);

    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _isLoading = false);
      _showSnackBar('Login successful!', isSuccess: true);
      // Navigate to home screen
      // GeneralMethods.navigateTo(context, HomeScreen());
    });
  }

  void _handleSocialLogin(String provider) {
    setState(() => _isLoading = true);

    Future.delayed(const Duration(seconds: 1), () {
      setState(() => _isLoading = false);
      _showSnackBar('$provider login coming soon!', isInfo: true);
    });
  }

  void _showSnackBar(String message, {bool isError = false, bool isSuccess = false, bool isInfo = false}) {
    Color backgroundColor;
    if (isError) {
      backgroundColor = context.error;
    } else if (isSuccess) {
      backgroundColor = context.success;
    } else if (isInfo) {
      backgroundColor = context.info;
    } else {
      backgroundColor = Theme.of(context).brightness == Brightness.dark
          ? context.darkSurface
          : context.primaryPurple;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.radiusSM),
        ),
      ),
    );
  }

  void _resetEmail() {
    setState(() {
      _isEmailValidated = false;
      _passwordController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: isDark
          ? SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      )
          : SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: isDark ? context.darkBackground : context.lightBackground,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(context.spacingXL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: context.spacing2XL),

                // App Name - "Pocket Chat"
                Center(
                  child: Text(
                    'Pocket Chat',
                    style: context.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isDark ? context.darkTextPrimary : context.primaryPurple,
                      letterSpacing: 1,
                      fontSize: 32,
                    ),
                  ),
                ),

                SizedBox(height: context.spacing3XL * 2),

                // Step indicator
                if (_isEmailValidated) ...[
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.spacingSM,
                          vertical: context.spacingXS,
                        ),
                        decoration: BoxDecoration(
                          color: (isDark ? context.accentPurple : context.primaryPurple).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(context.radiusSM),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.check_circle,
                              size: 16,
                              color: isDark ? context.accentPurple : context.primaryPurple,
                            ),
                            SizedBox(width: context.spacingXS),
                            Text(
                              'Email verified',
                              style: context.bodySmall?.copyWith(
                                color: isDark ? context.accentPurple : context.primaryPurple,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.spacingMD),
                ],

                // Email Section
                if (!_isEmailValidated) ...[
                  Text(
                    'Enter your email',
                    style: context.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.textPrimary,
                    ),
                  ),
                  SizedBox(height: context.spacingSM),
                  Text(
                    "We'll check if you have an account",
                    style: context.bodyLarge?.copyWith(
                      color: context.textSecondary,
                    ),
                  ),
                  SizedBox(height: context.spacing3XL),

                  // Email Field
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email',
                        style: context.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: context.textPrimary,
                        ),
                      ),
                      SizedBox(height: context.spacingSM),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: context.bodyLarge?.copyWith(
                          color: context.textPrimary,
                        ),
                        autofocus: true,
                        onFieldSubmitted: (_) => _validateEmailAndProceed(),
                        decoration: InputDecoration(
                          hintText: 'Eg. someone@mail.com',
                          hintStyle: context.bodyMedium?.copyWith(
                            color: context.textHint,
                          ),
                          filled: true,
                          fillColor: isDark ? context.darkCard : context.white,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(context.radiusSM),
                            borderSide: BorderSide(
                                color: isDark ? context.darkTextHint.withOpacity(0.3) : context.lightGray,
                                width: 1
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(context.radiusSM),
                            borderSide: BorderSide(
                                color: isDark ? context.darkTextHint.withOpacity(0.3) : context.lightGray,
                                width: 1
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(context.radiusSM),
                            borderSide: BorderSide(
                                color: isDark ? context.accentPurple : context.primaryPurple,
                                width: 2
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: context.spacingXL),

                      // Continue Button
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: _validateEmailAndProceed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isDark ? context.accentPurple : context.primaryPurple,
                            foregroundColor: isDark ? context.darkTextPrimary : context.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(context.radiusSM),
                            ),
                          ),
                          child: Text(
                            'Continue',
                            style: context.labelLarge?.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: isDark ? context.darkTextPrimary : context.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],

                // Password Section (shown after email validation)
                if (_isEmailValidated) ...[
                  // Email display with edit option
                  GestureDetector(
                    onTap: _resetEmail,
                    child: Container(
                      padding: EdgeInsets.all(context.spacingMD),
                      decoration: BoxDecoration(
                        color: isDark ? context.darkCard : context.white,
                        borderRadius: BorderRadius.circular(context.radiusSM),
                        border: Border.all(
                          color: isDark ? context.darkTextHint.withOpacity(0.3) : context.lightGray,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Email',
                                  style: context.bodySmall?.copyWith(
                                    color: context.textSecondary,
                                  ),
                                ),
                                SizedBox(height: context.spacingXS),
                                Text(
                                  _emailController.text,
                                  style: context.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: context.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.edit,
                            size: 20,
                            color: isDark ? context.accentPurple : context.primaryPurple,
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: context.spacing3XL),

                  // Password Field
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Password',
                        style: context.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.textPrimary,
                        ),
                      ),
                      SizedBox(height: context.spacingSM),
                      Text(
                        'Enter your password to continue',
                        style: context.bodyLarge?.copyWith(
                          color: context.textSecondary,
                        ),
                      ),
                      SizedBox(height: context.spacing3XL),

                      TextFormField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        style: context.bodyLarge?.copyWith(
                          color: context.textPrimary,
                        ),
                        autofocus: true,
                        onFieldSubmitted: (_) => _handleLogin(),
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                          hintStyle: context.bodyMedium?.copyWith(
                            color: context.textHint,
                          ),
                          filled: true,
                          fillColor: isDark ? context.darkCard : context.white,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                              size: 20,
                              color: context.textHint,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(context.radiusSM),
                            borderSide: BorderSide(
                                color: isDark ? context.darkTextHint.withOpacity(0.3) : context.lightGray,
                                width: 1
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(context.radiusSM),
                            borderSide: BorderSide(
                                color: isDark ? context.darkTextHint.withOpacity(0.3) : context.lightGray,
                                width: 1
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(context.radiusSM),
                            borderSide: BorderSide(
                                color: isDark ? context.accentPurple : context.primaryPurple,
                                width: 2
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: context.spacingMD),

                      // Forgot Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // Handle forgot password
                          },
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            foregroundColor: isDark ? context.accentPurple : context.primaryPurple,
                          ),
                          child: Text(
                            'Forgot password?',
                            style: context.bodySmall?.copyWith(
                              color: isDark ? context.accentPurple : context.primaryPurple,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: context.spacing3XL),

                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: _isLoading
                            ? Center(
                          child: CircularProgressIndicator(
                            color: isDark ? context.accentPurple : context.primaryPurple,
                          ),
                        )
                            : ElevatedButton(
                          onPressed: _handleLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isDark ? context.accentPurple : context.primaryPurple,
                            foregroundColor: isDark ? context.darkTextPrimary : context.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(context.radiusSM),
                            ),
                          ),
                          child: Text(
                            'Sign In',
                            style: context.labelLarge?.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: isDark ? context.darkTextPrimary : context.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: context.spacing3XL),

                  // Divider
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: isDark ? context.darkTextHint.withOpacity(0.3) : context.lightGray,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Or Sign Up with',
                          style: context.bodySmall?.copyWith(
                            color: context.textHint,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: isDark ? context.darkTextHint.withOpacity(0.3) : context.lightGray,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: context.spacingXL),

                  // Google Sign In Button
                  OutlinedButton(
                    onPressed: () => _handleSocialLogin('Google'),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: isDark ? context.darkTextHint.withOpacity(0.3) : context.lightGray,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(context.radiusSM),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: context.spacingMD,
                      ),
                      minimumSize: const Size(double.infinity, 0),
                      foregroundColor: context.textPrimary,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Make sure this asset exists or use Icon
                        Icon(
                          Icons.g_mobiledata,
                          size: 32,
                          color: isDark ? context.darkTextPrimary : context.primaryPurple,
                        ),
                        SizedBox(width: context.spacingXS),
                        Text(
                          'Google',
                          style: context.bodyMedium?.copyWith(
                            color: context.textPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                // Sign Up Link (shown in both states)
                if (!_isEmailValidated) ...[
                  SizedBox(height: context.spacing3XL),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: context.bodyMedium?.copyWith(
                          color: context.textSecondary,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignupScreen(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          foregroundColor: isDark ? context.accentPurple : context.primaryPurple,
                        ),
                        child: Text(
                          'Sign Up',
                          style: context.bodyMedium?.copyWith(
                            color: isDark ? context.accentPurple : context.primaryPurple,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ] else ...[
                  SizedBox(height: context.spacingXL),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: context.bodyMedium?.copyWith(
                          color: context.textSecondary,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignupScreen(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          foregroundColor: isDark ? context.accentPurple : context.primaryPurple,
                        ),
                        child: Text(
                          'Sign Up',
                          style: context.bodyMedium?.copyWith(
                            color: isDark ? context.accentPurple : context.primaryPurple,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

