import 'package:flutter/material.dart';
import 'package:pavi/theme/generalTheme.dart';


class PremiumBenefitsPage extends StatelessWidget {
  const PremiumBenefitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        backgroundColor: context.surfaceColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: context.textPrimary,
          ),
        ),
        title: Text(
          'Premium Benefits',
          style: context.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: context.textPrimary,
          ),
        ),
        centerTitle: false,
        actions: [
          Container(
            margin: EdgeInsets.only(right: context.spacingLG),
            padding: EdgeInsets.symmetric(
              horizontal: context.spacingSM,
              vertical: context.spacingXS,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [context.accentPurple, context.accentPurpleDark],
              ),
              borderRadius: BorderRadius.circular(context.radiusXL),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.bolt,
                  size: 14,
                  color: Colors.white,
                ),
                SizedBox(width: 4),
                Text(
                  'PREMIUM',
                  style: context.labelSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Premium Hero Section
            Container(
              margin: EdgeInsets.all(context.spacingLG),
              padding: EdgeInsets.all(context.spacingLG),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    context.accentPurple,
                    context.accentPurpleDark,
                    isDark ? context.darkCard : const Color(0xFF1E293B),
                  ],
                ),
                borderRadius: BorderRadius.circular(context.radiusLG),
                boxShadow: [
                  BoxShadow(
                    color: context.accentPurple.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(context.spacingSM),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.bolt,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: context.spacingSM),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Unlock Premium',
                              style: context.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              'Get exclusive benefits and earn more',
                              style: context.bodySmall?.copyWith(
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.spacingLG),
                  Row(
                    children: [
                      Expanded(
                        child: _buildPremiumStat(
                          context,
                          label: '2x Rewards',
                          value: '+100%',
                          icon: Icons.star,
                        ),
                      ),
                      Expanded(
                        child: _buildPremiumStat(
                          context,
                          label: 'Priority Support',
                          value: '24/7',
                          icon: Icons.support_agent,
                        ),
                      ),
                      Expanded(
                        child: _buildPremiumStat(
                          context,
                          label: 'Exclusive',
                          value: 'Up to 50%',
                          icon: Icons.discount,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.spacingLG),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to subscription page
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: context.accentPurple,
                        padding: EdgeInsets.symmetric(vertical: context.spacingMD),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(context.radiusMD),
                        ),
                      ),
                      child: Text(
                        'Upgrade Now',
                        style: context.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Active Benefits Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.spacingLG),
              child: Text(
                'Your Active Benefits',
                style: context.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: context.textPrimary,
                ),
              ),
            ),
            SizedBox(height: context.spacingMD),

            // Active Benefits List
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: context.spacingLG),
              itemCount: _activeBenefits.length,
              separatorBuilder: (context, index) => SizedBox(height: context.spacingMD),
              itemBuilder: (context, index) {
                final benefit = _activeBenefits[index];
                return _buildActiveBenefitCard(
                  context,
                  icon: benefit['icon'] as IconData,
                  title: benefit['title'] as String,
                  description: benefit['description'] as String,
                  expiry: benefit['expiry'] as String,
                  color: Color(benefit['color']) ,
                );
              },
            ),

            SizedBox(height: context.spacingXL),

            // Available Upgrades Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.spacingLG),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Available Upgrades',
                    style: context.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: context.textPrimary,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.spacingSM,
                      vertical: context.spacingXXS,
                    ),
                    decoration: BoxDecoration(
                      color: context.accentPurple.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(context.radiusXL),
                    ),
                    child: Text(
                      '3 Available',
                      style: context.labelSmall?.copyWith(
                        color: context.accentPurple,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: context.spacingMD),

            // Upgrade Plans
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.spacingLG),
              child: Column(
                children: [
                  _buildUpgradePlan(
                    context,
                    title: 'Premium Monthly',
                    price: '₦2,500',
                    period: '/month',
                    features: const [
                      '2x rewards on all tasks',
                      'Priority customer support',
                      'Exclusive discounts up to 30%',
                      'Early access to new features',
                    ],
                    isPopular: false,
                    savings: null,
                  ),
                  SizedBox(height: context.spacingMD),
                  _buildUpgradePlan(
                    context,
                    title: 'Premium Yearly',
                    price: '₦24,000',
                    period: '/year',
                    features: const [
                      'All monthly features',
                      'Save 20% vs monthly',
                      'Exclusive 50% discount events',
                      'Premium badge on profile',
                      'Monthly bonus rewards',
                    ],
                    isPopular: true,
                    savings: 'Save ₦6,000',
                  ),
                  SizedBox(height: context.spacingMD),
                  _buildUpgradePlan(
                    context,
                    title: 'Family Plan',
                    price: '₦35,000',
                    period: '/year',
                    features: const [
                      'All yearly features',
                      'Up to 5 family members',
                      'Shared rewards pool',
                      'Family dashboard',
                    ],
                    isPopular: false,
                    savings: 'Best value',
                  ),
                ],
              ),
            ),

            SizedBox(height: context.spacingXL),

            // Comparison Table
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.spacingLG),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Compare Plans',
                    style: context.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: context.textPrimary,
                    ),
                  ),
                  SizedBox(height: context.spacingMD),
                  Container(
                    decoration: BoxDecoration(
                      color: isDark ? context.darkCard : context.white,
                      borderRadius: BorderRadius.circular(context.radiusLG),
                      border: Border.all(
                        color: isDark ? context.darkTextHint.withOpacity(0.2) : context.lightGray,
                      ),
                    ),
                    child: Column(
                      children: [
                        _buildComparisonRow(
                          context,
                          feature: '2x Rewards',
                          free: '❌',
                          premium: '✅',
                          premiumPlus: '✅✅',
                        ),
                        _buildComparisonRow(
                          context,
                          feature: 'Priority Support',
                          free: '❌',
                          premium: '✅',
                          premiumPlus: '✅',
                        ),
                        _buildComparisonRow(
                          context,
                          feature: 'Discounts',
                          free: 'Up to 10%',
                          premium: 'Up to 30%',
                          premiumPlus: 'Up to 50%',
                        ),
                        _buildComparisonRow(
                          context,
                          feature: 'Family Sharing',
                          free: '❌',
                          premium: '❌',
                          premiumPlus: '✅',
                        ),
                        _buildComparisonRow(
                          context,
                          feature: 'Early Access',
                          free: '❌',
                          premium: '✅',
                          premiumPlus: '✅',
                        ),
                        _buildComparisonRow(
                          context,
                          feature: 'Monthly Bonus',
                          free: '₦0',
                          premium: '₦500',
                          premiumPlus: '₦2,000',
                          isLast: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: context.spacing3XL),

            // FAQ Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.spacingLG),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Frequently Asked Questions',
                    style: context.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: context.textPrimary,
                    ),
                  ),
                  SizedBox(height: context.spacingMD),
                  _buildFAQItem(
                    context,
                    question: 'Can I cancel my subscription anytime?',
                    answer: 'Yes, you can cancel your premium subscription at any time. Your benefits will continue until the end of your billing period.',
                  ),
                  _buildFAQItem(
                    context,
                    question: 'How do I earn 2x rewards?',
                    answer: 'All tasks and activities automatically earn double rewards once you have an active premium subscription.',
                  ),
                  _buildFAQItem(
                    context,
                    question: 'Is there a free trial?',
                    answer: 'Yes! New users get a 7-day free trial to experience all premium benefits before committing.',
                  ),
                  _buildFAQItem(
                    context,
                    question: 'How do I contact priority support?',
                    answer: 'Premium members get 24/7 access to priority support via live chat and dedicated email support.',
                    isLast: true,
                  ),
                ],
              ),
            ),

            SizedBox(height: context.spacing3XL),
          ],
        ),
      ),
    );
  }

  // Active benefits data
  final List<Map<String, dynamic>> _activeBenefits = const [
    {
      'icon': Icons.star,
      'title': 'Double Rewards Active',
      'description': 'You\'re earning 2x coins on all tasks until',
      'expiry': 'Expires in 25 days',
      'color': 0xFF4CAF50,
    },
    {
      'icon': Icons.support_agent,
      'title': 'Priority Support Access',
      'description': '24/7 dedicated support with 1-hour response time',
      'expiry': 'Active',
      'color': 0xFF2196F3,
    },
    {
      'icon': Icons.discount,
      'title': 'Premium Discounts',
      'description': 'Exclusive member-only discounts available',
      'expiry': '10% off next purchase',
      'color': 0xFFFF9800,
    },
  ];

  Widget _buildPremiumStat(
      BuildContext context, {
        required String label,
        required String value,
        required IconData icon,
      }) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
        SizedBox(height: context.spacingXS),
        Text(
          value,
          style: context.titleMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: context.labelSmall?.copyWith(
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildActiveBenefitCard(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String description,
        required String expiry,
        required Color color,
      }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(context.spacingMD),
      decoration: BoxDecoration(
        color: isDark ? context.darkCard : context.white,
        borderRadius: BorderRadius.circular(context.radiusLG),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: isDark ? null : context.shadowSM,
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color.withOpacity(0.2), color.withOpacity(0.1)],
              ),
              borderRadius: BorderRadius.circular(context.radiusMD),
            ),
            child: Icon(
              icon,
              color: color,
              size: 28,
            ),
          ),
          SizedBox(width: context.spacingMD),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: context.textPrimary,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  description,
                  style: context.labelSmall?.copyWith(
                    color: context.textHint,
                  ),
                ),
                SizedBox(height: 4),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.spacingSM,
                    vertical: context.spacingXXS,
                  ),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(context.radiusSM),
                  ),
                  child: Text(
                    expiry,
                    style: context.labelSmall?.copyWith(
                      color: color,
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: context.textHint,
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildUpgradePlan(
      BuildContext context, {
        required String title,
        required String price,
        required String period,
        required List<String> features,
        required bool isPopular,
        String? savings,
      }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        gradient: isPopular
            ? LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            context.accentPurple.withOpacity(0.1),
            context.accentPurpleDark.withOpacity(0.05),
          ],
        )
            : null,
        color: isPopular ? null : (isDark ? context.darkCard : context.white),
        borderRadius: BorderRadius.circular(context.radiusLG),
        border: isPopular
            ? Border.all(
          color: context.accentPurple,
          width: 2,
        )
            : Border.all(
          color: isDark ? context.darkTextHint.withOpacity(0.2) : context.lightGray,
        ),
        boxShadow: isPopular
            ? [
          BoxShadow(
            color: context.accentPurple.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ]
            : (isDark ? null : context.shadowSM),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isPopular)
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: context.spacingXS,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [context.accentPurple, context.accentPurpleDark],
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(context.radiusLG),
                  topRight: Radius.circular(context.radiusLG),
                ),
              ),
              child: Center(
                child: Text(
                  'MOST POPULAR',
                  style: context.labelSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
            ),
          Padding(
            padding: EdgeInsets.all(context.spacingLG),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: context.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isPopular ? context.accentPurple : context.textPrimary,
                        ),
                      ),
                    ),
                    if (savings != null)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.spacingSM,
                          vertical: context.spacingXXS,
                        ),
                        decoration: BoxDecoration(
                          color: context.success.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(context.radiusSM),
                        ),
                        child: Text(
                          savings,
                          style: context.labelSmall?.copyWith(
                            color: context.success,
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: context.spacingSM),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      price,
                      style: context.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isPopular ? context.accentPurple : context.textPrimary,
                      ),
                    ),
                    Text(
                      period,
                      style: context.bodySmall?.copyWith(
                        color: context.textHint,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.spacingLG),
                ...features.map((feature) => Padding(
                  padding: EdgeInsets.only(bottom: context.spacingSM),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 16,
                        color: context.success,
                      ),
                      SizedBox(width: context.spacingSM),
                      Expanded(
                        child: Text(
                          feature,
                          style: context.bodySmall?.copyWith(
                            color: context.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
                SizedBox(height: context.spacingLG),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle upgrade
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isPopular ? context.accentPurple : context.surfaceColor,
                      foregroundColor: isPopular ? Colors.white : context.textPrimary,
                      padding: EdgeInsets.symmetric(vertical: context.spacingMD),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(context.radiusMD),
                        side: isPopular
                            ? BorderSide.none
                            : BorderSide(color: context.textHint.withOpacity(0.3)),
                      ),
                    ),
                    child: Text(
                      'Upgrade to $title',
                      style: context.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonRow(
      BuildContext context, {
        required String feature,
        required String free,
        required String premium,
        required String premiumPlus,
        bool isLast = false,
      }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(context.spacingMD),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(
          bottom: BorderSide(
            color: isDark ? context.darkTextHint.withOpacity(0.2) : context.lightGray,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              feature,
              style: context.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: context.textPrimary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              free,
              style: context.bodySmall?.copyWith(
                color: context.textHint,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              premium,
              style: context.bodySmall?.copyWith(
                color: context.accentPurple,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              premiumPlus,
              style: context.bodySmall?.copyWith(
                color: context.success,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQItem(
      BuildContext context, {
        required String question,
        required String answer,
        bool isLast = false,
      }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : context.spacingMD),
      padding: EdgeInsets.all(context.spacingMD),
      decoration: BoxDecoration(
        color: isDark ? context.darkCard : context.white,
        borderRadius: BorderRadius.circular(context.radiusMD),
        border: Border.all(
          color: isDark ? context.darkTextHint.withOpacity(0.2) : context.lightGray,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.help_outline,
                size: 18,
                color: context.accentPurple,
              ),
              SizedBox(width: context.spacingSM),
              Expanded(
                child: Text(
                  question,
                  style: context.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: context.spacingSM),
          Padding(
            padding: EdgeInsets.only(left: 30),
            child: Text(
              answer,
              style: context.bodySmall?.copyWith(
                color: context.textHint,
              ),
            ),
          ),
        ],
      ),
    );
  }
}