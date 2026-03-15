import 'package:flutter/material.dart';
import 'package:pavi/home/homeScreen/esim/esimDetailsPage.dart';
import 'package:pavi/home/homeScreen/transaction/transactionHistoryPage.dart';
import 'package:pavi/home/message/messageListScreen.dart';
import 'package:pavi/home/wallet/screen/redemptionScreen.dart';
import '../../core/general/generalMethods.dart';
import '../../profile/profilePage.dart';
import '../../theme/generalTheme.dart';
import '../dialer/trainingCenter.dart';
import 'notification.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeDashboard(),
    MessageListScreen(),
    TrainingCenter(),
    RedemptionScreen(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: context.backgroundColor,
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: context.surfaceColor,
          boxShadow: isDark ? null : [
            BoxShadow(
              color: context.textPrimary.withOpacity(0.05),
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
          backgroundColor: context.surfaceColor,
          selectedItemColor: isDark ? context.accentPurple : context.primaryColor,
          unselectedItemColor: context.textHint,
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
              icon: Icon(Icons.message_outlined),
              activeIcon: Icon(Icons.message),
              label: 'Message',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.smart_toy_outlined),
              activeIcon: Icon(Icons.smart_toy),
              label: 'Training Center',
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.card_giftcard_outlined),
              activeIcon: Icon(Icons.card_giftcard),
              label: 'Redemption',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

class HomeDashboard extends StatelessWidget {
  const HomeDashboard({super.key});

  // Sample recent activity data
  final List<Map<String, dynamic>> _recentActivity = const [
    {
      'title': 'Completed Task - Survey',
      'amount': '+₦500',
      'time': '2 mins ago',
      'type': 'earned',
      'icon': Icons.task_alt,
      'color': 0xFF4CAF50,
    },
    {
      'title': 'Data Purchase - 2GB',
      'amount': '-₦1,200',
      'time': '15 mins ago',
      'type': 'spent',
      'icon': Icons.wifi,
      'color': 0xFF2196F3,
    },
    {
      'title': 'Referral Bonus',
      'amount': '+₦1,000',
      'time': '1 hour ago',
      'type': 'earned',
      'icon': Icons.share,
      'color': 0xFF9C27B0,
    },
    {
      'title': 'Bill Payment - Electricity',
      'amount': '-₦3,500',
      'time': '3 hours ago',
      'type': 'spent',
      'icon': Icons.lightbulb,
      'color': 0xFFFF9800,
    },
    {
      'title': 'Daily Check-in Bonus',
      'amount': '+₦50',
      'time': '5 hours ago',
      'type': 'earned',
      'icon': Icons.star,
      'color': 0xFFF44336,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final pocketCoins = '2,450'; // Sample data
    final nairaValue = '₦12,250'; // Sample conversion (₦5 per coin)

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Bar with profile (kept similar but more social feed feel)
            Padding(
              padding: EdgeInsets.all(context.spacingLG),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              context.accentPurple,
                              context.accentPurpleDark,
                            ],
                          ),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: context.accentPurpleLight.withOpacity(0.5),
                            width: 2,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'DA',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: context.spacingSM),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome to Dexter',
                            style: context.bodySmall?.copyWith(
                              color: context.textHint,
                            ),
                          ),
                          Text(
                            'Ambrose Escrow',
                            style: context.titleSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: context.accentPurple,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      // Premium feel with subtle shine effect
                      Container(
                        padding: EdgeInsets.all(context.spacingXS),
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            colors: [
                              context.accentPurple.withOpacity(0.2),
                              Colors.transparent,
                            ],
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.bolt,
                          size: 20,
                          color: context.accentPurple,
                        ),
                      ),
                      SizedBox(width: context.spacingXS),
                      Container(
                        padding: EdgeInsets.all(context.spacingXS),
                        decoration: BoxDecoration(
                          color: isDark ? context.darkSurface : context.white,
                          shape: BoxShape.circle,
                          boxShadow: isDark ? null : context.shadowSM,
                        ),
                        child: Icon(
                          Icons.more_horiz,
                          size: 20,
                          color: context.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Premium Coin Balance Card
            Container(
              margin: EdgeInsets.symmetric(horizontal: context.spacingLG),
              padding: EdgeInsets.all(context.spacingLG),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDark
                      ? [
                    context.accentPurple.withOpacity(0.9),
                    context.accentPurpleDark.withOpacity(0.8),
                    context.darkCard,
                  ]
                      : [
                    context.primaryColor,
                    context.primaryPurpleDark,
                    const Color(0xFF1E293B),
                  ],
                ),
                borderRadius: BorderRadius.circular(context.radiusLG),
                boxShadow: [
                  BoxShadow(
                    color: (isDark ? context.accentPurple : context.primaryColor).withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(context.spacingXS),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.account_balance_wallet,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: context.spacingXS),
                          Text(
                            'Pocket Coins',
                            style: context.titleSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.spacingSM,
                          vertical: context.spacingXXS,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(context.radiusXL),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.trending_up,
                              size: 12,
                              color: Colors.white,
                            ),
                            SizedBox(width: 2),
                            Text(
                              '+12%',
                              style: context.labelSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.spacingMD),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        pocketCoins,
                        style: context.displaySmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 36,
                        ),
                      ),
                      SizedBox(width: context.spacingXS),
                      Padding(
                        padding: EdgeInsets.only(bottom: 6),
                        child: Text(
                          'coins',
                          style: context.bodySmall?.copyWith(
                            color: Colors.white70,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.spacingXS),
                  Text(
                    '≈ $nairaValue',
                    style: context.bodyMedium?.copyWith(
                      color: Colors.white70,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: context.spacingMD),
                  // Quick stats
                  Row(
                    children: [
                      _buildCoinStat(context, 'Earned', '₦8,500', Icons.arrow_upward, Colors.green),
                      Container(
                        height: 24,
                        width: 1,
                        color: Colors.white.withOpacity(0.2),
                        margin: EdgeInsets.symmetric(horizontal: context.spacingMD),
                      ),
                      _buildCoinStat(context, 'Spent', '₦3,250', Icons.arrow_downward, Colors.orange),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: context.spacingXL),

            // Quick Actions - Large buttons
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.spacingLG),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quick Actions',
                    style: context.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: context.textPrimary,
                    ),
                  ),
                  SizedBox(height: context.spacingMD),
                  Row(
                    children: [
                      Expanded(
                        child: _buildLargeQuickAction(
                          context,
                          icon: Icons.wifi,
                          label: 'Buy Data',
                          color: context.info,
                          gradientColors: [context.info, context.info.withOpacity(0.7)],
                        ),
                      ),
                      SizedBox(width: context.spacingMD),
                      Expanded(
                        child: _buildLargeQuickAction(
                          context,
                          icon: Icons.receipt,
                          label: 'Pay Bill',
                          color: context.warning,
                          gradientColors: [context.warning, context.warning.withOpacity(0.7)],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.spacingMD),
                  Row(
                    children: [
                      Expanded(
                        child: _buildLargeQuickAction(
                          context,
                          icon: Icons.task,
                          label: 'Start Task',
                          color: context.success,
                          gradientColors: [context.success, context.success.withOpacity(0.7)],
                        ),
                      ),
                      SizedBox(width: context.spacingMD),
                      Expanded(
                        child: _buildLargeQuickAction(
                          context,
                          icon: Icons.more_horiz,
                          label: 'More',
                          color: context.textSecondary,
                          gradientColors: [context.textSecondary, context.textHint],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: context.spacingXL),

            // Recent Activity (scrollable list)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.spacingLG),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(context.spacingXS),
                            decoration: BoxDecoration(
                              color: (isDark ? context.accentPurple : context.primaryColor).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(context.radiusSM),
                            ),
                            child: Icon(
                              Icons.history_toggle_off,
                              size: 18,
                              color: isDark ? context.accentPurple : context.primaryColor,
                            ),
                          ),
                          SizedBox(width: context.spacingSM),
                          Text(
                            'Recent Activity',
                            style: context.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: context.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TransactionHistoryPage(),
                            ),
                          );
                        },
                        child: Text(
                          'See All',
                          style: context.labelSmall?.copyWith(
                            color: isDark ? context.accentPurple : context.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.spacingMD),
                  // Scrollable recent activity list
                  SizedBox(
                    height: 280, // Fixed height for scrolling
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemCount: _recentActivity.length,
                      separatorBuilder: (context, index) => Divider(
                        height: 1,
                        color: isDark ? context.darkTextHint.withOpacity(0.2) : context.lightGray,
                      ),
                      itemBuilder: (context, index) {
                        final activity = _recentActivity[index];
                        return _buildActivityItem(context, activity);
                      },
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: context.spacingXL),

            // Social Feed Style - Trending Tasks
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.spacingLG),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.trending_up,
                        size: 20,
                        color: context.accentPurple,
                      ),
                      SizedBox(width: context.spacingXS),
                      Text(
                        'Trending Tasks',
                        style: context.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: context.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.spacingMD),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildTrendingTaskCard(
                          context,
                          title: 'Quick Survey',
                          reward: '₦500',
                          time: '5 mins',
                          participants: '1.2k',
                          color: context.success,
                        ),
                        SizedBox(width: context.spacingMD),
                        _buildTrendingTaskCard(
                          context,
                          title: 'App Testing',
                          reward: '₦2,000',
                          time: '30 mins',
                          participants: '856',
                          color: context.info,
                        ),
                        SizedBox(width: context.spacingMD),
                        _buildTrendingTaskCard(
                          context,
                          title: 'Watch Video',
                          reward: '₦300',
                          time: '3 mins',
                          participants: '3.4k',
                          color: context.warning,
                        ),
                      ],
                    ),
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

  Widget _buildCoinStat(BuildContext context, String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Row(
        children: [
          Icon(icon, size: 14, color: color),
          SizedBox(width: 4),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: context.labelSmall?.copyWith(
                  color: Colors.white70,
                  fontSize: 10,
                ),
              ),
              Text(
                value,
                style: context.bodySmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLargeQuickAction(BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required List<Color> gradientColors,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ),
        borderRadius: BorderRadius.circular(context.radiusLG),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(context.radiusLG),
          onTap: () {
            debugPrint('$label tapped');
          },
          child: Padding(
            padding: EdgeInsets.all(context.spacingMD),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 32,
                  color: Colors.white,
                ),
                SizedBox(height: context.spacingXS),
                Text(
                  label,
                  style: context.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActivityItem(BuildContext context, Map<String, dynamic> activity) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isEarned = activity['type'] == 'earned';
    final color = Color(activity['color'] as int);

    return Container(
      padding: EdgeInsets.symmetric(vertical: context.spacingSM),
      child: Row(
        children: [
          // Icon with gradient background
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color.withOpacity(0.2),
                  color.withOpacity(0.1),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              activity['icon'] as IconData,
              color: color,
              size: 22,
            ),
          ),
          SizedBox(width: context.spacingSM),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity['title'] as String,
                  style: context.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.textPrimary,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  activity['time'] as String,
                  style: context.labelSmall?.copyWith(
                    color: context.textHint,
                  ),
                ),
              ],
            ),
          ),

          // Amount
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: context.spacingSM,
              vertical: context.spacingXXS,
            ),
            decoration: BoxDecoration(
              color: (isEarned ? context.success : context.error).withOpacity(0.1),
              borderRadius: BorderRadius.circular(context.radiusSM),
            ),
            child: Text(
              activity['amount'] as String,
              style: context.bodySmall?.copyWith(
                color: isEarned ? context.success : context.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingTaskCard(BuildContext context, {
    required String title,
    required String reward,
    required String time,
    required String participants,
    required Color color,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 180,
      padding: EdgeInsets.all(context.spacingMD),
      decoration: BoxDecoration(
        color: isDark ? context.darkCard : context.white,
        borderRadius: BorderRadius.circular(context.radiusLG),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: isDark ? null : context.shadowSM,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.bolt,
                  size: 12,
                  color: color,
                ),
              ),
              SizedBox(width: 4),
              Expanded(
                child: Text(
                  title,
                  style: context.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: context.spacingSM),
          Text(
            reward,
            style: context.titleMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: context.spacingXS),
          Row(
            children: [
              Icon(
                Icons.timer_outlined,
                size: 12,
                color: context.textHint,
              ),
              SizedBox(width: 2),
              Text(
                time,
                style: context.labelSmall?.copyWith(
                  color: context.textHint,
                ),
              ),
              SizedBox(width: context.spacingSM),
              Icon(
                Icons.people_outline,
                size: 12,
                color: context.textHint,
              ),
              SizedBox(width: 2),
              Text(
                participants,
                style: context.labelSmall?.copyWith(
                  color: context.textHint,
                ),
              ),
            ],
          ),
          SizedBox(height: context.spacingSM),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: context.spacingXS),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color.withOpacity(0.2),
                  color.withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(context.radiusSM),
            ),
            child: Center(
              child: Text(
                'Start Task',
                style: context.labelSmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}