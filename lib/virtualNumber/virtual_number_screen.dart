import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VirtualNumberPage extends StatefulWidget {
  const VirtualNumberPage({Key? key}) : super(key: key);

  @override
  State<VirtualNumberPage> createState() => _VirtualNumberPageState();
}

class _VirtualNumberPageState extends State<VirtualNumberPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final NumberFormat _currencyFormat = NumberFormat.currency(symbol: '₦');
  final DateFormat _dateFormat = DateFormat('MMM dd, yyyy');

  // Sample data - replace with actual data from your backend
  final List<VirtualNumber> _availableNumbers = [
    VirtualNumber(
      number: '+234 802 345 6789',
      carrier: 'MTN Nigeria',
      pricePerMonth: 1500.0,
      features: ['SMS Enabled', 'Voice Calls', 'WhatsApp Compatible'],
      isPopular: true,
    ),
    VirtualNumber(
      number: '+234 803 456 7890',
      carrier: 'Glo',
      pricePerMonth: 1200.0,
      features: ['SMS Enabled', 'Voice Calls'],
      isPopular: false,
    ),
    VirtualNumber(
      number: '+234 805 678 9012',
      carrier: 'Airtel',
      pricePerMonth: 1350.0,
      features: ['SMS Enabled', 'Voice Calls', 'Call Forwarding'],
      isPopular: true,
    ),
    VirtualNumber(
      number: '+234 806 789 0123',
      carrier: '9mobile',
      pricePerMonth: 1100.0,
      features: ['SMS Enabled', 'Voice Calls'],
      isPopular: false,
    ),
    VirtualNumber(
      number: '+234 816 890 1234',
      carrier: 'MTN Nigeria',
      pricePerMonth: 1500.0,
      features: ['SMS Enabled', 'Voice Calls', 'International Calling'],
      isPopular: false,
    ),
  ];

  // User's active number (if any)
  ActiveNumber? _userActiveNumber;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Simulate user having an active number - replace with actual data
    _userActiveNumber = ActiveNumber(
      number: '+234 802 345 6789',
      carrier: 'MTN Nigeria',
      rentedOn: DateTime.now().subtract(const Duration(days: 15)),
      expiresOn: DateTime.now().add(const Duration(days: 15)),
      autoRenew: true,
      pricePaid: 1500.0,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _rentNumber(VirtualNumber number) {
    showDialog(
      context: context,
      builder: (context) => RentNumberDialog(
        number: number,
        onConfirm: (duration, autoRenew) {
          // Handle number rental logic here
          Navigator.pop(context);
          _showSuccessSnackBar('Number rented successfully!');
        },
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Theme.of(context).colorScheme.primary,
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
      backgroundColor: theme.colorScheme.surface,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              automaticallyImplyLeading: false,
              // Calculate expanded height based on whether there's an active number
              expandedHeight: _userActiveNumber != null
                  ? MediaQuery.of(context).size.height * 0.35 // Use percentage of screen height
                  : 180,
              floating: true, // Add this
              snap: true,     // Add this - makes it snap into view
              pinned: false,  // Change to false
              flexibleSpace: LayoutBuilder(
                builder: (context, constraints) {
                  return FlexibleSpaceBar(
                    background: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            theme.colorScheme.primary,
                            theme.colorScheme.secondary,
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
                              Text(
                                'Virtual Numbers',
                                style: theme.textTheme.headlineMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Get a Nigerian virtual number for calls, SMS, and more',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                              if (_userActiveNumber != null) ...[
                                const SizedBox(height: 16), // Reduced from 24
                                _buildActiveNumberCard(context),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(230), // Increased height
                child: Container(
                  margin: const EdgeInsets.only(top: 12), // Add top margin to push down
                  padding: const EdgeInsets.only(bottom: 8),
                  color: Colors.transparent,
                  child: TabBar(
                    controller: _tabController,
                    indicatorColor: Colors.white,
                    indicatorWeight: 3,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white.withOpacity(0.7),
                    tabs: const [
                      Tab(text: 'Available Numbers'),
                      Tab(text: 'My Numbers'),
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
            _buildAvailableNumbersTab(context),
            _buildMyNumbersTab(context),
          ],
        ),
      ),
    );
  }

  // Fix 1: Update _buildInfoChip to prevent horizontal overflow
  Widget _buildInfoChip(
      BuildContext context, {
        required IconData icon,
        required String label,
        required Color color,
      }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Flexible( // Changed from Expanded to Flexible
            child: Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: color,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveNumberCard(BuildContext context) {
    final theme = Theme.of(context);
    final number = _userActiveNumber!;
    final daysLeft = number.expiresOn.difference(DateTime.now()).inDays;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // First Row - Icon, Number, and Days Badge
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.phone_in_talk,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Number section
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Active Number',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 10,
                            ),
                          ),
                          Text(
                            number.number,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 6),

                    // Days left badge - with better contrast
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: daysLeft < 7
                            ? Colors.orange.withOpacity(0.9) // Much more opaque for orange
                            : Colors.white.withOpacity(0.9), // White background for better contrast
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: daysLeft < 7 ? Colors.orange : Colors.green,
                          width: 1.5, // Thicker border for visibility
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            daysLeft < 7 ? Icons.warning_amber : Icons.check_circle,
                            size: 10,
                            color: daysLeft < 7 ? Colors.white : Colors.green.shade700, // Better contrast
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '$daysLeft d',
                            style: TextStyle(
                              color: daysLeft < 7 ? Colors.white : Colors.green.shade700,
                              fontWeight: FontWeight.bold,
                              fontSize: 9,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Second Row - Rented and Auto-renew info side by side
                Row(
                  children: [
                    // Rented info
                    Expanded(
                      child: _buildCompactInfoChip(
                        context,
                        icon: Icons.calendar_today,
                        label: 'Rented: ${_dateFormat.format(number.rentedOn)}',
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 6),

                    // Auto-renew info
                    Expanded(
                      child: _buildCompactInfoChip(
                        context,
                        icon: Icons.update,
                        label: 'Auto: ${number.autoRenew ? 'On' : 'Off'}',
                        color: number.autoRenew ? Colors.white : Colors.grey, // Changed from green to white
                        backgroundColor: number.autoRenew
                            ? Colors.green.shade700 // Darker green background for contrast
                            : Colors.grey.shade700, // Darker grey background
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// Updated compact info chip with better contrast
  Widget _buildCompactInfoChip(
      BuildContext context, {
        required IconData icon,
        required String label,
        required Color color, // This is for icon/text color
        Color? backgroundColor, // New parameter for background color
      }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor ?? color.withOpacity(0.2), // Use backgroundColor if provided
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.5),
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 10, color: color),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 9,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
// Fix 3: Update _buildStatItem to prevent overflow in usage stats
  Widget _buildStatItem({
    required BuildContext context,
    required String value,
    required String label,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4), // Add padding
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 18), // Reduced from 20
          ),
          const SizedBox(height: 4), // Reduced from 8
          FittedBox( // Add FittedBox to prevent overflow
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: Theme.of(context).textTheme.titleSmall?.copyWith( // Smaller font
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontSize: 10, // Smaller font
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

// Fix 4: Update the Row in _buildNumberCard for better space management
  Widget _buildNumberCard(BuildContext context, VirtualNumber number) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: number.isPopular
            ? BorderSide(
          color: theme.colorScheme.primary,
          width: 2,
        )
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: () => _rentNumber(number),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(12), // Reduced from 16
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Carrier badge
              Row(
                children: [
                  Flexible( // Changed to Flexible
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        number.carrier,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const Spacer(),
                  if (number.isPopular)
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.star,
                        color: Colors.orange,
                        size: 14, // Reduced from 16
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8), // Reduced from 12

              // Phone number
              Text(
                number.number,
                style: theme.textTheme.titleSmall?.copyWith( // Smaller
                  fontWeight: FontWeight.bold,
                  fontSize: 14, // Explicit size
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6), // Reduced from 8

              // Features
              ...number.features.take(2).map((feature) => Padding(
                padding: const EdgeInsets.only(bottom: 2), // Reduced from 4
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 12, // Reduced from 14
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 2), // Reduced from 4
                    Expanded(
                      child: Text(
                        feature,
                        style: theme.textTheme.labelSmall?.copyWith(
                          fontSize: 10,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              )),

              const Spacer(),

              // Price and rent button
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Price',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            fontSize: 9,
                          ),
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            _currencyFormat.format(number.pricePerMonth),
                            style: theme.textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Text(
                          '/month',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            fontSize: 8,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () => _rentNumber(number),
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 16, // Reduced from 20
                      ),
                      iconSize: 16,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 30, // Reduced from 36
                        minHeight: 30, // Reduced from 36
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

// Fix 5: Update _buildMyNumbersTab to use ListView with proper constraints
  Widget _buildMyNumbersTab(BuildContext context) {
    final theme = Theme.of(context);

    if (_userActiveNumber == null) {
      return Center(
        child: SingleChildScrollView( // Add scroll for small screens
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20), // Reduced from 24
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.phone_forwarded,
                    size: 48, // Reduced from 64
                    color: theme.colorScheme.primary.withOpacity(0.5),
                  ),
                ),
                const SizedBox(height: 12), // Reduced from 16
                Text(
                  'No Active Number',
                  style: theme.textTheme.titleMedium?.copyWith( // Smaller
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4), // Reduced from 8
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'You haven\'t rented any virtual numbers yet',
                    style: theme.textTheme.bodySmall?.copyWith( // Smaller
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16), // Reduced from 24
                FilledButton(
                  onPressed: () {
                    _tabController.animateTo(0);
                  },
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                  child: const Text('Browse Numbers'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(12), // Reduced from 16
      children: [
        _buildMyNumberDetailCard(context),
        const SizedBox(height: 12), // Reduced from 16
        _buildUsageStatsCard(context),
        const SizedBox(height: 12), // Reduced from 16
        _buildSettingsCard(context),
        const SizedBox(height: 12), // Reduced from 16
        _buildHistoryCard(context),
      ],
    );
  }

  Widget _buildSettingsCard(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16), // Reduced from 20
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // Add this
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.settings_outlined,
                    color: theme.colorScheme.primary,
                    size: 18, // Reduced from 20
                  ),
                ),
                const SizedBox(width: 8), // Reduced from 12
                Expanded( // Add Expanded
                  child: Text(
                    'Number Settings',
                    style: theme.textTheme.titleSmall?.copyWith( // Smaller
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12), // Reduced from 16

            // Auto-renew SwitchListTile
            Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: SwitchListTile(
                value: _userActiveNumber?.autoRenew ?? false,
                onChanged: (value) {
                  setState(() {
                    _userActiveNumber?.autoRenew = value;
                  });
                },
                title: const Text(
                  'Auto-renew',
                  style: TextStyle(fontSize: 14), // Add explicit size
                ),
                subtitle: const Text(
                  'Automatically renew when expired',
                  style: TextStyle(fontSize: 12), // Add explicit size
                ),
                secondary: Container(
                  padding: const EdgeInsets.all(6), // Reduced from 8
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.autorenew,
                    color: Colors.green,
                    size: 14, // Reduced from 16
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12), // Add padding
                dense: true, // Add dense for compact mode
              ),
            ),

            const SizedBox(height: 8), // Add spacing

            // Call Forwarding
            _buildSettingsTile(
              context,
              icon: Icons.call,
              iconColor: Colors.blue,
              title: 'Call Forwarding',
              subtitle: 'Forward calls to another number',
              onTap: () {},
            ),

            // Voicemail
            _buildSettingsTile(
              context,
              icon: Icons.voicemail,
              iconColor: Colors.purple,
              title: 'Voicemail',
              subtitle: 'Set up voicemail greeting',
              onTap: () {},
            ),

            // Block List
            _buildSettingsTile(
              context,
              icon: Icons.block,
              iconColor: Colors.red,
              title: 'Block List',
              subtitle: 'Manage blocked numbers',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

// Add this helper method for settings tiles
  Widget _buildSettingsTile(
      BuildContext context, {
        required IconData icon,
        required Color iconColor,
        required String title,
        required String subtitle,
        required VoidCallback onTap,
      }) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 4), // Add margin
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2), // Reduced padding
        minLeadingWidth: 30, // Add minimum leading width
        leading: Container(
          padding: const EdgeInsets.all(6), // Reduced from 8
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor, size: 16), // Reduced from 20
        ),
        title: Text(
          title,
          style: theme.textTheme.bodyMedium?.copyWith( // Smaller
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          subtitle,
          style: theme.textTheme.bodySmall?.copyWith(
            fontSize: 12,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Icon(
          Icons.chevron_right,
          size: 18, // Reduced from 20
        ),
        dense: true, // Make it more compact
      ),
    );
  }

  Widget _buildAvailableNumbersTab(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: CustomScrollView(
        slivers: [
          const SliverPadding(padding: EdgeInsets.only(top: 16)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              delegate: SliverChildBuilderDelegate(
                    (context, index) => _buildNumberCard(
                  context,
                  _availableNumbers[index],
                ),
                childCount: _availableNumbers.length,
              ),
            ),
          ),
        ],
      ),
    );
  }




  Widget _buildMyNumberDetailCard(BuildContext context) {
    final theme = Theme.of(context);
    final number = _userActiveNumber!;
    final daysLeft = number.expiresOn.difference(DateTime.now()).inDays;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.colorScheme.primary,
              theme.colorScheme.secondary,
            ],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.phone_android,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Active Number',
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                      Text(
                        number.number,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildDetailItem(
                    context,
                    icon: Icons.calendar_today,
                    label: 'Rented On',
                    value: _dateFormat.format(number.rentedOn),
                    light: true,
                  ),
                ),
                Expanded(
                  child: _buildDetailItem(
                    context,
                    icon: Icons.event,
                    label: 'Expires On',
                    value: _dateFormat.format(number.expiresOn),
                    light: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildDetailItem(
                    context,
                    icon: Icons.timer,
                    label: 'Days Left',
                    value: '$daysLeft days',
                    light: true,
                  ),
                ),
                Expanded(
                  child: _buildDetailItem(
                    context,
                    icon: Icons.attach_money,
                    label: 'Price Paid',
                    value: _currencyFormat.format(number.pricePaid),
                    light: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // Handle renew
                    },
                    icon: const Icon(Icons.refresh, color: Colors.white),
                    label: const Text(
                      'Renew',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {
                      // Handle settings
                    },
                    icon: const Icon(Icons.settings),
                    label: const Text('Settings'),
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: theme.colorScheme.primary,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(
      BuildContext context, {
        required IconData icon,
        required String label,
        required String value,
        bool light = false,
      }) {
    final theme = Theme.of(context);
    final textColor = light ? Colors.white : theme.colorScheme.onSurface;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: light
            ? Colors.white.withOpacity(0.1)
            : theme.colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: light ? Colors.white : theme.colorScheme.primary,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: light
                        ? Colors.white.withOpacity(0.7)
                        : theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  value,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUsageStatsCard(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.analytics,
                    color: theme.colorScheme.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Usage Statistics',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
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
                    value: '147',
                    label: 'Calls',
                    icon: Icons.call,
                    color: Colors.green,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    value: '892',
                    label: 'SMS',
                    icon: Icons.sms,
                    color: Colors.blue,
                    context: context,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    context: context,
                    value: '3.2GB',
                    label: 'Data',
                    icon: Icons.data_usage,
                    color: Colors.purple,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: 0.45,
              backgroundColor: theme.colorScheme.surfaceVariant,
              valueColor: AlwaysStoppedAnimation(theme.colorScheme.primary),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Monthly Usage',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  '45% of 5000 mins',
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildHistoryCard(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.history,
                    color: theme.colorScheme.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Recent Activity',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildHistoryItem(
              context,
              type: 'Call',
              description: 'Incoming call from +234 812 345 6789',
              time: '2 min ago',
              icon: Icons.call_received,
              color: Colors.green,
            ),
            _buildHistoryItem(
              context,
              type: 'SMS',
              description: 'Message from +234 803 456 7890',
              time: '1 hour ago',
              icon: Icons.sms,
              color: Colors.blue,
            ),
            _buildHistoryItem(
              context,
              type: 'Renewal',
              description: 'Auto-renewal successful',
              time: '2 days ago',
              icon: Icons.autorenew,
              color: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryItem(
      BuildContext context, {
        required String type,
        required String description,
        required String time,
        required IconData icon,
        required Color color,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  type,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Text(
            time,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class VirtualNumber {
  final String number;
  final String carrier;
  final double pricePerMonth;
  final List<String> features;
  final bool isPopular;

  VirtualNumber({
    required this.number,
    required this.carrier,
    required this.pricePerMonth,
    required this.features,
    required this.isPopular,
  });
}

class ActiveNumber {
  final String number;
  final String carrier;
  final DateTime rentedOn;
  final DateTime expiresOn;
  bool autoRenew;
  final double pricePaid;

  ActiveNumber({
    required this.number,
    required this.carrier,
    required this.rentedOn,
    required this.expiresOn,
    required this.autoRenew,
    required this.pricePaid,
  });
}

class RentNumberDialog extends StatefulWidget {
  final VirtualNumber number;
  final Function(int duration, bool autoRenew) onConfirm;

  const RentNumberDialog({
    Key? key,
    required this.number,
    required this.onConfirm,
  }) : super(key: key);

  @override
  State<RentNumberDialog> createState() => _RentNumberDialogState();
}

class _RentNumberDialogState extends State<RentNumberDialog>
    with TickerProviderStateMixin {
  int _selectedDuration = 1; // months
  bool _autoRenew = true;
  late AnimationController _controller;
  late Animation<double> _animation;

  final List<int> _durations = [1, 3, 6, 12];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double get _totalPrice => widget.number.pricePerMonth * _selectedDuration;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final numberFormat = NumberFormat.currency(symbol: '₦');

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),
      elevation: 8,
      child: FadeTransition(
        opacity: _animation,
        child: ScaleTransition(
          scale: _animation,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        theme.colorScheme.primary,
                        theme.colorScheme.secondary,
                      ],
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(28),
                      topRight: Radius.circular(28),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.phone_in_talk,
                          size: 32,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Rent Virtual Number',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.number.number,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),

                // Content
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Carrier and price
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildInfoTag(
                            context,
                            label: widget.number.carrier,
                            icon: Icons.business,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              numberFormat.format(widget.number.pricePerMonth),
                              style: theme.textTheme.titleSmall?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Duration selection
                      Text(
                        'Select Duration',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: _durations.map((duration) {
                          final isSelected = _selectedDuration == duration;
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: FilledButton(
                                onPressed: () {
                                  setState(() {
                                    _selectedDuration = duration;
                                  });
                                },
                                style: FilledButton.styleFrom(
                                  backgroundColor: isSelected
                                      ? theme.colorScheme.primary
                                      : theme.colorScheme.surfaceVariant,
                                  foregroundColor: isSelected
                                      ? Colors.white
                                      : theme.colorScheme.onSurfaceVariant,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                ),
                                child: Text('$duration mo'),
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 24),

                      // Price breakdown
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: theme.colorScheme.outline.withOpacity(0.2),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Monthly price:',
                                  style: theme.textTheme.bodyMedium,
                                ),
                                Text(
                                  numberFormat.format(widget.number.pricePerMonth),
                                  style: theme.textTheme.bodyMedium,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Duration:',
                                  style: theme.textTheme.bodyMedium,
                                ),
                                Text(
                                  '$_selectedDuration month${_selectedDuration > 1 ? 's' : ''}',
                                  style: theme.textTheme.bodyMedium,
                                ),
                              ],
                            ),
                            const Divider(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total:',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  numberFormat.format(_totalPrice),
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Auto-renew checkbox
                      CheckboxListTile(
                        value: _autoRenew,
                        onChanged: (value) {
                          setState(() {
                            _autoRenew = value ?? false;
                          });
                        },
                        title: const Text('Auto-renew when expired'),
                        subtitle: const Text('We\'ll notify you before renewal'),
                        secondary: Icon(
                          Icons.autorenew,
                          color: theme.colorScheme.primary,
                        ),
                        contentPadding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),

                      // Features
                      const SizedBox(height: 16),
                      const Text('Included Features:'),
                      const SizedBox(height: 8),
                      ...widget.number.features.map((feature) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              size: 18,
                              color: theme.colorScheme.primary,
                            ),
                            const SizedBox(width: 8),
                            Text(feature),
                          ],
                        ),
                      )),

                      const SizedBox(height: 24),

                      // Action buttons
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => Navigator.pop(context),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                              child: const Text('Cancel'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: FilledButton(
                              onPressed: () {
                                widget.onConfirm(_selectedDuration, _autoRenew);
                              },
                              style: FilledButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                              child: const Text('Confirm Rent'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTag(BuildContext context,
      {required String label, required IconData icon}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14),
          const SizedBox(width: 4),
          Text(label),
        ],
      ),
    );
  }
}