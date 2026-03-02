import 'package:flutter/material.dart';
import 'package:pavi/theme/generalTheme.dart';
import '../models/wallet_model.dart';


class TransactionTile extends StatelessWidget {
  final Transaction transaction;
  final bool isLast;
  final VoidCallback? onTap;

  const TransactionTile({
    super.key,
    required this.transaction,
    this.isLast = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: context.spacingSM),
        decoration: BoxDecoration(
          border: isLast
              ? null
              : Border(
            bottom: BorderSide(
              color: context.lightGray,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            // Icon with background based on transaction type
            _buildIcon(context),

            SizedBox(width: context.spacingMD),

            // Transaction details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          transaction.title,
                          style: context.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        _formatAmount(),
                        style: context.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: _getAmountColor(context),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: context.spacingXXS),

                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          transaction.description,
                          style: context.bodySmall?.copyWith(
                            color: context.mediumGray,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: context.spacingSM),
                      Text(
                        transaction.formattedDate,
                        style: context.labelSmall?.copyWith(
                          color: context.mediumGray,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),

                  // Status badge for non-completed transactions
                  if (transaction.status != TransactionStatus.completed) ...[
                    SizedBox(height: context.spacingXXS),
                    _buildStatusBadge(context),
                  ],

                  // Payment method reference if available
                  if (transaction.paymentMethod != null && transaction.reference != null) ...[
                    SizedBox(height: context.spacingXXS),
                    Row(
                      children: [
                        Icon(
                          Icons.receipt_outlined,
                          size: 10,
                          color: context.mediumGray,
                        ),
                        SizedBox(width: context.spacingXXS),
                        Text(
                          'Ref: ${transaction.reference}',
                          style: context.labelSmall?.copyWith(
                            color: context.mediumGray,
                            fontSize: 8,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    Color iconColor;

    // Determine icon color based on transaction type
    switch (transaction.type) {
      case TransactionType.credit:
      case TransactionType.recharge:
        iconColor = context.success;
        break;
      case TransactionType.debit:
        iconColor = context.error;
        break;
      case TransactionType.callDeduction:
        iconColor = context.primaryGreen;
        break;
      case TransactionType.dataPurchase:
        iconColor = context.actionAmber;
        break;
    }

    // If transaction failed, use error color
    if (transaction.status == TransactionStatus.failed) {
      iconColor = context.error;
    }

    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        _getIcon(),
        color: iconColor,
        size: 22,
      ),
    );
  }

  IconData _getIcon() {
    if (transaction.status == TransactionStatus.failed) {
      return Icons.error_outline;
    }

    switch (transaction.type) {
      case TransactionType.credit:
      case TransactionType.recharge:
        return Icons.arrow_downward;
      case TransactionType.debit:
        return Icons.arrow_upward;
      case TransactionType.callDeduction:
        return Icons.phone;
      case TransactionType.dataPurchase:
        return Icons.data_usage;
    }
  }

  String _formatAmount() {
    final isCredit = transaction.type == TransactionType.credit ||
        transaction.type == TransactionType.recharge;

    final sign = isCredit ? '+' : '-';
    return '$sign₦${transaction.amount.toStringAsFixed(2)}';
  }

  Color _getAmountColor(BuildContext context) {
    if (transaction.status == TransactionStatus.failed) {
      return context.error;
    }

    switch (transaction.type) {
      case TransactionType.credit:
      case TransactionType.recharge:
        return context.success;
      case TransactionType.debit:
      case TransactionType.callDeduction:
      case TransactionType.dataPurchase:
        return context.deepNavy;
    }
  }

  Widget _buildStatusBadge(BuildContext context) {
    Color badgeColor;
    String statusText;

    switch (transaction.status) {
      case TransactionStatus.pending:
        badgeColor = context.actionAmber;
        statusText = 'PENDING';
        break;
      case TransactionStatus.failed:
        badgeColor = context.error;
        statusText = 'FAILED';
        break;
      case TransactionStatus.refunded:
        badgeColor = context.info;
        statusText = 'REFUNDED';
        break;
      default:
        badgeColor = context.success;
        statusText = 'COMPLETED';
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.spacingSM,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(context.radiusXS),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getStatusIcon(transaction.status),
            size: 10,
            color: badgeColor,
          ),
          SizedBox(width: context.spacingXXS),
          Text(
            statusText,
            style: context.labelSmall?.copyWith(
              color: badgeColor,
              fontSize: 9,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getStatusIcon(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.pending:
        return Icons.hourglass_empty;
      case TransactionStatus.completed:
        return Icons.check_circle;
      case TransactionStatus.failed:
        return Icons.error;
      case TransactionStatus.refunded:
        return Icons.replay;
    }
  }
}