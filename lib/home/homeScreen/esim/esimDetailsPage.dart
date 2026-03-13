import 'package:flutter/material.dart';
import 'package:pavi/theme/generalTheme.dart';

class ESIMDetailsPage extends StatelessWidget {
  final Map<String, dynamic> eSIMData;

  const ESIMDetailsPage({
    super.key,
    required this.eSIMData,
  });

  // Sample eSIM data - replace with your actual data source
  static const Map<String, dynamic> sampleESIM = {
    'id': 'ESIM-001',
    'country': 'Nigeria',
    'flag': '🇳🇬',
    'plan': '5GB Data Plan',
    'data': '5GB',
    'days': '30',
    'price': '₦2,500',
    'status': 'active',
    'purchaseDate': '2024-03-15 10:30:00',
    'expiryDate': '2024-04-14 10:30:00',
    'iccid': '89410200000123456789',
    'qrCode': 'assets/images/qr_placeholder.png',
    'apn': 'internet.ng',
    'phoneNumber': '+234 802 345 6789',
    'coverage': [
      'Lagos',
      'Abuja',
      'Port Harcourt',
      'Kano',
      'Ibadan',
    ],
    'features': [
      'High-speed 4G/LTE data',
      'No roaming charges',
      'Instant activation',
      '24/7 customer support',
      'Top-up anytime',
    ],
    'usage': {
      'used': '2.3GB',
      'total': '5GB',
      'percentage': 46,
    },
    'carrier': 'MTN Nigeria',
    'type': 'Data Only',
  };

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        backgroundColor: context.surfaceColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: context.textPrimary,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'eSIM Details',
          style: context.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.textPrimary,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: context.textPrimary,
            ),
            onPressed: () {
              _showMenu(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Status Card with Flag
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? context.darkCard : context.white,
                borderRadius: BorderRadius.circular(context.radiusLG),
                boxShadow: isDark ? null : context.shadowSM,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: (isDark ? context.accentPurple : context.primaryColor).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(context.radiusMD),
                        ),
                        child: Text(
                          eSIMData['flag'] ?? '🇳🇬',
                          style: const TextStyle(fontSize: 32),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              eSIMData['country'] ?? 'Nigeria',
                              style: context.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: context.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              eSIMData['plan'] ?? '5GB Data Plan',
                              style: context.bodyMedium?.copyWith(
                                color: context.textSecondary,
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
                          color: _getStatusColor(eSIMData['status'], context).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(context.radiusSM),
                          border: Border.all(
                            color: _getStatusColor(eSIMData['status'], context),
                          ),
                        ),
                        child: Text(
                          eSIMData['status']?.toString().toUpperCase() ?? 'ACTIVE',
                          style: context.labelSmall?.copyWith(
                            color: _getStatusColor(eSIMData['status'], context),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Usage Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
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
                        'Data Usage',
                        style: context.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.textPrimary,
                        ),
                      ),
                      Text(
                        '${eSIMData['usage']['used']} / ${eSIMData['usage']['total']}',
                        style: context.bodyMedium?.copyWith(
                          color: isDark ? context.accentPurple : context.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(context.radiusXS),
                    child: LinearProgressIndicator(
                      value: (eSIMData['usage']['percentage'] ?? 0) / 100,
                      backgroundColor: isDark ? context.darkTextHint.withOpacity(0.3) : context.lightGray,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        eSIMData['usage']['percentage'] > 80
                            ? context.error
                            : (isDark ? context.accentPurple : context.primaryColor),
                      ),
                      minHeight: 8,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildUsageStat(
                        context,
                        icon: Icons.data_usage,
                        label: 'Data',
                        value: eSIMData['data'] ?? '5GB',
                      ),
                      _buildUsageStat(
                        context,
                        icon: Icons.timer_outlined,
                        label: 'Days Left',
                        value: _calculateDaysLeft(eSIMData['expiryDate']),
                      ),
                      _buildUsageStat(
                        context,
                        icon: Icons.sim_card,
                        label: 'Type',
                        value: eSIMData['type'] ?? 'Data',
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Quick Actions
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? context.darkCard : context.white,
                borderRadius: BorderRadius.circular(context.radiusLG),
                boxShadow: isDark ? null : context.shadowSM,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quick Actions',
                    style: context.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildActionButton(
                          context,
                          icon: Icons.add_circle_outline,
                          label: 'Top Up',
                          color: isDark ? context.accentPurple : context.primaryColor,
                          onTap: () {
                            // Handle top up
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildActionButton(
                          context,
                          icon: Icons.autorenew,
                          label: 'Renew',
                          color: context.warning,
                          onTap: () {
                            // Handle renew
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildActionButton(
                          context,
                          icon: Icons.share,
                          label: 'Share eSIM',
                          color: context.info,
                          onTap: () {
                            // Handle share
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildActionButton(
                          context,
                          icon: Icons.support_agent,
                          label: 'Support',
                          color: context.textSecondary,
                          onTap: () {
                            // Handle support
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // QR Code Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? context.darkCard : context.white,
                borderRadius: BorderRadius.circular(context.radiusLG),
                boxShadow: isDark ? null : context.shadowSM,
              ),
              child: Column(
                children: [
                  Text(
                    'Scan QR Code to Install',
                    style: context.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: isDark ? context.darkSurface : context.lightGray.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(context.radiusMD),
                      border: Border.all(
                        color: isDark ? context.darkTextHint.withOpacity(0.3) : context.lightGray,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.qr_code,
                        size: 120,
                        color: context.textHint.withOpacity(0.3),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton.icon(
                    onPressed: () {
                      // Download QR
                    },
                    icon: Icon(
                      Icons.download,
                      size: 18,
                      color: isDark ? context.accentPurple : context.primaryColor,
                    ),
                    label: Text(
                      'Download QR Code',
                      style: context.bodyMedium?.copyWith(
                        color: isDark ? context.accentPurple : context.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // eSIM Information Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? context.darkCard : context.white,
                borderRadius: BorderRadius.circular(context.radiusLG),
                boxShadow: isDark ? null : context.shadowSM,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'eSIM Information',
                    style: context.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildInfoRow(
                    context,
                    label: 'ICCID',
                    value: eSIMData['iccid'] ?? '89410200000123456789',
                    icon: Icons.sim_card,
                    canCopy: true,
                  ),

                  _buildInfoRow(
                    context,
                    label: 'APN',
                    value: eSIMData['apn'] ?? 'internet.ng',
                    icon: Icons.settings_ethernet,
                    canCopy: true,
                  ),

                  _buildInfoRow(
                    context,
                    label: 'Phone Number',
                    value: eSIMData['phoneNumber'] ?? '+234 802 345 6789',
                    icon: Icons.phone,
                    canCopy: true,
                  ),

                  _buildInfoRow(
                    context,
                    label: 'Carrier',
                    value: eSIMData['carrier'] ?? 'MTN Nigeria',
                    icon: Icons.business,
                  ),

                  _buildInfoRow(
                    context,
                    label: 'Purchase Date',
                    value: _formatDate(eSIMData['purchaseDate']),
                    icon: Icons.calendar_today,
                  ),

                  _buildInfoRow(
                    context,
                    label: 'Expiry Date',
                    value: _formatDate(eSIMData['expiryDate']),
                    icon: Icons.event,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Coverage & Features Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? context.darkCard : context.white,
                borderRadius: BorderRadius.circular(context.radiusLG),
                boxShadow: isDark ? null : context.shadowSM,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Coverage & Features',
                    style: context.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Coverage
                  Text(
                    'Coverage Areas',
                    style: context.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: context.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: (eSIMData['coverage'] as List? ?? []).map((city) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: (isDark ? context.accentPurple : context.primaryColor).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(context.radiusSM),
                        ),
                        child: Text(
                          city,
                          style: context.labelSmall?.copyWith(
                            color: isDark ? context.accentPurple : context.primaryColor,
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 16),

                  // Features
                  Text(
                    'Plan Features',
                    style: context.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: context.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...(eSIMData['features'] as List? ?? []).map((feature) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 18,
                            color: isDark ? context.accentPurple : context.primaryColor,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              feature,
                              style: context.bodyMedium?.copyWith(
                                color: context.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Danger Zone (for active eSIMs)
            if (eSIMData['status'] == 'active')
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDark ? context.darkCard : context.white,
                  borderRadius: BorderRadius.circular(context.radiusLG),
                  border: Border.all(
                    color: context.error.withOpacity(0.3),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.warning_amber_rounded,
                          color: context.error,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Danger Zone',
                          style: context.titleMedium?.copyWith(
                            color: context.error,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton(
                      onPressed: () {
                        _showDeactivateDialog(context);
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: context.error,
                        side: BorderSide(color: context.error),
                        minimumSize: const Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(context.radiusMD),
                        ),
                      ),
                      child: const Text('Deactivate eSIM'),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildUsageStat(
      BuildContext context, {
        required IconData icon,
        required String label,
        required String value,
      }) {
    return Expanded(
      child: Column(
        children: [
          Icon(
            icon,
            size: 20,
            color: context.textHint,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: context.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.textPrimary,
            ),
          ),
          Text(
            label,
            style: context.labelSmall?.copyWith(
              color: context.textHint,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
      BuildContext context, {
        required IconData icon,
        required String label,
        required Color color,
        required VoidCallback onTap,
      }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(context.radiusMD),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(context.radiusMD),
          border: Border.all(
            color: color.withOpacity(0.3),
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: context.labelSmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
      BuildContext context, {
        required String label,
        required String value,
        required IconData icon,
        bool canCopy = false,
      }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: (isDark ? context.accentPurple : context.primaryColor).withOpacity(0.1),
              borderRadius: BorderRadius.circular(context.radiusXS),
            ),
            child: Icon(
              icon,
              size: 14,
              color: isDark ? context.accentPurple : context.primaryColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: context.labelSmall?.copyWith(
                    color: context.textHint,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        value,
                        style: context.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: context.textPrimary,
                        ),
                      ),
                    ),
                    if (canCopy)
                      IconButton(
                        onPressed: () {
                          _copyToClipboard(context, value);
                        },
                        icon: Icon(
                          Icons.copy,
                          size: 16,
                          color: isDark ? context.accentPurple : context.primaryColor,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showMenu(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? context.darkSurface : context.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(context.radiusLG),
        ),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.refresh, color: isDark ? context.accentPurple : context.primaryColor),
              title: Text(
                'Refresh eSIM',
                style: TextStyle(color: context.textPrimary),
              ),
              onTap: () {
                Navigator.pop(context);
                // Handle refresh
              },
            ),
            ListTile(
              leading: Icon(Icons.share, color: context.info),
              title: Text(
                'Share eSIM Details',
                style: TextStyle(color: context.textPrimary),
              ),
              onTap: () {
                Navigator.pop(context);
                // Handle share
              },
            ),
            ListTile(
              leading: Icon(Icons.history, color: context.warning),
              title: Text(
                'Usage History',
                style: TextStyle(color: context.textPrimary),
              ),
              onTap: () {
                Navigator.pop(context);
                // Navigate to usage history
              },
            ),
            ListTile(
              leading: Icon(Icons.report_problem, color: context.error),
              title: Text(
                'Report Issue',
                style: TextStyle(color: context.textPrimary),
              ),
              onTap: () {
                Navigator.pop(context);
                // Handle report
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDeactivateDialog(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? context.darkSurface : context.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.radiusLG),
        ),
        title: Text(
          'Deactivate eSIM',
          style: TextStyle(color: context.textPrimary),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.warning_amber_rounded,
              size: 48,
              color: context.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Are you sure you want to deactivate this eSIM?',
              textAlign: TextAlign.center,
              style: TextStyle(color: context.textPrimary),
            ),
            const SizedBox(height: 8),
            Text(
              'This action cannot be undone. Any remaining data will be lost.',
              style: context.bodySmall?.copyWith(
                color: context.textHint,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: context.textSecondary),
            ),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              // Handle deactivation
            },
            style: FilledButton.styleFrom(
              backgroundColor: context.error,
            ),
            child: const Text('Deactivate'),
          ),
        ],
      ),
    );
  }

  void _copyToClipboard(BuildContext context, String text) {
    // Implement copy to clipboard
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Copied to clipboard'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: context.success,
      ),
    );
  }

  Color _getStatusColor(String? status, BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    switch (status?.toLowerCase()) {
      case 'active':
        return context.success;
      case 'expired':
        return context.error;
      case 'pending':
        return context.warning;
      default:
        return context.textHint;
    }
  }

  String _calculateDaysLeft(String? expiryDate) {
    if (expiryDate == null) return '30 days';
    try {
      final expiry = DateTime.parse(expiryDate.replaceFirst(' ', 'T'));
      final now = DateTime.now();
      final daysLeft = expiry.difference(now).inDays;
      return '$daysLeft days';
    } catch (e) {
      return '30 days';
    }
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return 'N/A';
    try {
      final date = DateTime.parse(dateString.replaceFirst(' ', 'T'));
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return 'N/A';
    }
  }
}