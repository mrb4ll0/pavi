import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pavi/theme/generalTheme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with TickerProviderStateMixin {
  late TabController _tabController;
  final NumberFormat _coinFormat = NumberFormat('#,###');
  final DateFormat _dateFormat = DateFormat('MMM dd, yyyy');

  // User Profile Data
  String _userName = "John Doe";
  String _userAvatar = "JD";
  String _userTier = "Gold Tier";
  String _tierDescription = "Top 10% Earner";
  bool _isVerified = true;
  bool _isKycCompleted = true;

  // Stats Data
  int _lifetimeEarnings = 45678;
  int _currentStreak = 7;
  int _tasksCompleted = 4567;
  int _totalHoursEarned = 23;

  // Referral Data
  String _referralCode = "POCKET_JOHN";
  int _friendsJoined = 12;
  int _referralEarnings = 2500;

  // Transaction Summary
  int _todayEarnings = 150;
  int _yesterdayRedemption = 3500;
  int _weeklyNetEarnings = 2450;

  // Settings state
  bool _notificationsEnabled = true;
  bool _darkMode = false;
  String _selectedLanguage = "English";
  final List<String> _languages = ["English", "Hausa", "Pidgin"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _shareReferralLink() {
    _showSuccessSnackBar('Referral link copied to clipboard!');
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: context.backgroundColor,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: MediaQuery.of(context).size.height * 0.4,
              floating: true,
              snap: true,
              pinned: false,
              flexibleSpace: LayoutBuilder(
                builder: (context, constraints) {
                  return FlexibleSpaceBar(
                    background: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.amber.shade400,
                            Colors.amber.shade700,
                          ],
                        ),
                      ),
                      child: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Profile Header
                              Row(
                                children: [
                                  // Avatar
                                  Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 3,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        _userAvatar,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  // Name and Tier
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _userName,
                                          style: theme.textTheme.headlineSmall?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 4,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.amber.shade300,
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Icon(
                                                    Icons.emoji_events,
                                                    color: Colors.white,
                                                    size: 14,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    _userTier,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            if (_isVerified)
                                              Container(
                                                padding: const EdgeInsets.all(2),
                                                decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Icon(
                                                  Icons.check,
                                                  color: Colors.white,
                                                  size: 12,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),

                              // Stats Row
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  _buildProfileStat(
                                    context,
                                    value: _coinFormat.format(_lifetimeEarnings),
                                    label: 'Lifetime',
                                    icon: Icons.monetization_on,
                                  ),
                                  _buildProfileStat(
                                    context,
                                    value: '$_currentStreak',
                                    label: 'Streak',
                                    icon: Icons.local_fire_department,
                                  ),
                                  _buildProfileStat(
                                    context,
                                    value: '${_tasksCompleted ~/ 1000}K',
                                    label: 'Tasks',
                                    icon: Icons.task_alt,
                                  ),
                                  _buildProfileStat(
                                    context,
                                    value: '$_totalHoursEarned',
                                    label: 'Hours',
                                    icon: Icons.timer,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: Container(
                  color: Colors.transparent,
                  child: TabBar(
                    controller: _tabController,
                    indicatorColor: Colors.amber,
                    indicatorWeight: 3,
                    labelColor: Colors.amber,
                    unselectedLabelColor: Colors.white.withOpacity(0.7),
                    tabs: const [
                      Tab(text: 'Overview'),
                      Tab(text: 'Settings'),
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildOverviewTab(context),
            _buildSettingsTab(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileStat(
      BuildContext context, {
        required String value,
        required String label,
        required IconData icon,
      }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _buildOverviewTab(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Stats Card
        _buildStatsCard(context),
        const SizedBox(height: 16),

        // Referral Section
        _buildReferralCard(context),
        const SizedBox(height: 16),

        // Verification Status
        _buildVerificationCard(context),
        const SizedBox(height: 16),

        // Transaction Summary
        _buildTransactionSummaryCard(context),
        const SizedBox(height: 16),

        // Quick Actions
        _buildQuickActionsCard(context),
        const SizedBox(height: 16),

        // Support Section
        _buildSupportCard(context),
      ],
    );
  }

  Widget _buildStatsCard(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? context.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.analytics,
                  color: Colors.amber,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Statistics',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  context: context,
                  value: _coinFormat.format(_lifetimeEarnings),
                  label: 'Total Earned',
                  icon: Icons.monetization_on,
                  color: Colors.green,
                  subtitle: '≈ ₦${(_lifetimeEarnings / 10).floor()} saved',
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  context: context,
                  value: '$_currentStreak',
                  label: 'Current Streak',
                  icon: Icons.local_fire_department,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  context: context,
                  value: _coinFormat.format(_tasksCompleted),
                  label: 'Tasks Done',
                  icon: Icons.task_alt,
                  color: Colors.blue,
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  context: context,
                  value: '$_totalHoursEarned',
                  label: 'Hours Earned',
                  icon: Icons.timer,
                  color: Colors.purple,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Fix 1: Add null checks in _buildStatItem
  Widget _buildStatItem({
    required BuildContext context,
    required String value,
    required String label,
    required IconData icon,
    required Color color,
    String? subtitle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min, // Add this
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 14),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                value ?? '0', // Add null check
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label ?? '', // Add null check
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Colors.green,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }




  Widget _buildReferralCard(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      key: const ValueKey('referral_card'),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.purple.shade400,
            Colors.purple.shade700,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // FIXED: Header Row - Wrap text with Expanded
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.people, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              // Add Expanded here to prevent overflow
              Expanded(
                child: Text(
                  'Invite Friends, Earn Together!',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14, // Slightly reduced from 16
                  ),
                  maxLines: 2, // Allow wrapping to 2 lines
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Code and Friends Count Row
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                // Your Code Section
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Code',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _referralCode ?? 'POCKET_USER',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16, // Reduced from 18
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                // Divider
                Container(
                  height: 30,
                  width: 1,
                  color: Colors.white.withOpacity(0.3),
                ),

                // Friends Joined Section
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Friends Joined',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${_friendsJoined ?? 0}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16, // Reduced from 18
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Earnings and Share Button Row
          Row(
            children: [
              // Earnings Display
              Expanded( // Changed from Flexible with flex to Expanded
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10, // Reduced from 12
                    vertical: 6, // Reduced from 8
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.monetization_on,
                        color: Colors.white,
                        size: 14, // Reduced from 16
                      ),
                      const SizedBox(width: 2), // Reduced from 4
                      Flexible(
                        child: Text(
                          '+${_safeFormatNumber(_referralEarnings)}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12, // Reduced from default
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(width: 2), // Reduced from 4
                      Flexible(
                        child: Text(
                          'earned',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 11, // Reduced from 12
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 8), // Reduced from 12

              // Share Button
              SizedBox(
                width: 90, // Reduced from 100
                child: ElevatedButton(
                  onPressed: _shareReferralLink,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.purple,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8, // Reduced from 12
                      vertical: 6, // Reduced from 8
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: const Size(70, 32), // Reduced from 80,36
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Make hit area smaller
                  ),
                  child: const Text(
                    'SHARE',
                    style: TextStyle(fontSize: 11), // Reduced from 12
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

// Also fix the _buildActionButton method if it's causing issues
  Widget _buildActionButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        constraints: const BoxConstraints(minHeight: 48), // Add constraints
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: color,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

// Add this helper method for safe number formatting
  String _safeFormatNumber(dynamic number) {
    if (number == null) return '0';
    try {
      if (number is int) {
        return _coinFormat.format(number);
      } else if (number is double) {
        return _coinFormat.format(number.toInt());
      } else {
        return number.toString();
      }
    } catch (e) {
      return number.toString();
    }
  }

// Fix 4: Add keys to settings section
  Widget _buildSettingsTab(BuildContext context) {
    return ListView(
      key: const PageStorageKey('settings_tab'), // Add key
      padding: const EdgeInsets.all(16),
      children: [
        // Account Settings
        _buildSettingsSection(
          context: context,
          title: 'Account Settings',
          icon: Icons.person,
          color: Colors.blue,
          children: [
            _buildSettingsTile(
              context: context,
              icon: Icons.person_outline,
              title: 'Personal Information',
              subtitle: 'Name, email, phone',
              onTap: () {},
            ),
            _buildSettingsTile(
              context: context,
              icon: Icons.lock_outline,
              title: 'Security',
              subtitle: 'Password, 2FA',
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Notifications
        _buildSettingsSection(
          context: context,
          title: 'Notifications',
          icon: Icons.notifications,
          color: Colors.green,
          children: [
            SwitchListTile(
              key: const ValueKey('notification_switch'), // Add key
              value: _notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
              title: const Text('Push Notifications'),
              subtitle: const Text('Task reminders, earnings'),
              secondary: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.notifications, color: Colors.green),
              ),
              contentPadding: EdgeInsets.zero,
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Payment Methods
        _buildSettingsSection(
          context: context,
          title: 'Payment Methods',
          icon: Icons.payment,
          color: Colors.purple,
          children: [
            _buildSettingsTile(
              context: context,
              icon: Icons.phone_android,
              title: 'Mobile Money',
              subtitle: 'MTN, Airtel, Glo',
              onTap: () {},
            ),
            _buildSettingsTile(
              context: context,
              icon: Icons.account_balance,
              title: 'Bank Account',
              subtitle: 'Add withdrawal account',
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Appearance
        _buildSettingsSection(
          context: context,
          title: 'Appearance',
          icon: Icons.palette,
          color: Colors.orange,
          children: [
            SwitchListTile(
              key: const ValueKey('darkmode_switch'), // Add key
              value: _darkMode,
              onChanged: (value) {
                setState(() {
                  _darkMode = value;
                });
              },
              title: const Text('Dark Mode'),
              subtitle: const Text('Switch theme'),
              secondary: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _darkMode ? Icons.nightlight_round : Icons.wb_sunny,
                  color: Colors.orange,
                ),
              ),
              contentPadding: EdgeInsets.zero,
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Language
        _buildSettingsSection(
          context: context,
          title: 'Language',
          icon: Icons.language,
          color: Colors.teal,
          children: [
            Container(
              key: const ValueKey('language_selector'), // Add key
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.teal.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.language, color: Colors.teal),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Select Language',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 4),
                        DropdownButton<String>(
                          value: _selectedLanguage,
                          isDense: true,
                          underline: Container(),
                          onChanged: (String? value) {
                            if (value != null) {
                              setState(() {
                                _selectedLanguage = value;
                              });
                            }
                          },
                          items: _languages.map((String language) {
                            return DropdownMenuItem<String>(
                              value: language,
                              child: Text(language),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Version
        Container(
          key: const ValueKey('version_info'), // Add key
          padding: const EdgeInsets.all(20),
          child: const Center(
            child: Text(
              'Version 1.0.0',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVerificationCard(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? context.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.verified,
                  color: Colors.green,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Verification Status',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          _buildVerificationItem(
            context,
            icon: Icons.phone,
            label: 'Phone Number',
            status: 'Verified',
            isVerified: true,
          ),
          const SizedBox(height: 12),

          _buildVerificationItem(
            context,
            icon: Icons.badge,
            label: 'Identity (KYC)',
            status: _isKycCompleted ? 'Verified' : 'Pending',
            isVerified: _isKycCompleted,
            showButton: !_isKycCompleted,
          ),

          if (!_isKycCompleted) ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Complete KYC'),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildVerificationItem(
      BuildContext context, {
        required IconData icon,
        required String label,
        required String status,
        required bool isVerified,
        bool showButton = false,
      }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isVerified
                ? Colors.green.withOpacity(0.1)
                : Colors.orange.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: isVerified ? Colors.green : Colors.orange,
            size: 16,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                status,
                style: TextStyle(
                  color: isVerified ? Colors.green : Colors.orange,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionSummaryCard(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Make sure these are string values, not functions
    String todayAmount = '+${_coinFormat.format(_todayEarnings)}';
    String yesterdayAmount = '-${_coinFormat.format(_yesterdayRedemption)}';
    String weekAmount = '${_weeklyNetEarnings > 0 ? "+" : ""}${_coinFormat.format(_weeklyNetEarnings.abs())}';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? context.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.history, color: Colors.blue, size: 18),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Transaction Summary',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Navigate to full transaction history
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text('VIEW ALL', style: TextStyle(fontSize: 11)),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Transaction rows - passing string values directly
          _buildTransactionRow(
            context,
            label: 'Today',
            amountText: todayAmount,
            color: Colors.green,
          ),
          const SizedBox(height: 8),

          _buildTransactionRow(
            context,
            label: 'Yesterday',
            amountText: yesterdayAmount,
            color: Colors.amber,
          ),
          const SizedBox(height: 8),

          _buildTransactionRow(
            context,
            label: 'This Week',
            amountText: weekAmount,
            color: Colors.blue,
          ),
        ],
      ),
    );
  }

// Updated _buildTransactionRow that takes pre-formatted strings
  Widget _buildTransactionRow(
      BuildContext context, {
        required String label,
        required String amountText,
        required Color color,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          // Label
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          const SizedBox(width: 8),

          // Amount
          Container(
            constraints: const BoxConstraints(minWidth: 70),
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.monetization_on,
                  color: color,
                  size: 12,
                ),
                const SizedBox(width: 2),
                Flexible(
                  child: Text(
                    amountText,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsCard(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? context.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.bolt,
                  color: Colors.amber,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Quick Actions',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          _buildActionButton(
            context:context,
            icon: Icons.task,
            label: 'Start Earning',
            color: Colors.green,
            onTap: () {},
          ),
          const SizedBox(height: 8),

          _buildActionButton(
            context:context,
            icon: Icons.redeem,
            label: 'Redeem Coins',
            color: Colors.amber,
            onTap: () {},
          ),
          const SizedBox(height: 8),

          _buildActionButton(
            context:context,
            icon: Icons.help,
            label: 'Help Center',
            color: Colors.blue,
            onTap: () {},
          ),
        ],
      ),
    );
  }


  Widget _buildSupportCard(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? context.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSupportItem(
            context,
            icon: Icons.help_outline,
            label: 'Help Center',
            color: Colors.blue,
          ),
          const SizedBox(height: 12),
          _buildSupportItem(
            context,
            icon: Icons.headset_mic,
            label: 'Contact Support',
            color: Colors.purple,
          ),
          const SizedBox(height: 12),
          _buildSupportItem(
            context,
            icon: Icons.description,
            label: 'Terms & Privacy',
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _buildSupportItem(
      BuildContext context, {
        required IconData icon,
        required String label,
        required Color color,
      }) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildSettingsSection({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Color color,
    required List<Widget> children,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? context.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSettingsTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.grey, size: 18),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}