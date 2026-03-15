import 'package:flutter/material.dart';
import 'package:pavi/theme/generalTheme.dart';



class RedemptionScreen extends StatefulWidget {
  const RedemptionScreen({super.key});

  @override
  State<RedemptionScreen> createState() => _RedemptionScreenState();
}

class _RedemptionScreenState extends State<RedemptionScreen> with TickerProviderStateMixin {
  int _coinBalance = 12450;
  int _selectedCategoryIndex = 0;
  String _selectedPhoneNumber = '+234 801 234 5678';

  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  final List<Map<String, dynamic>> _categories = [
    {'icon': Icons.data_usage, 'label': 'Data', 'color': Colors.blue},
    {'icon': Icons.phone, 'label': 'Airtime', 'color': Colors.green},
    {'icon': Icons.bolt, 'label': 'Bills', 'color': Colors.orange},
    {'icon': Icons.account_balance, 'label': 'Bank', 'color': Colors.purple},
  ];

  final List<Map<String, dynamic>> _dataBundles = [
    {
      'id': '1',
      'name': '100MB',
      'data': '100 MB',
      'price': 500,
      'value': '₦50 value',
      'popular': false,
      'bestValue': false,
    },
    {
      'id': '2',
      'name': '500MB',
      'data': '500 MB',
      'price': 2000,
      'value': '₦200 value',
      'popular': false,
      'bestValue': false,
    },
    {
      'id': '3',
      'name': '1GB',
      'data': '1 GB',
      'price': 3500,
      'value': '₦350 value',
      'popular': true,
      'bestValue': true,
    },
    {
      'id': '4',
      'name': '2GB',
      'data': '2 GB',
      'price': 6000,
      'value': '₦600 value',
      'popular': false,
      'bestValue': false,
    },
    {
      'id': '5',
      'name': '5GB',
      'data': '5 GB',
      'price': 14000,
      'value': '₦1,400 value',
      'popular': false,
      'bestValue': false,
    },
  ];

  final List<Map<String, dynamic>> _airtimeOptions = [
    {'amount': 100, 'coins': 500, 'label': '₦100'},
    {'amount': 200, 'coins': 1000, 'label': '₦200'},
    {'amount': 500, 'coins': 2500, 'label': '₦500'},
    {'amount': 1000, 'coins': 5000, 'label': '₦1,000'},
    {'amount': 'custom', 'coins': null, 'label': 'Custom'},
  ];

  final List<Map<String, dynamic>> _billOptions = [
    {
      'provider': 'AEDC',
      'icon': Icons.electrical_services,
      'type': 'Electricity',
      'color': Colors.yellow.shade700,
    },
    {
      'provider': 'DSTV',
      'icon': Icons.tv,
      'type': 'Cable TV',
      'color': Colors.green,
    },
    {
      'provider': 'GOtv',
      'icon': Icons.tv,
      'type': 'Cable TV',
      'color': Colors.orange,
    },
    {
      'provider': 'Showmax',
      'icon': Icons.movie,
      'type': 'Streaming',
      'color': Colors.purple,
    },
  ];

