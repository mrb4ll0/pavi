import 'package:flutter/material.dart';
import 'package:pavi/home/wallet/screen/recharge_screen.dart';
import 'package:pavi/theme/generalTheme.dart';
import '../models/wallet_model.dart';
import '../widget/balanceWidget.dart';
import '../widget/transaction_tile.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  late WalletBalance _balance;
  late List<Transaction> _transactions;

  @override
  void initState() {
    super.initState();
    _loadWalletData();
  }

  void _loadWalletData() {
    _balance = WalletBalance.initial();

    _transactions = [
      Transaction(
        id: '1',
        title: 'Wallet Recharge',
        description: 'Paystack payment',
        amount: 5000.00,
        date: DateTime.now().subtract(const Duration(hours: 2)),
        type: TransactionType.recharge,
        status: TransactionStatus.completed,
        reference: 'PAY-123456',
      ),
      Transaction(
        id: '2',
        title: 'Call Deduction',
        description: 'Call to +234 802 345 6789 (15 mins)',
        amount: 375.00,
        date: DateTime.now().subtract(const Duration(days: 1)),
        type: TransactionType.callDeduction,
        status: TransactionStatus.completed,
      ),
      Transaction(
        id: '3',
        title: 'Data Purchase',
        description: '2GB Data Plan',
        amount: 1500.00,
        date: DateTime.now().subtract(const Duration(days: 2)),
        type: TransactionType.dataPurchase,
        status: TransactionStatus.completed,
      ),
      Transaction(
        id: '4',
        title: 'Wallet Recharge',
        description: 'Bank transfer',
        amount: 2000.00,
        date: DateTime.now().subtract(const Duration(days: 3)),
        type: TransactionType.recharge,
        status: TransactionStatus.pending,
        reference: 'TRF-789012',
      ),
      Transaction(
        id: '5',
        title: 'Call Deduction',
        description: 'Call to +234 803 456 7890 (5 mins)',
        amount: 125.00,
        date: DateTime.now().subtract(const Duration(days: 4)),
        type: TransactionType.callDeduction,
        status: TransactionStatus.completed,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: context.surfaceColor,
        elevation: 0,
        title: Text(
          'Wallet',
          style: context.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: context.textPrimary,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.history, color: context.textPrimary),
            onPressed: () {
              // Show full transaction history
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: context.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // Balance Card
            Padding(
              padding: EdgeInsets.all(context.spacingLG),
              child: BalanceCard(
                balance: _balance,
                onRecharge: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RechargeScreen(),
                    ),
                  ).then((_) {
                    // Refresh balance when returning from recharge
                    _loadWalletData();
                  });
                },
              ),
            ),

            // Quick Stats
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.spacingLG),
              child: Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      context,
                      title: 'Total Spent',
                      value: '₦8,500',
                      icon: Icons.trending_down,
                      color: context.error,
                    ),
                  ),
                  SizedBox(width: context.spacingMD),
                  Expanded(
                    child: _buildStatCard(
                      context,
                      title: 'Total Recharged',
                      value: '₦12,500',
                      icon: Icons.trending_up,
                      color: context.success,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: context.spacingLG),

            // Transaction History
            Container(
              margin: EdgeInsets.all(context.spacingLG),
              padding: EdgeInsets.all(context.spacingLG),
              decoration: BoxDecoration(
                color: isDark ? context.darkCard : context.white,
                borderRadius: BorderRadius.circular(context.radiusLG),
                boxShadow: isDark ? null : context.shadowSM,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Transaction History',
                        style: context.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: context.textPrimary,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          foregroundColor: isDark ? context.accentPurple : context.primaryColor,
                        ),
                        child: Text(
                          'View All',
                          style: context.labelSmall?.copyWith(
                            color: isDark ? context.accentPurple : context.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: context.spacingMD),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _transactions.length,
                    itemBuilder: (context, index) {
                      return TransactionTile(
                        transaction: _transactions[index],
                        isLast: index == _transactions.length - 1,
                      );
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: context.spacingXL),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
      BuildContext context, {
        required String title,
        required String value,
        required IconData icon,
        required Color color,
      }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(context.spacingMD),
      decoration: BoxDecoration(
        color: isDark ? context.darkCard : context.white,
        borderRadius: BorderRadius.circular(context.radiusMD),
        boxShadow: isDark ? null : context.shadowSM,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(context.spacingXS),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 16, color: color),
              ),
              SizedBox(width: context.spacingSM),
              Expanded(
                child: Text(
                  title,
                  style: context.bodySmall?.copyWith(
                    color: context.textHint,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: context.spacingSM),
          Text(
            value,
            style: context.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: context.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}