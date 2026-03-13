import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/constant/appString.dart';
import '../core/general/generalMethods.dart';
import '../home/homeScreen/home_screen.dart';
import '../theme/generalTheme.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _otpControllers = List.generate(6, (_) => TextEditingController());
  final _otpFocusNodes = List.generate(6, (_) => FocusNode());

  int _currentStep = 1; // 1: Personal Info, 2: Email & Password, 3: OTP
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  bool _isResendEnabled = true;
  int _resendTimer = 30;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _otpFocusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _startResendTimer() {
    _isResendEnabled = false;
    _resendTimer = 30;

    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          if (_resendTimer > 0) {
            _resendTimer--;
            _startResendTimer();
          } else {
            _isResendEnabled = true;
          }
        });
      }
    });
  }

  void _onOtpChanged(int index, String value) {
    if (value.length == 1 && index < 5) {
      _otpFocusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _otpFocusNodes[index - 1].requestFocus();
    }
  }

  String _getOtpCode() {
    return _otpControllers.map((c) => c.text).join();
  }

  void _handlePersonalInfoNext() {
    if (_firstNameController.text.isEmpty) {
      _showError('Please enter your first name');
      return;
    }
    if (_firstNameController.text.length < 2) {
      _showError('First name must be at least 2 characters');
      return;
    }
    if (_lastNameController.text.isEmpty) {
      _showError('Please enter your last name');
      return;
    }
    if (_lastNameController.text.length < 2) {
      _showError('Last name must be at least 2 characters');
      return;
    }
    if (_usernameController.text.isEmpty) {
      _showError('Please enter a username');
      return;
    }
    if (_usernameController.text.length < 3) {
      _showError('Username must be at least 3 characters');
      return;
    }
    final usernameRegex = RegExp(r'^[a-zA-Z0-9_]+$');
    if (!usernameRegex.hasMatch(_usernameController.text)) {
      _showError('Username can only contain letters, numbers, and underscores');
      return;
    }

    setState(() {
      _currentStep = 2;
    });
  }

  void _handleEmailPasswordNext() {
    if (_emailController.text.isEmpty) {
      _showError('Please enter your email');
      return;
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(_emailController.text)) {
      _showError('Please enter a valid email');
      return;
    }
    if (_passwordController.text.isEmpty) {
      _showError('Please enter a password');
      return;
    }
    if (_passwordController.text.length < 6) {
      _showError('Password must be at least 6 characters');
      return;
    }

    setState(() => _isLoading = true);

    // Simulate API call to send OTP
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
        _currentStep = 3;
      });
      _startResendTimer();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('OTP sent to ${_emailController.text}'),
          backgroundColor: context.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.radiusSM),
          ),
        ),
      );
    });
  }

  void _handleVerifyOtp() {
    final otpCode = _getOtpCode();

    if (otpCode.length != 6) {
      _showError('Please enter a valid 6-digit OTP');
      return;
    }

    setState(() => _isLoading = true);

    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Account created successfully!'),
          backgroundColor: context.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.radiusSM),
          ),
        ),
      );
      // Navigate to home screen
      // GeneralMethods.navigateTo(context, HomeScreen());
    });
  }

  void _handleResendOtp() {
    if (!_isResendEnabled) return;

    setState(() {
      _isResendEnabled = false;
      _resendTimer = 30;
    });

    _startResendTimer();

    for (var controller in _otpControllers) {
      controller.clear();
    }
    _otpFocusNodes[0].requestFocus();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('New code sent to ${_emailController.text}'),
        backgroundColor: context.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.radiusSM),
        ),
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: context.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.radiusSM),
        ),
      ),
    );
  }

  void _goToPreviousStep() {
    if (_currentStep > 1) {
      setState(() {
        _currentStep--;
      });
    } else {
      Navigator.pop(context);
    }
  }

  String _getStepTitle() {
    switch (_currentStep) {
      case 1:
        return 'Personal Information';
      case 2:
        return 'Email & Password';
      case 3:
        return 'Verification';
      default:
        return 'Sign Up';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: isDark
          ? const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      )
          : const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: context.backgroundColor,
        appBar: AppBar(
          backgroundColor: context.surfaceColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: context.textPrimary,
            ),
            onPressed: _goToPreviousStep,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Step $_currentStep of 3',
                style: context.bodySmall?.copyWith(
                  color: context.textSecondary,
                ),
              ),
              Text(
                _getStepTitle(),
                style: context.bodyMedium?.copyWith(
                  color: context.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: _buildCurrentStep(),
        ),
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 1:
        return _buildPersonalInfoForm();
      case 2:
        return _buildEmailPasswordForm();
      case 3:
        return _buildOtpVerification();
      default:
        return _buildPersonalInfoForm();
    }
  }

  Widget _buildPersonalInfoForm() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: EdgeInsets.all(context.spacingXL),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // App Name
          Center(
            child: Text(
              'Pocket Chat',
              style: context.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: isDark ? context.darkTextPrimary : context.primaryColor,
                letterSpacing: 1,
                fontSize: 32,
              ),
            ),
          ),

          SizedBox(height: context.spacing3XL * 2),

          // First Name Field
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'First Name:',
                style: context.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.textPrimary,
                ),
              ),
              SizedBox(height: context.spacingSM),
              TextFormField(
                controller: _firstNameController,
                style: context.bodyText,
                autofocus: true,
                onFieldSubmitted: (_) => _handlePersonalInfoNext(),
                decoration: context.inputDecoration(
                  hintText: 'eg. John',
                ),
              ),
            ],
          ),

          SizedBox(height: context.spacingXL),

          // Last Name Field
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Last Name:',
                style: context.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.textPrimary,
                ),
              ),
              SizedBox(height: context.spacingSM),
              TextFormField(
                controller: _lastNameController,
                style: context.bodyText,
                onFieldSubmitted: (_) => _handlePersonalInfoNext(),
                decoration: context.inputDecoration(
                  hintText: 'eg. Doe',
                ),
              ),
            ],
          ),

          SizedBox(height: context.spacingXL),

          // Username Field
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Username:',
                style: context.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.textPrimary,
                ),
              ),
              SizedBox(height: context.spacingSM),
              TextFormField(
                controller: _usernameController,
                style: context.bodyText,
                onFieldSubmitted: (_) => _handlePersonalInfoNext(),
                decoration: context.inputDecoration(
                  hintText: 'eg. nick123',
                ),
              ),
            ],
          ),

          SizedBox(height: context.spacing3XL * 2),

          // Continue Button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: _handlePersonalInfoNext,
              style: context.primaryButton,
              child: Text(
                'Continue',
                style: context.labelLarge?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          SizedBox(height: context.spacingXL),

          // Login Link
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an account? ',
                style: context.bodyMedium?.copyWith(
                  color: context.textSecondary,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  foregroundColor: isDark ? context.accentPurple : context.primaryColor,
                ),
                child: Text(
                  'Sign In',
                  style: context.bodyMedium?.copyWith(
                    color: isDark ? context.accentPurple : context.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: context.spacingXL),
        ],
      ),
    );
  }

  Widget _buildEmailPasswordForm() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: EdgeInsets.all(context.spacingXL),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary of previous step
          Container(
            padding: EdgeInsets.all(context.spacingMD),
            decoration: BoxDecoration(
              color: isDark ? context.darkCard : context.white,
              borderRadius: BorderRadius.circular(context.radiusSM),
              border: Border.all(
                color: isDark ? context.darkTextHint.withOpacity(0.3) : context.lightGray,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Personal Information',
                  style: context.bodySmall?.copyWith(
                    color: context.textSecondary,
                  ),
                ),
                SizedBox(height: context.spacingXS),
                Text(
                  '${_firstNameController.text} ${_lastNameController.text} (@${_usernameController.text})',
                  style: context.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.textPrimary,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: context.spacing3XL),

          // Email Field
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Email:',
                style: context.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.textPrimary,
                ),
              ),
              SizedBox(height: context.spacingSM),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: context.bodyText,
                autofocus: true,
                onFieldSubmitted: (_) => _handleEmailPasswordNext(),
                decoration: context.inputDecoration(
                  hintText: 'eg. john.doe@example.com',
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
                'Password:',
                style: context.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.textPrimary,
                ),
              ),
              SizedBox(height: context.spacingSM),
              TextFormField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                style: context.bodyText,
                onFieldSubmitted: (_) => _handleEmailPasswordNext(),
                decoration: context.inputDecoration(
                  hintText: 'Enter your password',
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
                ),
              ),
            ],
          ),

          SizedBox(height: context.spacing3XL * 2),

          // Next Button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: _isLoading
                ? Center(
              child: CircularProgressIndicator(
                color: isDark ? context.accentPurple : context.primaryColor,
              ),
            )
                : ElevatedButton(
              onPressed: _handleEmailPasswordNext,
              style: context.primaryButton,
              child: Text(
                'Send Verification Code',
                style: context.labelLarge?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtpVerification() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: EdgeInsets.all(context.spacingXL),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Verification Code',
            style: context.headlineSmall?.copyWith(
              color: context.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: context.spacingXS),

          RichText(
            text: TextSpan(
              style: context.bodyLarge?.copyWith(
                color: context.textSecondary,
              ),
              children: [
                const TextSpan(text: 'We sent a 6-digit code to '),
                TextSpan(
                  text: _emailController.text,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: context.textPrimary,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: context.spacing4XL),

          // OTP Input Fields
          LayoutBuilder(
              builder: (context, constraints) {
                double boxSize = (constraints.maxWidth - (context.spacingSM * 5)) / 6;
                boxSize = boxSize.clamp(45.0, 55.0);

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (index) {
                    return Container(
                      width: boxSize,
                      height: boxSize + 8,
                      decoration: BoxDecoration(
                        color: isDark ? context.darkCard : context.white,
                        borderRadius: BorderRadius.circular(context.radiusSM),
                        border: Border.all(
                          color: isDark ? context.darkTextHint.withOpacity(0.3) : context.lightGray,
                          width: 1,
                        ),
                        boxShadow: isDark ? null : context.shadowSM,
                      ),
                      child: TextField(
                        controller: _otpControllers[index],
                        focusNode: _otpFocusNodes[index],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: context.titleLarge?.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: context.textPrimary,
                        ),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          counterText: '',
                          contentPadding: EdgeInsets.zero,
                        ),
                        onChanged: (value) => _onOtpChanged(index, value),
                      ),
                    );
                  }),
                );
              }
          ),

          SizedBox(height: context.spacing3XL),

          // Resend Timer
          Center(
            child: Column(
              children: [
                Text(
                  "Didn't receive the code?",
                  style: context.bodyMedium?.copyWith(
                    color: context.textSecondary,
                  ),
                ),
                SizedBox(height: context.spacingXS),
                if (!_isResendEnabled)
                  Text(
                    'Resend in 00:${_resendTimer.toString().padLeft(2, '0')}',
                    style: context.bodyMedium?.copyWith(
                      color: context.textHint,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                else
                  TextButton(
                    onPressed: _handleResendOtp,
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      foregroundColor: isDark ? context.accentPurple : context.primaryColor,
                    ),
                    child: Text(
                      'Resend Code',
                      style: context.bodyMedium?.copyWith(
                        color: isDark ? context.accentPurple : context.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: context.spacing4XL),

          // Submit Button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: _isLoading
                ? Center(
              child: CircularProgressIndicator(
                color: isDark ? context.accentPurple : context.primaryColor,
              ),
            )
                : ElevatedButton(
              onPressed: _handleVerifyOtp,
              style: context.primaryButton,
              child: Text(
                'Submit',
                style: context.labelLarge?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}