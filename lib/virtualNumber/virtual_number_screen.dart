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
              expandedHeight: _userActiveNumber != null ? 280 : 200,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
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
                        children: [
                          const SizedBox(height: 10),
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
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                          if (_userActiveNumber != null) ...[
                            const SizedBox(height: 24),
                            _buildActiveNumberCard(context),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              bottom: TabBar(
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

  Widget _buildActiveNumberCard(BuildContext context) {
    final theme = Theme.of(context);
    final number = _userActiveNumber!;
    final daysLeft = number.expiresOn.difference(DateTime.now()).inDays;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),

      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.phone_in_talk,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your Active Number',
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                          Text(
                            number.number,
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: daysLeft < 7
                            ? Colors.orange.withOpacity(0.2)
                            : Colors.green.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: daysLeft < 7 ? Colors.orange : Colors.green,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            daysLeft < 7 ? Icons.warning_amber : Icons.check_circle,
                            size: 14,
                            color: daysLeft < 7 ? Colors.orange : Colors.green,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '$daysLeft days left',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: daysLeft < 7 ? Colors.orange : Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoChip(
                        context,
                        icon: Icons.calendar_today,
                        label: 'Rented: ${_dateFormat.format(number.rentedOn)}',
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildInfoChip(
                        context,
                        icon: Icons.update,
                        label: 'Auto-renew: ${number.autoRenew ? 'On' : 'Off'}',
                        color: number.autoRenew ? Colors.green : Colors.grey,
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
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: color,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
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
                childAspectRatio: 0.85,
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

  Widget _buildMyNumbersTab(BuildContext context) {
    final theme = Theme.of(context);

    if (_userActiveNumber == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.phone_forwarded,
                size: 64,
                color: theme.colorScheme.primary.withOpacity(0.5),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'No Active Number',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'You haven\'t rented any virtual numbers yet',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () {
                _tabController.animateTo(0);
              },
              icon: const Icon(Icons.add),
              label: const Text('Browse Numbers'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildMyNumberDetailCard(context),
        const SizedBox(height: 16),
        _buildUsageStatsCard(context),
        const SizedBox(height: 16),
        _buildSettingsCard(context),
        const SizedBox(height: 16),
        _buildHistoryCard(context),
      ],
    );
  }

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
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Carrier badge
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
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
                      ),
                    ),
                  ),
                  const Spacer(),
                  if (number.isPopular)
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.star,
                        color: Colors.orange,
                        size: 16,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              // Phone number
              Text(
                number.number,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              // Features
              ...number.features.take(2).map((feature) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 14,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        feature,
                        style: theme.textTheme.labelSmall,
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
                      children: [
                        Text(
                          'Price',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        Text(
                          _currencyFormat.format(number.pricePerMonth),
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        Text(
                          '/month',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
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
                      ),
                      iconSize: 20,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 36,
                        minHeight: 36,
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

  Widget _buildStatItem({
    required BuildContext context,
    required String value,
    required String label,
    required IconData icon,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
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
                    Icons.settings_outlined,
                    color: theme.colorScheme.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Number Settings',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              value: _userActiveNumber?.autoRenew ?? false,
              onChanged: (value) {
                setState(() {
                  _userActiveNumber?.autoRenew = value;
                });
              },
              title: const Text('Auto-renew'),
              subtitle: const Text('Automatically renew when expired'),
              secondary: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.autorenew,
                  color: Colors.green,
                  size: 16,
                ),
              ),
            ),
            const Divider(),
            ListTile(
              onTap: () {
                // Handle call forwarding
              },
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child:  Icon(Icons.call, color: Colors.blue),
              ),
              title: const Text('Call Forwarding'),
              subtitle: const Text('Forward calls to another number'),
              trailing: const Icon(Icons.chevron_right),
            ),
            ListTile(
              onTap: () {
                // Handle voicemail
              },
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.voicemail, color: Colors.purple),
              ),
              title: const Text('Voicemail'),
              subtitle: const Text('Set up voicemail greeting'),
              trailing: const Icon(Icons.chevron_right),
            ),
            ListTile(
              onTap: () {
                // Handle block list
              },
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.block, color: Colors.red),
              ),
              title: const Text('Block List'),
              subtitle: const Text('Manage blocked numbers'),
              trailing: const Icon(Icons.chevron_right),
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