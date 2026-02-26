import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/constant/appString.dart';
import '../core/general/generalMethods.dart';
import '../home/home_screen.dart';
import '../theme/generalTheme.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _identifierController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _otpControllers = List.generate(6, (_) => TextEditingController());
  final _otpFocusNodes = List.generate(6, (_) => FocusNode());

  int _currentStep = 1; // 1: Signup, 2: OTP
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;
  bool _agreeToTerms = false;
  bool _isResendEnabled = true;
  int _resendTimer = 30;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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

  String? _validateIdentifier(String? value) {
    if (value == null || value.isEmpty) return AppStrings.fieldRequired;
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    final phoneRegex = RegExp(r'^(?:\+234|0)[7-9][0-1]\d{8}$');
    if (!emailRegex.hasMatch(value) && !phoneRegex.hasMatch(value)) {
      return 'Enter a valid email or Nigerian phone number';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return AppStrings.fieldRequired;
    if (value.length < 6) return AppStrings.invalidPassword;
    return null;
  }

  void _handleSignUp() {
    if (_formKey.currentState?.validate() ?? false) {
      if (!_agreeToTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Please agree to the terms to continue'),
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

      // Simulate API call
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
          _currentStep = 2;
        });
        _startResendTimer();
      });
    }
  }

  void _handleVerifyOtp() {
    final otpCode = _getOtpCode();

    if (otpCode.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppStrings.invalidOtp),
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
          content: const Text('Account created successfully!'),
          backgroundColor: context.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.radiusSM),
          ),
        ),
      );
      // Navigate to home screen
      GeneralMethods.navigateTo(context, const HomeScreen());
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
        content: Text('New code sent to ${_identifierController.text}'),
        backgroundColor: context.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.radiusSM),
        ),
      ),
    );
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
            onPressed: () {
              if (_currentStep == 2) {
                setState(() => _currentStep = 1);
              } else {
                Navigator.pop(context);
              }
            },
          ),
          title: _currentStep == 2
              ? Text(
            'Step 2 of 2',
            style: context.bodyMedium?.copyWith(
              color: context.mediumGray,
            ),
          )
              : null,
        ),
        body: SafeArea(
          child: _currentStep == 1
              ? _buildSignupForm()
              : _buildOtpVerification(),
        ),
      ),
    );
  }

  Widget _buildSignupForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(context.spacingXL),
      physics: const BouncingScrollPhysics(),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.createAccount,
              style: context.headlineMedium?.copyWith(
                color: context.deepNavy,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: context.spacingXS),

            Text(
              AppStrings.signUpSubtitle,
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

            SizedBox(height: context.spacingXL),

            // Confirm Password Field
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Confirm Password',
                  style: context.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.deepNavy,
                  ),
                ),
                SizedBox(height: context.spacingSM),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: !_isConfirmPasswordVisible,
                  validator: (value) {
                    if (value == null || value.isEmpty) return AppStrings.fieldRequired;
                    if (value != _passwordController.text) return AppStrings.passwordsDontMatch;
                    return null;
                  },
                  style: context.bodyLarge,
                  decoration: InputDecoration(
                    hintText: 'Confirm your password',
                    hintStyle: context.bodyMedium?.copyWith(
                      color: context.mediumGray,
                    ),
                    prefixIcon: Icon(Icons.lock_outline, size: 20, color: context.mediumGray),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isConfirmPasswordVisible ? Icons.visibility_off : Icons.visibility,
                        size: 20,
                        color: context.mediumGray,
                      ),
                      onPressed: () {
                        setState(() {
                          _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
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

            SizedBox(height: context.spacingXL),

            // Terms Checkbox
            Row(
              children: [
                SizedBox(
                  height: 24,
                  width: 24,
                  child: Checkbox(
                    value: _agreeToTerms,
                    onChanged: (value) {
                      setState(() {
                        _agreeToTerms = value ?? false;
                      });
                    },
                    activeColor: context.primaryGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(context.radiusXS),
                    ),
                  ),
                ),
                SizedBox(width: context.spacingSM),
                Expanded(
                  child: Text(
                    AppStrings.agreeToTerms,
                    style: context.bodySmall?.copyWith(
                      color: context.darkGray,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: context.spacing3XL),

            // Sign Up Button
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
                onPressed: _handleSignUp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.primaryGreen,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(context.radiusSM),
                  ),
                ),
                child: Text(
                  AppStrings.continue_,
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
                  AppStrings.alreadyHaveAccount,
                  style: context.bodyMedium?.copyWith(
                    color: context.darkGray,
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
                  ),
                  child: Text(
                    AppStrings.login,
                    style: context.bodyMedium?.copyWith(
                      color: context.primaryGreen,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: context.spacingXL),
          ],
        ),
      ),
    );
  }

  Widget _buildOtpVerification() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(context.spacingXL),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.verifyYourNumber,
            style: context.headlineMedium?.copyWith(
              color: context.deepNavy,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: context.spacingXS),

          RichText(
            text: TextSpan(
              style: context.bodyLarge?.copyWith(
                color: context.darkGray,
              ),
              children: [
                const TextSpan(text: '${AppStrings.otpSent} '),
                TextSpan(
                  text: _identifierController.text,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: context.spacing4XL),

          // OTP Input Fields
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(6, (index) {
              return Container(
                width: 50,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(context.radiusSM),
                  border: Border.all(
                    color: context.lightGray,
                    width: 1,
                  ),
                  boxShadow: context.shadowSM,
                ),
                child: TextField(
                  controller: _otpControllers[index],
                  focusNode: _otpFocusNodes[index],
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: context.titleLarge?.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    counterText: '',
                  ),
                  onChanged: (value) => _onOtpChanged(index, value),
                ),
              );
            }),
          ),

          SizedBox(height: context.spacing3XL),

          // Resend Timer
          Center(
            child: Column(
              children: [
                Text(
                  AppStrings.didntReceiveCode,
                  style: context.bodyMedium?.copyWith(
                    color: context.darkGray,
                  ),
                ),
                SizedBox(height: context.spacingXS),
                if (!_isResendEnabled)
                  Text(
                    '${AppStrings.resendIn}00:${_resendTimer.toString().padLeft(2, '0')}',
                    style: context.bodyMedium?.copyWith(
                      color: context.mediumGray,
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
                    ),
                    child: Text(
                      AppStrings.resendCode,
                      style: context.bodyMedium?.copyWith(
                        color: context.primaryGreen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: context.spacing4XL),

          // Verify Button
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
              onPressed: _handleVerifyOtp,
              style: ElevatedButton.styleFrom(
                backgroundColor: context.primaryGreen,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(context.radiusSM),
                ),
              ),
              child: Text(
                AppStrings.verify,
                style: context.labelLarge?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          SizedBox(height: context.spacingMD),

          // Go Back Button
          Center(
            child: TextButton(
              onPressed: () {
                setState(() => _currentStep = 1);
              },
              child: Text(
                'Go Back',
                style: context.bodyMedium?.copyWith(
                  color: context.mediumGray,
                ),
              ),
            ),
          ),
          SizedBox(height: context.spacingXL),
        ],
      ),
    );
  }
}