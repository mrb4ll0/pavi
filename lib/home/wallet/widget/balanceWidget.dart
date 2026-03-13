import 'package:flutter/material.dart';
import 'package:pavi/theme/generalTheme.dart';
import '../models/wallet_model.dart';

class BalanceCard extends StatelessWidget {
  final WalletBalance balance;
  final VoidCallback onRecharge;

  const BalanceCard({
    super.key,
    required this.balance,
    required this.onRecharge,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(context.spacingLG),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [context.accentPurple, context.accentPurpleDark]
              : [context.textPrimary, context.textPrimary],
        ),
        borderRadius: BorderRadius.circular(context.radiusLG),
        boxShadow: isDark ? null : context.shadowLG,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Wallet Balance',
                style: context.titleSmall?.copyWith(
                  color: context.white.withOpacity(0.7),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: context.spacingSM,
                  vertical: context.spacingXXS,
                ),
                decoration: BoxDecoration(
                  color: context.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(context.radiusSM),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.security,
                      size: 12,
                      color: context.white.withOpacity(0.7),
                    ),
                    SizedBox(width: context.spacingXXS),
                    Text(
                      'Secured',
                      style: context.labelSmall?.copyWith(
                        color: context.white.withOpacity(0.7),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: context.spacingMD),

          // Naira Balance
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '₦',
                style: context.displaySmall?.copyWith(
                  color: context.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: context.spacingXXS),
              Text(
                balance.nairaBalance.toStringAsFixed(2),
                style: context.displaySmall?.copyWith(
                  color: context.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          SizedBox(height: context.spacingMD),

          // Minutes and Data Row
          Row(
            children: [
              Expanded(
                child: _buildBalanceItem(
                  context,
                  icon: Icons.timer,
                  label: 'Minutes',
                  value: '${balance.minutesBalance} min',
                  color: isDark ? context.white : context.primaryColor,
                ),
              ),
              SizedBox(width: context.spacingMD),
              Expanded(
                child: _buildBalanceItem(
                  context,
                  icon: Icons.data_usage,
                  label: 'Data',
                  value: '${(balance.dataBalance / 1024).toStringAsFixed(1)} GB',
                  color: context.warning,
                ),
              ),
            ],
          ),

          SizedBox(height: context.spacingLG),

          // Recharge Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: onRecharge,
              style: ElevatedButton.styleFrom(
                backgroundColor: isDark ? context.white : context.primaryColor,
                foregroundColor: isDark ? context.accentPurple : context.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(context.radiusSM),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    size: 18,
                    color: isDark ? context.accentPurple : context.white,
                  ),
                  SizedBox(width: context.spacingXS),
                  Text(
                    'Recharge Wallet',
                    style: context.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isDark ? context.accentPurple : context.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceItem(
      BuildContext context, {
        required IconData icon,
        required String label,
        required String value,
        required Color color,
      }) {
    return Container(
      padding: EdgeInsets.all(context.spacingSM),
      decoration: BoxDecoration(
        color: context.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(context.radiusMD),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: color),
              SizedBox(width: context.spacingXXS),
              Text(
                label,
                style: context.labelSmall?.copyWith(
                  color: context.white.withOpacity(0.7),
                  fontSize: 10,
                ),
              ),
            ],
          ),
          SizedBox(height: context.spacingXS),
          Text(
            value,
            style: context.titleSmall?.copyWith(
              color: context.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}