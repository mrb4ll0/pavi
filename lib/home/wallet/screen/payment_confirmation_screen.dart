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
    return Scaffold(
      backgroundColor: context.offWhite,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Payment Confirmation',
          style: context.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.close, color: context.deepNavy),
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
                color: context.deepNavy,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: context.spacingXS),

            Text(
              'Your wallet has been recharged',
              style: context.bodyLarge?.copyWith(
                color: context.mediumGray,
              ),
            ),

            SizedBox(height: context.spacingXL),

            // Payment Details Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(context.spacingLG),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(context.radiusLG),
                boxShadow: context.shadowMD,
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
                  colors: [context.primaryGreen, context.primaryGreenDark],
                ),
                borderRadius: BorderRadius.circular(context.radiusLG),
                boxShadow: context.shadowLG,
              ),
              child: Column(
                children: [
                  Text(
                    'New Wallet Balance',
                    style: context.bodyMedium?.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: context.spacingSM),
                  Text(
                    '₦${(2500 + request.amount).toStringAsFixed(2)}',
                    style: context.displaySmall?.copyWith(
                      color: Colors.white,
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
                      foregroundColor: context.primaryGreen,
                      side: BorderSide(color: context.primaryGreen),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(context.radiusSM),
                      ),
                      padding: EdgeInsets.symmetric(vertical: context.spacingMD),
                    ),
                    child: Text(
                      'Home',
                      style: context.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
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
                      backgroundColor: context.primaryGreen,
                      foregroundColor: Colors.white,
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
                        color: Colors.white,
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
    return Container(
      padding: EdgeInsets.symmetric(vertical: context.spacingSM),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: context.lightGray, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(icon, size: 16, color: iconColor ?? context.mediumGray),
                SizedBox(width: context.spacingXS),
              ],
              Text(
                label,
                style: context.bodyMedium?.copyWith(
                  color: context.mediumGray,
                ),
              ),
            ],
          ),
          Text(
            value,
            style: context.bodyMedium?.copyWith(
              fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
              color: valueColor ?? context.deepNavy,
            ),
          ),
        ],
      ),
    );
  }
}