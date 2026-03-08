import 'package:flutter/material.dart';
import 'package:pavi/theme/generalTheme.dart';



class TransactionDetailsPage extends StatelessWidget {
  final Map<String, dynamic> transaction;

  const TransactionDetailsPage({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    final isCredit = transaction['type'] == 'credit';
    final amountColor = isCredit ? context.success : null;
    final transactionColor = Color(transaction['colorValue'] as int);
    final date = DateTime.parse(transaction['date'].replaceFirst(' ', 'T'));

    return Scaffold(
      backgroundColor: context.offWhite,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: context.deepNavy,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Transaction Details',
          style: context.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Status Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(context.radiusLG),
                boxShadow: context.shadowSM,
              ),
              child: Column(
                children: [
                  // Icon
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: transactionColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      transaction['icon'] as IconData,
                      color: transactionColor,
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Amount
                  Text(
                    transaction['amount'] as String,
                    style: context.headlineMedium?.copyWith(
                      color: amountColor ?? context.deepNavy,
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Title
                  Text(
                    transaction['title'] as String,
                    style: context.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),

                  // Status Badge
                  if (transaction['status'] == 'pending')
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: context.actionAmber.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(context.radiusSM),
                      ),
                      child: Text(
                        'Pending',
                        style: context.labelMedium?.copyWith(
                          color: context.actionAmber,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  else
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: context.success.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(context.radiusSM),
                      ),
                      child: Text(
                        'Completed',
                        style: context.labelMedium?.copyWith(
                          color: context.success,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Details Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(context.radiusLG),
                boxShadow: context.shadowSM,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Transaction Information',
                    style: context.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildDetailRow(
                    context,
                    label: 'Reference Number',
                    value: transaction['reference'] as String,
                    icon: Icons.receipt_long,
                  ),

                  _buildDetailRow(
                    context,
                    label: 'Date & Time',
                    value: '${date.day}/${date.month}/${date.year} at ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}',
                    icon: Icons.calendar_today,
                  ),

                  _buildDetailRow(
                    context,
                    label: 'Description',
                    value: transaction['description'] as String,
                    icon: Icons.description,
                  ),

                  _buildDetailRow(
                    context,
                    label: 'Payment Method',
                    value: transaction['paymentMethod'] as String,
                    icon: Icons.payment,
                  ),

                  _buildDetailRow(
                    context,
                    label: 'Transaction Type',
                    value: isCredit ? 'Credit (Money In)' : 'Debit (Money Out)',
                    icon: isCredit ? Icons.arrow_downward : Icons.arrow_upward,
                    valueColor: isCredit ? context.success : null,
                  ),

                  _buildDetailRow(
                    context,
                    label: 'Status',
                    value: (transaction['status'] as String).toUpperCase(),
                    icon: Icons.info_outline,
                    valueColor: transaction['status'] == 'completed'
                        ? context.success
                        : context.actionAmber,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Balance Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    context.primaryGreen,
                    context.primaryGreenDark,
                  ],
                ),
                borderRadius: BorderRadius.circular(context.radiusLG),
                boxShadow: context.shadowMD,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Wallet Balance After Transaction',
                    style: context.labelLarge?.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    transaction['balance'] as String,
                    style: context.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Updated: ${_formatBalanceUpdateDate(date)}',
                    style: context.labelSmall?.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // Share receipt
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: context.primaryGreen,
                      side: BorderSide(color: context.primaryGreen),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(context.radiusMD),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.share, size: 18),
                        const SizedBox(width: 8),
                        const Text('Share Receipt'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      // Download receipt
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: context.primaryGreen,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(context.radiusMD),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.download, size: 18),
                        const SizedBox(width: 8),
                        const Text('Download'),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Support Link
            Center(
              child: TextButton(
                onPressed: () {
                  // Navigate to support
                },
                child: Text(
                  'Need help with this transaction?',
                  style: context.labelSmall?.copyWith(
                    color: context.primaryGreen,
                  ),
                ),
              ),
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
        required IconData icon,
        Color? valueColor,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: context.primaryGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(context.radiusXS),
            ),
            child: Icon(
              icon,
              size: 16,
              color: context.primaryGreen,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: context.labelSmall?.copyWith(
                    color: context.mediumGray,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: context.bodyMedium?.copyWith(
                    color: valueColor ?? context.deepNavy,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatBalanceUpdateDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} at ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}