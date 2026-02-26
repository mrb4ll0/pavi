import 'package:flutter/material.dart';
import 'package:pavi/home/message/messageListScreen.dart';
import '../theme/generalTheme.dart';
import 'dialer/dialerPage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeDashboard(),
    const DialerScreen(),
    const MessageListScreen(),
    const WalletScreen(),
    const VirtualNumberScreen(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.offWhite,
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: context.deepNavy.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: context.primaryGreen,
          unselectedItemColor: context.mediumGray,
          selectedLabelStyle: context.labelSmall?.copyWith(
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: context.labelSmall?.copyWith(
            fontSize: 11,
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.phone_outlined),
              activeIcon: Icon(Icons.phone),
              label: 'Dialer',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message_outlined),
              activeIcon: Icon(Icons.message),
              label: 'Message',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet_outlined),
              activeIcon: Icon(Icons.account_balance_wallet),
              label: 'Wallet',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sim_card_outlined),
              activeIcon: Icon(Icons.sim_card),
              label: 'Virtual No',
            ),

          ],
        ),
      ),
    );
  }
}

class HomeDashboard extends StatelessWidget {
  const HomeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Bar with profile
            Padding(
              padding: EdgeInsets.all(context.spacingLG),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: context.primaryGradient,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Text(
                            'JD',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: context.spacingSM),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome back,',
                            style: context.bodySmall?.copyWith(
                              color: context.mediumGray,
                            ),
                          ),
                          Text(
                            'John Doe',
                            style: context.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(context.spacingXS),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: context.shadowSM,
                        ),
                        child: Icon(
                          Icons.notifications_none_outlined,
                          size: 20,
                          color: context.deepNavy,
                        ),
                      ),
                      SizedBox(width: context.spacingSM),
                      Container(
                        padding: EdgeInsets.all(context.spacingXS),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: context.shadowSM,
                        ),
                        child: Icon(
                          Icons.more_horiz,
                          size: 20,
                          color: context.deepNavy,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Virtual Mobile - No SIM tagline
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.spacingLG),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.spacingSM,
                      vertical: context.spacingXXS,
                    ),
                    decoration: BoxDecoration(
                      color: context.primaryGreen.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(context.radiusXS),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.sim_card_outlined,
                          size: 12,
                          color: context.primaryGreen,
                        ),
                        SizedBox(width: context.spacingXXS),
                        Text(
                          'Virtual Mobile',
                          style: context.labelSmall?.copyWith(
                            color: context.primaryGreen,
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: context.spacingXS),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.spacingSM,
                      vertical: context.spacingXXS,
                    ),
                    decoration: BoxDecoration(
                      color: context.actionAmber.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(context.radiusXS),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.wifi,
                          size: 12,
                          color: context.actionAmber,
                        ),
                        SizedBox(width: context.spacingXXS),
                        Text(
                          'No SIM',
                          style: context.labelSmall?.copyWith(
                            color: context.actionAmber,
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: context.spacingXS),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.spacingSM,
                      vertical: context.spacingXXS,
                    ),
                    decoration: BoxDecoration(
                      color: context.info.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(context.radiusXS),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.language,
                          size: 12,
                          color: context.info,
                        ),
                        SizedBox(width: context.spacingXXS),
                        Text(
                          'Local Anywhere',
                          style: context.labelSmall?.copyWith(
                            color: context.info,
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: context.spacingLG),

            // NumeroMoney Card
            Container(
              margin: EdgeInsets.symmetric(horizontal: context.spacingLG),
              padding: EdgeInsets.all(context.spacingLG),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
                ),
                borderRadius: BorderRadius.circular(context.radiusLG),
                boxShadow: context.shadowLG,
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
                          color: Colors.white70,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.spacingSM,
                          vertical: context.spacingXXS,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(context.radiusSM),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 10,
                              color: Colors.white70,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.spacingSM),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '₦0.00',
                        style: context.displaySmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),
                      SizedBox(width: context.spacingXXS),
                      Text(
                        '>',
                        style: context.titleLarge?.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.spacingSM),
                  Row(
                    children: [
                      _buildCardTag(context, 'Phone Numbers'),
                      SizedBox(width: context.spacingSM),
                      _buildCardTag(context, 'Data eSIMs'),
                      SizedBox(width: context.spacingSM),
                      _buildCardTag(context, 'Calling Plans'),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: context.spacingXL),

            // Quick Actions
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.spacingLG),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Quick Actions',
                        style: context.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'View All',
                          style: context.labelSmall?.copyWith(
                            color: context.primaryGreen,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.spacingMD),
                  Row(
                    children: [
                      Expanded(
                        child: _buildQuickAction(
                          context,
                          icon: Icons.phone,
                          label: 'Quick Call',
                          color: context.primaryGreen,
                        ),
                      ),
                      SizedBox(width: context.spacingMD),
                      Expanded(
                        child: _buildQuickAction(
                          context,
                          icon: Icons.add_chart,
                          label: 'Buy Minutes',
                          color: context.actionAmber,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: context.spacingXL),

            // eSIM & Calling Plans
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.spacingLG),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Full eSIMs (Calls+Data)',
                    style: context.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: context.spacingMD),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildPlanCard(
                          context,
                          title: 'eSIM:',
                          subtitle: 'Nigeria Plan',
                          data: '5GB',
                          days: '30',
                          price: '₦2,500',
                          color: context.primaryGreen,
                        ),
                        SizedBox(width: context.spacingMD),
                        _buildPlanCard(
                          context,
                          title: 'Calling Plans',
                          subtitle: 'Unlimited Local',
                          data: 'Unlimited',
                          days: '30',
                          price: '₦3,500',
                          color: context.actionAmber,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: context.spacingXL),

            // Refer & Earn
            Container(
              margin: EdgeInsets.symmetric(horizontal: context.spacingLG),
              padding: EdgeInsets.all(context.spacingLG),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    context.actionAmber,
                    context.actionAmberDark,
                  ],
                ),
                borderRadius: BorderRadius.circular(context.radiusLG),
                boxShadow: context.shadowMD,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Refer & Earn',
                          style: context.titleMedium?.copyWith(
                            color: context.deepNavy,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: context.spacingXXS),
                        Text(
                          'Give €3 and get €3!',
                          style: context.bodyMedium?.copyWith(
                            color: context.deepNavy,
                          ),
                        ),
                        SizedBox(height: context.spacingSM),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.spacingMD,
                            vertical: context.spacingXS,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(context.radiusSM),
                          ),
                          child: Text(
                            'Refer Now',
                            style: context.labelSmall?.copyWith(
                              color: context.deepNavy,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.share,
                      size: 40,
                      color: context.deepNavy,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: context.spacingXL),

            // Recent Calls
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.spacingLG),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recent Calls',
                        style: context.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'View All',
                          style: context.labelSmall?.copyWith(
                            color: context.primaryGreen,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.spacingMD),
                  _buildRecentCall(
                    context,
                    name: 'Mum',
                    number: '+234 802 345 6789',
                    time: 'Today, 10:30 AM',
                    type: 'outgoing',
                    duration: '5:23',
                  ),
                  _buildRecentCall(
                    context,
                    name: 'John Smith',
                    number: '+234 803 456 7890',
                    time: 'Yesterday, 8:15 PM',
                    type: 'incoming',
                    duration: '12:45',
                  ),
                  _buildRecentCall(
                    context,
                    name: 'Business Client',
                    number: '+234 805 678 9012',
                    time: 'Yesterday, 3:20 PM',
                    type: 'missed',
                    duration: '0:00',
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

  Widget _buildCardTag(BuildContext context, String text) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.spacingSM,
        vertical: context.spacingXXS,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(context.radiusSM),
      ),
      child: Text(
        text,
        style: context.labelSmall?.copyWith(
          color: Colors.white,
          fontSize: 10,
        ),
      ),
    );
  }

  Widget _buildQuickAction(BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(context.spacingMD),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.radiusMD),
        boxShadow: context.shadowSM,
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(context.spacingSM),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          SizedBox(height: context.spacingXS),
          Text(
            label,
            style: context.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCard(BuildContext context, {
    required String title,
    required String subtitle,
    required String data,
    required String days,
    required String price,
    required Color color,
  }) {
    return Container(
      width: 160,
      padding: EdgeInsets.all(context.spacingMD),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.radiusMD),
        boxShadow: context.shadowSM,
        border: Border.all(
          color: context.lightGray,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: context.spacingXXS),
          Text(
            subtitle,
            style: context.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: context.spacingSM),
          Row(
            children: [
              Icon(
                Icons.data_usage,
                size: 14,
                color: context.mediumGray,
              ),
              SizedBox(width: context.spacingXXS),
              Text(
                data,
                style: context.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: context.spacingXXS),
          Row(
            children: [
              Icon(
                Icons.timer_outlined,
                size: 14,
                color: context.mediumGray,
              ),
              SizedBox(width: context.spacingXXS),
              Text(
                '$days days',
                style: context.bodySmall,
              ),
            ],
          ),
          SizedBox(height: context.spacingSM),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                price,
                style: context.titleSmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: EdgeInsets.all(context.spacingXXS),
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_forward,
                  size: 12,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentCall(BuildContext context, {
    required String name,
    required String number,
    required String time,
    required String type,
    required String duration,
  }) {
    IconData icon;
    Color color;

    switch (type) {
      case 'incoming':
        icon = Icons.call_received;
        color = context.success;
        break;
      case 'outgoing':
        icon = Icons.call_made;
        color = context.primaryGreen;
        break;
      case 'missed':
        icon = Icons.call_missed;
        color = context.error;
        break;
      default:
        icon = Icons.call;
        color = context.mediumGray;
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: context.spacingSM),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: context.lightGray,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 18,
            ),
          ),
          SizedBox(width: context.spacingSM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: context.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  number,
                  style: context.bodySmall?.copyWith(
                    color: context.mediumGray,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                time,
                style: context.labelSmall?.copyWith(
                  color: context.mediumGray,
                  fontSize: 10,
                ),
              ),
              if (type != 'missed')
                Text(
                  duration,
                  style: context.labelSmall?.copyWith(
                    color: context.primaryGreen,
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}


class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Wallet Screen',
        style: context.titleLarge,
      ),
    );
  }
}

class VirtualNumberScreen extends StatelessWidget {
  const VirtualNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Virtual Number Screen',
        style: context.titleLarge,
      ),
    );
  }
}

