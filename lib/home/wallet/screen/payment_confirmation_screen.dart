import 'package:flutter/material.dart';
import 'package:pavi/theme/generalTheme.dart';
import '../models/wallet_model.dart';

class PaymentConfirmationScreen extends StatelessWidget {
  final RechargeRequest request;

  const PaymentConfirmationScreen({
    super.key,
    required this.request,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        backgroundColor: context.surfaceColor,
        elevation: 0,
        title: Text(
          'Payment Confirmation',
          style: context.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: context.textPrimary,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.close, color: context.textPrimary),
          onPressed: () {
            Navigator.popUntil(context, ModalRoute.withName('/'));
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(context.spacingLG),
        child: Column(
          children: [
            // Success Animation
            Container(
              width: 120,
              height: 120,
              margin: EdgeInsets.symmetric(vertical: context.spacingXL),
              decoration: BoxDecoration(
                color: context.success.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle,
                color: context.success,
                size: 80,
              ),
            ),

            Text(
              'Payment Successful!',
              style: context.headlineMedium?.copyWith(
                color: context.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: context.spacingXS),

            Text(
              'Your wallet has been recharged',
              style: context.bodyLarge?.copyWith(
                color: context.textHint,
              ),
            ),

            SizedBox(height: context.spacingXL),

            // Payment Details Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(context.spacingLG),
              decoration: BoxDecoration(
                color: isDark ? context.darkCard : context.white,
                borderRadius: BorderRadius.circular(context.radiusLG),
                boxShadow: isDark ? null : context.shadowMD,
              ),
              child: Column(
                children: [
                  _buildDetailRow(
                    context,
                    label: 'Amount',
                    value: '₦${request.amount.toStringAsFixed(2)}',
                    isBold: true,
                  ),
                  _buildDetailRow(
                    context,
                    label: 'Payment Method',
                    value: request.paymentMethod.displayName,
                    icon: request.paymentMethod.icon,
                    iconColor: request.paymentMethod.getColor(context),
                  ),
                  _buildDetailRow(
                    context,
                    label: 'Reference',
                    value: 'PAY-${DateTime.now().millisecondsSinceEpoch.toString().substring(0, 8)}',
                  ),
                  _buildDetailRow(
                    context,
                    label: 'Date',
                    value: '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                  ),
                  _buildDetailRow(
                    context,
                    label: 'Status',
                    value: 'Completed',
                    valueColor: context.success,
                  ),
                ],
              ),
            ),

            SizedBox(height: context.spacingXL),

            // New Balance
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(context.spacingLG),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDark
                      ? [context.accentPurple, context.accentPurpleDark]
                      : [context.primaryColor, context.primaryPurpleDark],
                ),
                borderRadius: BorderRadius.circular(context.radiusLG),
                boxShadow: isDark ? null : context.shadowLG,
              ),
              child: Column(
                children: [
                  Text(
                    'New Wallet Balance',
                    style: context.bodyMedium?.copyWith(
                      color: context.white.withOpacity(0.7),
                    ),
                  ),
                  SizedBox(height: context.spacingSM),
                  Text(
                    '₦${(2500 + request.amount).toStringAsFixed(2)}',
                    style: context.displaySmall?.copyWith(
                      color: context.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: context.spacingXL),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.popUntil(context, ModalRoute.withName('/'));
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: isDark ? context.accentPurple : context.primaryColor,
                      side: BorderSide(
                        color: isDark ? context.accentPurple : context.primaryColor,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(context.radiusSM),
                      ),
                      padding: EdgeInsets.symmetric(vertical: context.spacingMD),
                    ),
                    child: Text(
                      'Home',
                      style: context.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: isDark ? context.accentPurple : context.primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: context.spacingMD),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.popUntil(context, ModalRoute.withName('/'));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDark ? context.accentPurple : context.primaryColor,
                      foregroundColor: context.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(context.radiusSM),
                      ),
                      padding: EdgeInsets.symmetric(vertical: context.spacingMD),
                    ),
                    child: Text(
                      'Done',
                      style: context.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: context.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
      BuildContext context, {
        required String label,
        required String value,
        IconData? icon,
        Color? iconColor,
        bool isBold = false,
        Color? valueColor,
      }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.symmetric(vertical: context.spacingSM),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isDark ? context.darkTextHint.withOpacity(0.3) : context.lightGray,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(icon, size: 16, color: iconColor ?? context.textHint),
                SizedBox(width: context.spacingXS),
              ],
              Text(
                label,
                style: context.bodyMedium?.copyWith(
                  color: context.textHint,
                ),
              ),
            ],
          ),
          Text(
            value,
            style: context.bodyMedium?.copyWith(
              fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
              color: valueColor ?? context.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}