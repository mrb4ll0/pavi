import 'package:flutter/material.dart';
import 'package:pavi/core/general/generalMethods.dart';
import 'package:pavi/theme/generalTheme.dart';

import '../homeScreen/buyData/buyDataPage.dart';
import '../homeScreen/startTask/startTaskPage.dart';
import '../paybill/paybillPage.dart';


class MoreServicesPage extends StatelessWidget {
  const MoreServicesPage({super.key});

  final List<Map<String, dynamic>> _allServices = const [
    {
      'name': 'Buy Data',
      'icon': Icons.wifi,
      'color': 0xFF2196F3,
      'description': 'Purchase data bundles',
      'route': 'buy_data',
    },
    {
      'name': 'Pay Bill',
      'icon': Icons.receipt,
      'color': 0xFFFF9800,
      'description': 'Pay electricity & TV bills',
      'route': 'pay_bill',
    },
    {
      'name': 'Start Task',
      'icon': Icons.task,
      'color': 0xFF4CAF50,
      'description': 'Complete tasks & earn',
      'route': 'start_task',
    },
    {
      'name': 'Airtime',
      'icon': Icons.phone_android,
      'color': 0xFF9C27B0,
      'description': 'Recharge airtime',
      'route': 'airtime',
    },
    {
      'name': 'Cable TV',
      'icon': Icons.tv,
      'color': 0xFFF44336,
      'description': 'DSTV, GOTV, Startimes',
      'route': 'cable_tv',
    },
    {
      'name': 'Electricity',
      'icon': Icons.electric_bolt,
      'color': 0xFFFFC107,
      'description': 'Prepaid & postpaid',
      'route': 'electricity',
    },
    {
      'name': 'Education',
      'icon': Icons.school,
      'color': 0xFF3F51B5,
      'description': 'School fees & exams',
      'route': 'education',
    },
    {
      'name': 'Loans',
      'icon': Icons.credit_card,
      'color': 0xFF009688,
      'description': 'Repay loans',
      'route': 'loan',
    },
    {
      'name': 'Insurance',
      'icon': Icons.security,
      'color': 0xFF00BCD4,
      'description': 'Insurance policies',
      'route': 'insurance',
    },
    {
      'name': 'Flights',
      'icon': Icons.flight,
      'color': 0xFFE91E63,
      'description': 'Book flights',
      'route': 'flight',
    },
    {
      'name': 'Hotels',
      'icon': Icons.hotel,
      'color': 0xFFCDDC39,
      'description': 'Book hotels',
      'route': 'hotel',
    },
    {
      'name': 'Events',
      'icon': Icons.event,
      'color': 0xFF673AB7,
      'description': 'Event tickets',
      'route': 'events',
    },
    {
      'name': 'Gift Cards',
      'icon': Icons.card_giftcard,
      'color': 0xFFFF6B6B,
      'description': 'Buy & send cards',
      'route': 'gift_cards',
    },
    {
      'name': 'Data Top-up',
      'icon': Icons.signal_cellular_alt,
      'color': 0xFF4ECDC4,
      'description': 'Top-up data',
      'route': 'data_topup',
    },
    {
      'name': 'SME Services',
      'icon': Icons.business,
      'color': 0xFFFF9F4A,
      'description': 'Business solutions',
      'route': 'sme',
    },
    {
      'name': 'Donations',
      'icon': Icons.favorite,
      'color': 0xFFFF6B6B,
      'description': 'Support charities',
      'route': 'donations',
    },
  ];

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
          'All Services',
          style: context.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: context.textPrimary,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              // Search functionality
            },
            icon: Icon(
              Icons.search,
              color: context.textPrimary,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Featured Banner
          Container(
            margin: EdgeInsets.all(context.spacingLG),
            padding: EdgeInsets.all(context.spacingMD),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  context.accentPurple,
                  context.accentPurpleDark,
                ],
              ),
              borderRadius: BorderRadius.circular(context.radiusLG),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Quick Access',
                        style: context.bodySmall?.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Your most used services',
                        style: context.titleSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(context.spacingSM),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.stars,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),

          // Services Grid - FIXED with proper sizing
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(context.spacingLG),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: context.spacingMD,
                mainAxisSpacing: context.spacingMD,
                // Fixed aspect ratio to prevent overflow
                childAspectRatio: 0.85, // Changed from 1.2 to 0.85 for more height
              ),
              itemCount: _allServices.length,
              itemBuilder: (context, index) {
                final service = _allServices[index];
                return _buildServiceCard(context, service);
              },
            ),
          ),
        ],
      ),
    );
  }

  // FIXED Service Card - Prevents overflow
  Widget _buildServiceCard(BuildContext context, Map<String, dynamic> service) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = Color(service['color'] as int);

    return GestureDetector(
      onTap: () {
        _navigateToService(context, service['route'] as String);
      },
      child: Container(
        padding: EdgeInsets.all(context.spacingSM), // Reduced padding
        decoration: BoxDecoration(
          color: isDark ? context.darkCard : context.white,
          borderRadius: BorderRadius.circular(context.radiusLG),
          border: Border.all(
            color: isDark ? context.darkTextHint.withOpacity(0.2) : context.lightGray,
          ),
          boxShadow: isDark ? null : context.shadowSM,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min, // Important: Prevents overflow
          children: [
            Container(
              width: 50, // Reduced from 60
              height: 50, // Reduced from 60
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    color.withOpacity(0.2),
                    color.withOpacity(0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(context.radiusMD),
              ),
              child: Icon(
                service['icon'] as IconData,
                color: color,
                size: 28, // Reduced from 32
              ),
            ),
            SizedBox(height: context.spacingSM),
            Text(
              service['name'] as String,
              style: context.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: context.textPrimary,
                fontSize: 13, // Explicit font size
              ),
              textAlign: TextAlign.center,
              maxLines: 1, // Limit to 1 line
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4),
            Text(
              service['description'] as String,
              style: context.labelSmall?.copyWith(
                color: context.textHint,
                fontSize: 10, // Smaller font
              ),
              textAlign: TextAlign.center,
              maxLines: 1, // Changed to 1 line to prevent overflow
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToService(BuildContext context, String route) {
    switch (route) {
      case 'buy_data':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BuyDataPage()),
        );
        break;
      case 'pay_bill':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PayBillPage()),
        );
        break;
      case 'start_task':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const StartTaskPage()),
        );
        break;
      default:
      // Show coming soon dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: context.surfaceColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(context.radiusLG),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(context.spacingLG),
                  decoration: BoxDecoration(
                    color: context.info.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.build,
                    color: context.info,
                    size: 48,
                  ),
                ),
                SizedBox(height: context.spacingLG),
                Text(
                  'Coming Soon!',
                  style: context.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: context.spacingSM),
                Text(
                  'This service will be available soon. Stay tuned!',
                  textAlign: TextAlign.center,
                  style: context.bodyMedium,
                ),
              ],
            ),
            actions: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.accentPurple,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: context.spacingMD),
                  ),
                  child: const Text('Got it'),
                ),
              ),
            ],
          ),
        );
        break;
    }
  }
}