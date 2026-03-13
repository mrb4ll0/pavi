import 'package:flutter/material.dart';
import 'package:pavi/theme/generalTheme.dart';
import '../models/wallet_model.dart';

class PaymentMethodCard extends StatelessWidget {
  final PaymentMethod method;
  final bool isSelected;
  final VoidCallback onTap;
  final PaymentMethodOption? option;

  const PaymentMethodCard({
    super.key,
    required this.method,
    required this.isSelected,
    required this.onTap,
    this.option,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: context.spacingSM),
        padding: EdgeInsets.all(context.spacingMD),
        decoration: BoxDecoration(
          color: isDark ? context.darkCard : context.white,
          borderRadius: BorderRadius.circular(context.radiusMD),
          border: Border.all(
            color: isSelected
                ? (isDark ? context.accentPurple : context.primaryColor)
                : (isDark ? context.darkTextHint.withOpacity(0.3) : context.lightGray),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected && !isDark ? context.shadowSM : null,
        ),
        child: Row(
          children: [
            // Icon with background
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: method.getColor(context).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                method.icon,
                color: method.getColor(context),
                size: 24,
              ),
            ),

            SizedBox(width: context.spacingMD),

            // Method details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        method.displayName,
                        style: context.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: context.textPrimary,
                        ),
                      ),
                      if (option?.processingFee != null && option!.processingFee! > 0) ...[
                        SizedBox(width: context.spacingXS),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.spacingXS,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: context.warning.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(context.radiusXS),
                          ),
                          child: Text(
                            option!.feeText,
                            style: context.labelSmall?.copyWith(
                              color: context.warning,
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),

                  SizedBox(height: context.spacingXXS),

                  Text(
                    method.description,
                    style: context.bodySmall?.copyWith(
                      color: context.textHint,
                    ),
                  ),

                  if (option != null) ...[
                    SizedBox(height: context.spacingXXS),
                    Row(
                      children: [
                        Icon(
                          Icons.timer_outlined,
                          size: 12,
                          color: context.textHint,
                        ),
                        SizedBox(width: context.spacingXXS),
                        Text(
                          option!.processingTimeText,
                          style: context.labelSmall?.copyWith(
                            color: context.textHint,
                            fontSize: 9,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),

            // Radio button
            Radio<bool>(
              value: true,
              groupValue: isSelected,
              onChanged: (value) => onTap(),
              activeColor: isDark ? context.accentPurple : context.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}