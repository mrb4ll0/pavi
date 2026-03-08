import 'package:flutter/material.dart';
import 'package:pavi/home/homeScreen/transaction/transactionDetailsPage.dart';
import 'package:pavi/theme/generalTheme.dart';

class TransactionHistoryPage extends StatelessWidget {
  const TransactionHistoryPage({super.key});

  // Sample transaction data - replace with your actual data source
  final List<Map<String, dynamic>> _allTransactions = const [
    {
      'id': '1',
      'title': 'eSIM Purchase - Nigeria',
      'amount': '-₦2,500',
      'date': '2024-03-15 10:30:00',
      'type': 'debit',
      'status': 'completed',
      'icon': Icons.sim_card,
      'colorValue': 0xFF4CAF50,
      'description': '5GB Nigeria eSIM plan for 30 days',
      'reference': 'TXN-2024-001',
      'paymentMethod': 'Wallet Balance',
      'balance': '₦7,500',
    },
    {
      'id': '2',
      'title': 'Wallet Top-up',
      'amount': '+₦5,000',
      'date': '2024-03-14 20:15:00',
      'type': 'credit',
      'status': 'completed',
      'icon': Icons.account_balance_wallet,
      'colorValue': 0xFF2196F3,
      'description': 'Added funds to wallet via card payment',
      'reference': 'TXN-2024-002',
      'paymentMethod': 'Visa Card',
      'balance': '₦10,000',
    },
    {
      'id': '3',
      'title': 'Calling Plan - Unlimited',
      'amount': '-₦3,500',
      'date': '2024-03-14 15:20:00',
      'type': 'debit',
      'status': 'completed',
      'icon': Icons.phone,
      'colorValue': 0xFFFF9800,
      'description': 'Unlimited local calls for 30 days',
      'reference': 'TXN-2024-003',
      'paymentMethod': 'Wallet Balance',
      'balance': '₦5,000',
    },
    {
      'id': '4',
      'title': 'Referral Bonus',
      'amount': '+₦1,000',
      'date': '2024-03-13 09:45:00',
      'type': 'credit',
      'status': 'completed',
      'icon': Icons.share,
      'colorValue': 0xFF9C27B0,
      'description': 'Bonus for referring a friend',
      'reference': 'TXN-2024-004',
      'paymentMethod': 'Wallet Balance',
      'balance': '₦8,500',
    },
    {
      'id': '5',
      'title': 'eSIM Purchase - UK',
      'amount': '-₦4,500',
      'date': '2024-03-12 11:30:00',
      'type': 'debit',
      'status': 'pending',
      'icon': Icons.sim_card,
      'colorValue': 0xFFF44336,
      'description': '10GB UK eSIM plan for 15 days',
      'reference': 'TXN-2024-005',
      'paymentMethod': 'Wallet Balance',
      'balance': '₦7,500',
    },
    {
      'id': '6',
      'title': 'Wallet Top-up',
      'amount': '+₦3,000',
      'date': '2024-03-11 14:20:00',
      'type': 'credit',
      'status': 'completed',
      'icon': Icons.account_balance_wallet,
      'colorValue': 0xFF2196F3,
      'description': 'Added funds to wallet',
      'reference': 'TXN-2024-006',
      'paymentMethod': 'Bank Transfer',
      'balance': '₦12,000',
    },
    {
      'id': '7',
      'title': 'eSIM Purchase - USA',
      'amount': '-₦6,500',
      'date': '2024-03-10 16:45:00',
      'type': 'debit',
      'status': 'completed',
      'icon': Icons.sim_card,
      'colorValue': 0xFF4CAF50,
      'description': '15GB USA eSIM plan for 30 days',
      'reference': 'TXN-2024-007',
      'paymentMethod': 'Wallet Balance',
      'balance': '₦9,000',
    },
    {
      'id': '8',
      'title': 'Calling Plan - International',
      'amount': '-₦4,000',
      'date': '2024-03-09 13:15:00',
      'type': 'debit',
      'status': 'completed',
      'icon': Icons.phone,
      'colorValue': 0xFFFF9800,
      'description': '100 minutes international calls',
      'reference': 'TXN-2024-008',
      'paymentMethod': 'Wallet Balance',
      'balance': '₦15,500',
    },
    {
      'id': '9',
      'title': 'Referral Bonus',
      'amount': '+₦1,000',
      'date': '2024-03-08 10:30:00',
      'type': 'credit',
      'status': 'completed',
      'icon': Icons.share,
      'colorValue': 0xFF9C27B0,
      'description': 'Bonus for referring a friend',
      'reference': 'TXN-2024-009',
      'paymentMethod': 'Wallet Balance',
      'balance': '₦19,500',
    },
    {
      'id': '10',
      'title': 'eSIM Purchase - Japan',
      'amount': '-₦5,500',
      'date': '2024-03-07 09:00:00',
      'type': 'debit',
      'status': 'pending',
      'icon': Icons.sim_card,
      'colorValue': 0xFFF44336,
      'description': '8GB Japan eSIM plan for 14 days',
      'reference': 'TXN-2024-010',
      'paymentMethod': 'Wallet Balance',
      'balance': '₦18,500',
    },
  ];

  String _formatDate(String dateString) {
    final date = DateTime.parse(dateString.replaceFirst(' ', 'T'));
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today, ${_formatTime(date)}';
    } else if (difference.inDays == 1) {
      return 'Yesterday, ${_formatTime(date)}';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  String _formatTime(DateTime date) {
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: context.offWhite,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Transaction History',
            style: context.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: TabBar(
            indicatorColor: context.primaryGreen,
            labelColor: context.primaryGreen,
            unselectedLabelColor: context.mediumGray,
            tabs: const [
              Tab(text: 'All'),
              Tab(text: 'Credit'),
              Tab(text: 'Debit'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildTransactionList(context, _allTransactions),
            _buildTransactionList(
                context,
                _allTransactions.where((t) => t['type'] == 'credit').toList()
            ),
            _buildTransactionList(
                context,
                _allTransactions.where((t) => t['type'] == 'debit').toList()
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionList(BuildContext context, List<Map<String, dynamic>> transactions) {
    if (transactions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: context.primaryGreen.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.history,
                size: 48,
                color: context.primaryGreen.withOpacity(0.5),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'No transactions found',
              style: context.titleMedium?.copyWith(
                color: context.mediumGray,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return _buildTransactionCard(context, transaction);
      },
    );
  }

  Widget _buildTransactionCard(BuildContext context, Map<String, dynamic> transaction) {
    final isCredit = transaction['type'] == 'credit';
    final amountColor = isCredit ? context.success : null;
    final transactionColor = Color(transaction['colorValue'] as int);
    final date = DateTime.parse(transaction['date'].replaceFirst(' ', 'T'));

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(context.radiusMD),
        side: BorderSide(
          color: context.lightGray,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TransactionDetailsPage(
                transaction: transaction,
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(context.radiusMD),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: transactionColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(context.radiusSM),
                ),
                child: Icon(
                  transaction['icon'] as IconData,
                  color: transactionColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),

              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction['title'] as String,
                      style: context.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 12,
                          color: context.mediumGray,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _formatDate(transaction['date']),
                          style: context.labelSmall?.copyWith(
                            color: context.mediumGray,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Amount and Status
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    transaction['amount'] as String,
                    style: context.titleMedium?.copyWith(
                      color: amountColor ?? context.deepNavy,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (transaction['status'] == 'pending')
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: context.actionAmber.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(context.radiusXS),
                      ),
                      child: Text(
                        'Pending',
                        style: context.labelSmall?.copyWith(
                          color: context.actionAmber,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
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
}