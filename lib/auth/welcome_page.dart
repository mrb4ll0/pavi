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
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: context.offWhite,
        body: Stack(
          children: [
            // Background Image
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/images/paviWelcome.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3),
                    BlendMode.darken,
                  ),
                ),
              ),
            ),

            // Content
            SafeArea(
              child: Padding(
                padding: EdgeInsets.all(context.spacingXL),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Top Section with Welcome Text
                    Column(
                      children: [
                        SizedBox(height: context.spacing2XL * 2),

                        // Welcome Text
                        Text(
                          'Welcome to',
                          style: context.displaySmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                        Text(
                          'Pocket Chat',
                          style: context.displayLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 48,
                          ),
                        ),
                      ],
                    ),

                    // Middle Section with Description
                    Column(
                      children: [
                        Text(
                          'Chat. Train AI. Earn Coins.',
                          textAlign: TextAlign.center,
                          style: context.displaySmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                          ),
                        ),
                        SizedBox(height: context.spacingSM),
                        Text(
                          "It's that simple",
                          textAlign: TextAlign.center,
                          style: context.headlineMedium?.copyWith(
                            color: Colors.white.withOpacity(0.9),
                            fontWeight: FontWeight.w400,
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),

                    // Bottom Section with Get Started Button
                    Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 56,
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
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(context.radiusSM),
                              ),
                            ),
                            child: Text(
                              'Get Started',
                              style: context.labelLarge?.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: context.deepNavy,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: context.spacingMD),

                        // Login Link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account? ',
                              style: context.bodyMedium?.copyWith(
                                color: Colors.white.withOpacity(0.8),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'Log In',
                                style: context.bodyMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: context.spacingMD),

                        // Guest Mode
                        TextButton(
                          onPressed: () {
                            GeneralMethods.navigateTo(context, HomeScreen());
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white.withOpacity(0.7),
                          ),
                          child: Text(
                            AppStrings.continueAsGuest,
                            style: context.bodyMedium?.copyWith(
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}