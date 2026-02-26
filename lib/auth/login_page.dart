import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pavi/auth/signup_page.dart';
import 'package:pavi/core/general/generalMethods.dart';
import '../core/constant/appString.dart';
import '../home/home_screen.dart';
import '../theme/generalTheme.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _identifierController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  bool _rememberMe = false;

  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateIdentifier(String? value) {
    if (value == null || value.isEmpty) return AppStrings.fieldRequired;
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return AppStrings.fieldRequired;
    return null;
  }

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
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
        // below need to be changed to replaceWith , but for now it will be navigateTo
        GeneralMethods.navigateTo(context, const HomeScreen());
      });
    }
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

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: context.offWhite,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: context.deepNavy),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(context.spacingXL),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Text(
                    AppStrings.welcomeBack,
                    style: context.headlineMedium?.copyWith(
                      color: context.deepNavy,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: context.spacingXS),

                  Text(
                    AppStrings.loginSubtitle,
                    style: context.bodyLarge?.copyWith(
                      color: context.darkGray,
                    ),
                  ),

                  SizedBox(height: context.spacing3XL),

                  // Email/Phone Field
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.emailOrPhone,
                        style: context.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: context.deepNavy,
                        ),
                      ),
                      SizedBox(height: context.spacingSM),
                      TextFormField(
                        controller: _identifierController,
                        keyboardType: TextInputType.emailAddress,
                        validator: _validateIdentifier,
                        style: context.bodyLarge,
                        decoration: InputDecoration(
                          hintText: AppStrings.emailHint,
                          hintStyle: context.bodyMedium?.copyWith(
                            color: context.mediumGray,
                          ),
                          prefixIcon: Icon(Icons.person_outline, size: 20, color: context.mediumGray),
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
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(context.radiusSM),
                            borderSide: BorderSide(color: context.error, width: 1),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: context.spacingXL),

                  // Password Field
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.password,
                        style: context.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: context.deepNavy,
                        ),
                      ),
                      SizedBox(height: context.spacingSM),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        validator: _validatePassword,
                        style: context.bodyLarge,
                        decoration: InputDecoration(
                          hintText: AppStrings.passwordHint,
                          hintStyle: context.bodyMedium?.copyWith(
                            color: context.mediumGray,
                          ),
                          prefixIcon: Icon(Icons.lock_outline, size: 20, color: context.mediumGray),
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
                    ],
                  ),

                  SizedBox(height: context.spacingMD),

                  // Remember Me & Forgot Password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 24,
                            width: 24,
                            child: Checkbox(
                              value: _rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  _rememberMe = value ?? false;
                                });
                              },
                              activeColor: context.primaryGreen,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(context.radiusXS),
                              ),
                            ),
                          ),
                          SizedBox(width: context.spacingXS),
                          Text(
                            'Remember me',
                            style: context.bodySmall?.copyWith(
                              color: context.darkGray,
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          // Handle forgot password
                        },
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          AppStrings.forgotPassword,
                          style: context.bodySmall?.copyWith(
                            color: context.primaryGreen,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
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
                        AppStrings.login,
                        style: context.labelLarge?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: context.spacingXL),

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
                          'Or continue with',
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

                  // Social Login Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => _handleSocialLogin('Google'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: context.primaryGreen,
                            side: BorderSide(color: context.lightGray),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(context.radiusSM),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: context.spacingMD,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.g_mobiledata, size: 20),
                              SizedBox(width: context.spacingXS),
                              Text(
                                'Google',
                                style: context.bodyMedium?.copyWith(
                                  color: context.deepNavy,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: context.spacingMD),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => _handleSocialLogin('Apple'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: context.deepNavy,
                            side: BorderSide(color: context.lightGray),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(context.radiusSM),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: context.spacingMD,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.apple, size: 20),
                              SizedBox(width: context.spacingXS),
                              Text(
                                'Apple',
                                style: context.bodyMedium?.copyWith(
                                  color: context.deepNavy,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: context.spacing3XL),

                  // Sign Up Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.dontHaveAccount,
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
                          AppStrings.signUp,
                          style: context.bodyMedium?.copyWith(
                            color: context.primaryGreen,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}