  final List<Map<String, dynamic>> _recentRedemptions = [
    {
      'item': '1GB Data',
      'date': 'Today',
      'coins': 3500,
      'status': 'success',
    },
    {
      'item': '₦500 Airtime',
      'date': 'Yesterday',
      'coins': 2500,
      'status': 'success',
    },
    {
      'item': 'AEDC Bill',
      'date': '3 days ago',
      'coins': 8000,
      'status': 'success',
    },
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: context.surfaceColor,
        elevation: 0,
        title: Text(
          'Redeem Coins',
          style: context.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: context.textPrimary,
          ),
        ),
        actions: [
          // Transaction History
          IconButton(
            icon: Icon(Icons.history, color: context.textPrimary),
            onPressed: () {
              _showTransactionHistory(context);
            },
          ),
          // Help
          IconButton(
            icon: Icon(Icons.help_outline, color: context.textPrimary),
            onPressed: () {
              _showHelpDialog(context);
            },
          ),
        ],
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Coin Balance Header
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.all(context.spacingLG),
              padding: EdgeInsets.all(context.spacingLG),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.amber.shade400,
                    Colors.amber.shade700,
                  ],
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.amber.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Your Balance',
                        style: context.bodyLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '≈ ₦${(_coinBalance / 10).floor()}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      AnimatedBuilder(
                        animation: _pulseAnimation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _pulseAnimation.value,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.monetization_on,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 12),
                      Text(
                        _formatNumber(_coinBalance),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'coins',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Colors.white70,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'You\'ve saved ₦${(_coinBalance / 10).floor()} this month!',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Category Tabs
          SliverToBoxAdapter(
            child: Container(
              height: 50,
              margin: EdgeInsets.only(bottom: context.spacingMD),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: context.spacingLG),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  final isSelected = _selectedCategoryIndex == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategoryIndex = index;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: context.spacingSM),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        gradient: isSelected
                            ? LinearGradient(
                          colors: [
                            category['color'].withOpacity(0.8),
                            category['color'],
                          ],
                        )
                            : null,
                        color: isSelected
                            ? null
                            : (isDark
                            ? context.darkSurface
                            : Colors.grey.shade100),
                        borderRadius: BorderRadius.circular(25),
                        border: isSelected
                            ? null
                            : Border.all(
                          color: isDark
                              ? Colors.grey.shade800
                              : Colors.grey.shade300,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            category['icon'],
                            color: isSelected
                                ? Colors.white
                                : category['color'],
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            category['label'],
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : context.textPrimary,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Content based on selected category
          SliverPadding(
            padding: EdgeInsets.all(context.spacingLG),
            sliver: _buildCategoryContent(),
          ),

          // Recent Redemptions Section
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(context.spacingLG),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Redemptions',
                    style: context.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _showTransactionHistory(context);
                    },
                    child: Text(
                      'View All',
                      style: TextStyle(
                        color: context.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Recent Redemptions List
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                final item = _recentRedemptions[index];
                return Container(
                  margin: EdgeInsets.only(
                    left: context.spacingLG,
                    right: context.spacingLG,
                    bottom: context.spacingSM,
                  ),
                  padding: EdgeInsets.all(context.spacingMD),
                  decoration: BoxDecoration(
                    color: isDark ? context.darkCard : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['item'],
                              style: context.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              item['date'],
                              style: context.bodySmall?.copyWith(
                                color: context.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.monetization_on,
                              color: Colors.amber,
                              size: 12,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              '-${item['coins']}',
                              style: const TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              childCount: _recentRedemptions.length,
            ),
          ),

          // Bottom Padding
          const SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryContent() {
    switch (_selectedCategoryIndex) {
      case 0: // Data
        return SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
            childAspectRatio: 1.2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              final bundle = _dataBundles[index];
              return _buildDataBundleCard(context, bundle);
            },
            childCount: _dataBundles.length,
          ),
        );

      case 1: // Airtime
        return SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.0,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              final option = _airtimeOptions[index];
              return _buildAirtimeOption(context, option);
            },
            childCount: _airtimeOptions.length,
          ),
        );

      case 2: // Bills
        return SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              final bill = _billOptions[index];
              return _buildBillTile(context, bill);
            },
            childCount: _billOptions.length,
          ),
        );

      case 3: // Bank (coming soon)
        return SliverToBoxAdapter(
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.account_balance,
                  size: 48,
                  color: Colors.grey,
                ),
                const SizedBox(height: 16),
                Text(
                  'Bank Transfers Coming Soon',
                  style: context.bodyLarge?.copyWith(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Withdraw your coins to your bank account',
                  style: context.bodySmall?.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        );

      default:
        return const SliverToBoxAdapter(child: SizedBox());
    }
  }
  Widget _buildDataBundleCard(BuildContext context, Map<String, dynamic> bundle) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final canAfford = _coinBalance >= bundle['price'];

    return GestureDetector(
      onTap: canAfford ? () => _showCheckoutDialog(context, bundle) : null,
      child: Container(
        height: 150, // Fixed height
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: bundle['bestValue'] == true
                ? [Colors.amber.shade400, Colors.orange.shade600]
                : (isDark
                ? [context.darkCard, context.darkSurface]
                : [Colors.white, Colors.grey.shade50]),
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: bundle['bestValue'] == true
                ? Colors.amber.shade300
                : (isDark ? Colors.grey.shade800 : Colors.grey.shade200),
            width: bundle['bestValue'] == true ? 2 : 1,
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                // Badges
                if (bundle['popular'] == true)
                  Positioned(top: 4, right: 4, child: _buildBadge('POPULAR', Colors.green)),
                if (bundle['bestValue'] == true)
                  Positioned(top: 4, left: 4, child: _buildBadge('BEST VALUE', Colors.amber)),

                // Content
                Padding(
                  padding: const EdgeInsets.all(10), // Reduced from 12
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min, // Add this
                    children: [
                      // Icon - fixed height
                      Container(
                        height: 26, // Reduced from 30
                        padding: const EdgeInsets.all(4), // Reduced from 6
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6), // Reduced from 8
                        ),
                        child: const Icon(Icons.data_usage, color: Colors.blue, size: 14), // Reduced from 16
                      ),

                      const SizedBox(height: 2), // Reduced from 4

                      // Title - fixed height
                      SizedBox(
                        height: 16, // Reduced from 18
                        child: Text(
                          bundle['name'],
                          style: context.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 12, // Reduced from 13
                            color: bundle['bestValue'] == true ? Colors.white : context.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      // Value - fixed height
                      SizedBox(
                        height: 14, // Reduced from 16
                        child: Text(
                          bundle['value'],
                          style: context.bodySmall?.copyWith(
                            fontSize: 9, // Reduced from 10
                            color: bundle['bestValue'] == true ? Colors.white70 : context.textSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      const Spacer(),

                      // Price row - fixed height
                      SizedBox(
                        height: 22, // Reduced from 24
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildPriceChip(bundle['price'], canAfford),
                            if (canAfford) _buildArrowButton(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Overlay
                if (!canAfford) _buildOverlay(bundle['price'] - _coinBalance),
              ],
            );
          },
        ),
      ),
    );
  }

// Helper widgets with smaller sizes
  Widget _buildPriceChip(int price, bool canAfford) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      decoration: BoxDecoration(
        color: canAfford ? Colors.amber.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4), // Reduced from 6
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.monetization_on,
            color: canAfford ? Colors.amber : Colors.grey,
            size: 8, // Keep at 8
          ),
          const SizedBox(width: 1),
          Text(
            '$price',
            style: TextStyle(
              color: canAfford ? Colors.amber : Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 8, // Reduced from 9
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArrowButton() {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
          shape: BoxShape.circle
      ),
      child: const Icon(
        Icons.arrow_forward,
        color: Colors.blue,
        size: 10, // Keep at 10
      ),
    );
  }

  Widget _buildOverlay(int neededCoins) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(6) // Reduced from 8
            ),
            child: Text(
              'Need $neededCoins more',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 8, // Keep at 8
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 4, // Reduced from 6
        vertical: 1, // Reduced from 2
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4), // Reduced from 8
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 6, // Reduced from 7
          fontWeight: FontWeight.bold,
          letterSpacing: 0.2,
        ),
      ),
    );
  }




  Widget _buildAirtimeOption(BuildContext context, Map<String, dynamic> option) {
    final canAfford = option['coins'] == null ? true : _coinBalance >= option['coins'];

    return GestureDetector(
      onTap: option['label'] == 'Custom'
          ? () => _showCustomAirtimeDialog(context)
          : (canAfford ? () => _showAirtimeCheckout(context, option) : null),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? context.darkCard
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: option['label'] == 'Custom'
                ? Colors.grey
                : (canAfford ? Colors.green : Colors.grey.shade300),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (option['label'] == 'Custom')
              const Icon(Icons.edit, color: Colors.grey)
            else
              Text(
                option['label'],
                style: context.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            if (option['coins'] != null) ...[
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.monetization_on,
                    color: canAfford ? Colors.amber : Colors.grey,
                    size: 12,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    '${option['coins']}',
                    style: TextStyle(
                      color: canAfford ? Colors.amber : Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildBillTile(BuildContext context, Map<String, dynamic> bill) {
    return Container(
      margin: EdgeInsets.only(bottom: context.spacingSM),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? context.darkCard
            : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey.shade800
              : Colors.grey.shade200,
        ),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: bill['color'].withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(bill['icon'], color: bill['color']),
        ),
        title: Text(bill['provider']),
        subtitle: Text(bill['type']),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => _showBillPaymentDialog(context, bill),
      ),
    );
  }

  void _showCheckoutDialog(BuildContext context, Map<String, dynamic> item) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            // Handle
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Confirm Redemption',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Item summary
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF2A2A2A) : Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.data_usage, color: Colors.blue),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['name'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  item['data'],
                                  style: TextStyle(
                                    color: Colors.grey,
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
                              color: Colors.amber.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.monetization_on,
                                  color: Colors.amber,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${item['price']}',
                                  style: const TextStyle(
                                    color: Colors.amber,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Phone number
                    const Text(
                      'Phone Number',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF2A2A2A) : Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.phone, size: 18, color: Colors.grey),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              _selectedPhoneNumber,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              _showEditPhoneDialog(context);
                            },
                            child: const Text('Edit'),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Warning
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline, color: Colors.orange),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'This action cannot be undone. Please verify the details before confirming.',
                              style: TextStyle(
                                color: Colors.orange.shade800,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),

                    // Slide to confirm
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.amber.shade400,
                            Colors.amber.shade600,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text(
                          '⬅️  SLIDE TO CONFIRM  ➡️',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Cancel
                    Center(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context, String item) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.green.shade400, Colors.green.shade600],
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Success animation placeholder
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: Colors.white,
                  size: 48,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Transaction Successful! 🎉',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Your $item is on its way',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Transaction ID:',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'PKC-${DateTime.now().millisecondsSinceEpoch}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context); // Close checkout too
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text('Done'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  // Share to chat
                },
                child: const Text(
                  'Share to Chat',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditPhoneDialog(BuildContext context) {
    final phoneController = TextEditingController(text: _selectedPhoneNumber);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Phone Number'),
        content: TextField(
          controller: phoneController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            hintText: 'Enter phone number',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _selectedPhoneNumber = phoneController.text;
              });
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showCustomAirtimeDialog(BuildContext context) {
    final coinController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Custom Airtime'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: coinController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter amount in coins',
                prefixIcon: const Icon(Icons.monetization_on, color: Colors.amber),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '≈ ₦${int.tryParse(coinController.text) ?? 0 ~/ 10}',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Show checkout with custom amount
            },
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }

  void _showBillPaymentDialog(BuildContext context, Map<String, dynamic> bill) {
    final meterController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Pay ${bill['provider']}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: meterController,
              decoration: InputDecoration(
                hintText: 'Enter meter number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: '5000',
              decoration: InputDecoration(
                hintText: 'Select amount',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              items: ['2000', '5000', '10000', '20000'].map((amount) {
                return DropdownMenuItem(
                  value: amount,
                  child: Text('₦$amount (${int.parse(amount) * 10} coins)'),
                );
              }).toList(),
              onChanged: (value) {},
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Show success
              _showSuccessDialog(context, '${bill['provider']} Bill');
            },
            child: const Text('Pay'),
          ),
        ],
      ),
    );
  }

  void _showTransactionHistory(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Transaction History',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: 20,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF2A2A2A) : Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.check_circle, color: Colors.green),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '1GB Data Bundle',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Mar ${15 - index}, 2024',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.amber.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: const [
                              Icon(Icons.monetization_on, color: Colors.amber, size: 12),
                              SizedBox(width: 2),
                              Text(
                                '-3500',
                                style: TextStyle(
                                  color: Colors.amber,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('How Redemption Works'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('• 10 coins = ₦1 value'),
            Text('• Minimum redemption: 500 coins'),
            Text('• Data delivered within 5 minutes'),
            Text('• Airtime credited instantly'),
            Text('• Bills take 24 hours to process'),
            SizedBox(height: 16),
            Text(
              'Need help? Contact support@poket.com',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }

  void _showAirtimeCheckout(BuildContext context, Map<String, dynamic> option) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 500,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Confirm Airtime',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF2A2A2A) : Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.phone, color: Colors.green),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  option['label'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  'Airtime',
                                  style: TextStyle(
                                    color: Colors.grey,
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
                              color: Colors.amber.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.monetization_on,
                                  color: Colors.amber,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${option['coins']}',
                                  style: const TextStyle(
                                    color: Colors.amber,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Phone Number',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF2A2A2A) : Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.phone, size: 18, color: Colors.grey),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(_selectedPhoneNumber),
                          ),
                          TextButton(
                            onPressed: () => _showEditPhoneDialog(context),
                            child: const Text('Edit'),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _coinBalance -= option['coins'] as int;
                        });
                        Navigator.pop(context);
                        _showSuccessDialog(context, 'Airtime');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text('Confirm Redemption'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }
}