import 'package:flutter/material.dart';
import 'package:pavi/home/wallet/screen/payment_confirmation_screen.dart';
import 'package:pavi/theme/generalTheme.dart';

import '../models/wallet_model.dart';
import '../widget/amount_input_field.dart';
import '../widget/payment_method_card.dart';

class RechargeScreen extends StatefulWidget {
  const RechargeScreen({super.key});

  @override
  State<RechargeScreen> createState() => _RechargeScreenState();
}


class _RechargeScreenState extends State<RechargeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();

  PaymentMethod _selectedMethod = PaymentMethod.paystack;
  bool _isLoading = false;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  String? _validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an amount';
    }

    final amount = double.tryParse(value);
    if (amount == null) {
      return 'Please enter a valid amount';
    }

    if (amount < 100) {
      return 'Minimum recharge is ₦100';
    }

    if (amount > 100000) {
      return 'Maximum recharge is ₦100,000';
    }

    return null;
  }

  void _processRecharge() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      // Simulate payment processing
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });

        final request = RechargeRequest(
          amount: double.parse(_amountController.text),
          email: 'user@example.com',
          phoneNumber: '+2348012345678',
          paymentMethod: _selectedMethod,
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentConfirmationScreen(
              request: request,
            ),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.offWhite,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Recharge Wallet',
          style: context.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: context.deepNavy),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(context.spacingLG),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Amount Input
              AmountInputField(
                controller: _amountController,
                validator: _validateAmount,
              ),

              SizedBox(height: context.spacingXL),

              // Payment Methods
              Text(
                'Payment Method',
                style: context.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(height: context.spacingMD),

              PaymentMethodCard(
                method: PaymentMethod.paystack,
                isSelected: _selectedMethod == PaymentMethod.paystack,
                onTap: () {
                  setState(() {
                    _selectedMethod = PaymentMethod.paystack;
                  });
                },
              ),

              PaymentMethodCard(
                method: PaymentMethod.card,
                isSelected: _selectedMethod == PaymentMethod.card,
                onTap: () {
                  setState(() {
                    _selectedMethod = PaymentMethod.card;
                  });
                },
              ),

              PaymentMethodCard(
                method: PaymentMethod.bankTransfer,
                isSelected: _selectedMethod == PaymentMethod.bankTransfer,
                onTap: () {
                  setState(() {
                    _selectedMethod = PaymentMethod.bankTransfer;
                  });
                },
              ),

              PaymentMethodCard(
                method: PaymentMethod.ussd,
                isSelected: _selectedMethod == PaymentMethod.ussd,
                onTap: () {
                  setState(() {
                    _selectedMethod = PaymentMethod.ussd;
                  });
                },
              ),

              SizedBox(height: context.spacingXL),

              // Summary
              Container(
                padding: EdgeInsets.all(context.spacingLG),
                decoration: BoxDecoration(
                  color: context.primaryGreen.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(context.radiusMD),
                  border: Border.all(
                    color: context.primaryGreen.withOpacity(0.2),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'You\'ll receive',
                          style: context.bodySmall?.copyWith(
                            color: context.mediumGray,
                          ),
                        ),
                        SizedBox(height: context.spacingXXS),
                        Text(
                          'Wallet Balance',
                          style: context.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          _amountController.text.isEmpty
                              ? '₦0.00'
                              : '₦${double.parse(_amountController.text).toStringAsFixed(2)}',
                          style: context.titleLarge?.copyWith(
                            color: context.primaryGreen,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '+ 0 bonus',
                          style: context.labelSmall?.copyWith(
                            color: context.actionAmber,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: context.spacingXL),

              // Recharge Button
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
                  onPressed: _processRecharge,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.primaryGreen,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(context.radiusSM),
                    ),
                  ),
                  child: Text(
                    'Continue to Payment',
                    style: context.labelLarge?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              SizedBox(height: context.spacingMD),

              // Security Note
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.lock_outline,
                      size: 14,
                      color: context.mediumGray,
                    ),
                    SizedBox(width: context.spacingXXS),
                    Text(
                      'Secured by Paystack',
                      style: context.labelSmall?.copyWith(
                        color: context.mediumGray,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}