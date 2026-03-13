import 'package:flutter/material.dart';
import '../theme/generalTheme.dart';

class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({super.key});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final TextEditingController otpController = TextEditingController();

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OTP Verification')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              'Enter the 6-digit code sent to your phone',
              style: AppTheme.bodyText,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            // OTP Input
            TextField(
              controller: otpController,
              decoration: AppTheme.inputDecoration(context:context,hintText: 'OTP Code'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                // TODO: Implement resend OTP
              },
              child: Text(
                'Resend OTP',
                style: TextStyle(color: context.primaryColor),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement OTP verification logic
              },
              style: context.primaryButton,
              child: const Text('Verify'),
            ),
          ],
        ),
      ),
    );
  }
}