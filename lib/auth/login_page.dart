import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pavi/auth/signup_page.dart';
import 'package:pavi/core/general/generalMethods.dart';
import '../core/constant/appString.dart';
import '../home/homeScreen/home_screen.dart';
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
    if (value == null || value.isEmpty) return AppStrings.fieldRequired;

    // Basic email validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return AppStrings.fieldRequired;
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  void _validateEmailAndProceed() {
    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please enter your email'),
          backgroundColor: context.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.radiusSM),
          ),
        ),
      );
      return;
    }

    // Basic email validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(_emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please enter a valid email'),
          backgroundColor: context.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.radiusSM),
          ),
        ),
      );
      return;
    }

    setState(() {
      _isEmailValidated = true;
    });
  }

  void _handleLogin() {
    if (_passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please enter your password'),
          backgroundColor: context.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.radiusSM),
          ),
        ),
      );
      return;
    }

    if (_passwordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Password must be at least 6 characters'),
          backgroundColor: context.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.radiusSM),
          ),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Login successful!'),
          backgroundColor: context.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.radiusSM),
          ),
        ),
      );
      GeneralMethods.navigateTo(context, HomeScreen());
    });
  }

  void _handleSocialLogin(String provider) {
    setState(() => _isLoading = true);

    Future.delayed(const Duration(seconds: 1), () {
      setState(() => _isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$provider login coming soon!'),
          backgroundColor: context.info,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.radiusSM),
          ),
        ),
      );
    });
  }

  void _resetEmail() {
    setState(() {
      _isEmailValidated = false;
      _passwordController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: context.offWhite, // Using theme color
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(context.spacingXL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: context.spacing2XL),
                // Logo/App Name - "rainmaker" (matching the image)
                Center(
                  child: Text(
                    'Pocket Chat', // Changed to match the image
                    style: context.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.deepNavy,
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
                          color: context.primaryGreen.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(context.radiusSM),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.check_circle,
                              size: 16,
                              color: context.primaryGreen,
                            ),
                            SizedBox(width: context.spacingXS),
                            Text(
                              'Email verified',
                              style: context.bodySmall?.copyWith(
                                color: context.primaryGreen,
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
                      color: context.deepNavy,
                    ),
                  ),
                  SizedBox(height: context.spacingSM),
                  Text(
                    "We'll check if you have an account",
                    style: context.bodyLarge?.copyWith(
                      color: context.darkGray,
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
                          color: context.deepNavy,
                        ),
                      ),
                      SizedBox(height: context.spacingSM),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: context.bodyLarge,
                        autofocus: true,
                        onFieldSubmitted: (_) => _validateEmailAndProceed(),
                        decoration: InputDecoration(
                          hintText: 'Eg. someone@mail.com',
                          hintStyle: context.bodyMedium?.copyWith(
                            color: context.mediumGray,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(context.radiusSM),
                            borderSide: BorderSide(color: context.lightGray, width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(context.radiusSM),
                            borderSide: BorderSide(color: context.lightGray, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(context.radiusSM),
                            borderSide: BorderSide(color: context.primaryGreen, width: 2),
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
                            backgroundColor: context.primaryGreen,
                            foregroundColor: Colors.white,
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
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(context.radiusSM),
                        border: Border.all(color: context.lightGray),
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
                                    color: context.darkGray,
                                  ),
                                ),
                                SizedBox(height: context.spacingXS),
                                Text(
                                  _emailController.text,
                                  style: context.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: context.deepNavy,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.edit,
                            size: 20,
                            color: context.primaryGreen,
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
                          color: context.deepNavy,
                        ),
                      ),
                      SizedBox(height: context.spacingSM),
                      Text(
                        'Enter your password to continue',
                        style: context.bodyLarge?.copyWith(
                          color: context.darkGray,
                        ),
                      ),
                      SizedBox(height: context.spacing3XL),

                      TextFormField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        style: context.bodyLarge,
                        autofocus: true,
                        onFieldSubmitted: (_) => _handleLogin(),
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                          hintStyle: context.bodyMedium?.copyWith(
                            color: context.mediumGray,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                              size: 20,
                              color: context.mediumGray,
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
                            borderSide: BorderSide(color: context.lightGray, width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(context.radiusSM),
                            borderSide: BorderSide(color: context.lightGray, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(context.radiusSM),
                            borderSide: BorderSide(color: context.primaryGreen, width: 2),
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
                          ),
                          child: Text(
                            'Forgot password?',
                            style: context.bodySmall?.copyWith(
                              color: context.primaryGreen,
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
                            color: context.primaryGreen,
                          ),
                        )
                            : ElevatedButton(
                          onPressed: _handleLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: context.primaryGreen,
                            foregroundColor: Colors.white,
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
                          color: context.lightGray,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Or Sign Up with', // Changed to match image
                          style: context.bodySmall?.copyWith(
                            color: context.mediumGray,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: context.lightGray,
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
                      side: BorderSide(color: context.lightGray),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(context.radiusSM),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: context.spacingMD,
                      ),
                      minimumSize: const Size(double.infinity, 0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/google_logo2.png",
                          height: 24,
                          width: 24,
                        ),
                        SizedBox(width: context.spacingXS),
                        Text(
                          'Google',
                          style: context.bodyMedium?.copyWith(
                            color: context.deepNavy,
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
                        "Already have an account? ", // Changed to match image
                        style: context.bodyMedium?.copyWith(
                          color: context.darkGray,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // This is already login screen, so maybe navigate to something else
                          // or just do nothing
                        },
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'Sign In', // Changed to match image
                          style: context.bodyMedium?.copyWith(
                            color: context.primaryGreen,
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
                          color: context.darkGray,
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
                        ),
                        child: Text(
                          'Sign Up',
                          style: context.bodyMedium?.copyWith(
                            color: context.primaryGreen,
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