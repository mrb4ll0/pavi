import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pavi/auth/signup_page.dart';
import 'package:pavi/core/general/generalMethods.dart';
import 'package:pavi/home/homeScreen/home_screen.dart';
import '../core/constant/appString.dart';
import '../theme/generalTheme.dart';
import 'login_page.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: context.offWhite,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(context.spacingXL),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo with gradient background
                  Container(
                    width: 120,
                    height: 120,
                    margin: EdgeInsets.only(top: context.spacingXL),
                    decoration: BoxDecoration(
                      gradient: context.primaryGradient,
                      shape: BoxShape.circle,
                      boxShadow: context.shadowMD,
                    ),
                    child: const Icon(
                      Icons.phone_in_talk,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
              
                  SizedBox(height: context.spacing2XL),
              
                  // App Name
                  Text(
                    AppStrings.appName,
                    style: context.displaySmall?.copyWith(
                      color: context.deepNavy,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              
                  SizedBox(height: context.spacingMD),
              
                  // Description
                  Text(
                    AppStrings.appDescription,
                    textAlign: TextAlign.center,
                    style: context.bodyLarge?.copyWith(
                      color: context.darkGray,
                      height: 1.5,
                    ),
                  ),
              
                  SizedBox(height: context.spacing2XL),
              
                  // Feature highlights
                  _buildFeatureRow(
                    context,
                    Icons.security,
                    'Secure End-to-End Encryption',
                  ),
                  SizedBox(height: context.spacingMD),
                  _buildFeatureRow(
                    context,
                    Icons.sim_card,
                    'Buy eSIM & Data Plans',
                  ),
                  SizedBox(height: context.spacingMD),
                  _buildFeatureRow(
                    context,
                    Icons.phone_forwarded,
                    'Virtual Nigerian Number',
                  ),

                  SizedBox(height: context.spacing2XL),
              
                  // Sign Up Button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.primaryGreen,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(context.radiusSM),
                        ),
                      ),
                      child: Text(
                        AppStrings.signUp,
                        style: context.labelLarge?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
              
                  SizedBox(height: context.spacingMD),
              
                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: context.deepNavy,
                        side: BorderSide(color: context.primaryGreen, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(context.radiusSM),
                        ),
                      ),
                      child: Text(
                        AppStrings.login,
                        style: context.bodyLarge?.copyWith(
                          color: context.primaryGreen,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
              
                  SizedBox(height: context.spacingMD),
              
                  // Guest Mode
                  TextButton(
                    onPressed: () {
                      // Handle guest mode
                      GeneralMethods.navigateTo(context, HomeScreen());
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: context.mediumGray,
                    ),
                    child: Text(
                      AppStrings.continueAsGuest,
                      style: context.bodyMedium,
                    ),
                  ),

                  SizedBox(height: context.spacingLG),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureRow(BuildContext context, IconData icon, String text) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(context.spacingXS),
          decoration: BoxDecoration(
            color: context.primaryGreen.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 20,
            color: context.primaryGreen,
          ),
        ),
        SizedBox(width: context.spacingMD),
        Text(
          text,
          style: context.bodyMedium?.copyWith(
            color: context.deepNavy,
          ),
        ),
      ],
    );
  }
}