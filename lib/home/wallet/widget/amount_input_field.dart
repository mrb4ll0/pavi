import 'package:flutter/material.dart';
import 'package:pavi/theme/generalTheme.dart';


class AmountInputField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final List<double> presetAmounts;

  const AmountInputField({
    super.key,
    required this.controller,
    this.validator,
    this.presetAmounts = const [500, 1000, 2000, 5000, 10000],
  });

  

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Enter Amount',
          style: context.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),

        SizedBox(height: context.spacingSM),

        // Amount input
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(context.radiusMD),
            boxShadow: context.shadowSM,
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            style: context.titleLarge?.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              prefixText: '₦ ',
              prefixStyle: context.titleLarge?.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: context.mediumGray,
              ),
              hintText: '0.00',
              hintStyle: context.titleLarge?.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: context.lightGray,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(context.radiusMD),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.transparent,
              contentPadding: EdgeInsets.symmetric(
                vertical: context.spacingLG,
              ),
            ),
            validator: validator,
          ),
        ),

        SizedBox(height: context.spacingMD),

        // Preset amounts
        Text(
          'Quick Select',
          style: context.bodySmall?.copyWith(
            color: context.mediumGray,
          ),
        ),

        SizedBox(height: context.spacingSM),

        Wrap(
          spacing: context.spacingSM,
          runSpacing: context.spacingSM,
          children: presetAmounts.map((amount) {
            return GestureDetector(
              onTap: () {
                controller.text = amount.toStringAsFixed(0);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: context.spacingMD,
                  vertical: context.spacingSM,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(context.radiusSM),
                  border: Border.all(
                    color: context.lightGray,
                    width: 1,
                  ),
                  boxShadow: context.shadowSM,
                ),
                child: Text(
                  '₦${amount.toStringAsFixed(0)}',
                  style: context.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.deepNavy,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}