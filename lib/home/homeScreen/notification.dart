import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationPage extends StatefulWidget {
   NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final DateFormat _timeFormat = DateFormat('MMM dd, yyyy • hh:mm a');

  // Sample notification data - replace with your actual data source
  final List<NotificationModel> _allNotifications = [
    NotificationModel(
      id: '1',
      title: 'eSIM Activated Successfully',
      message: 'Your eSIM for Japan has been activated. You can now use data services.',
      type: NotificationType.success,
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      isRead: false,
      actionUrl: '/esim/details',
      icon: Icons.sim_card_alert,
    ),
    NotificationModel(
      id: '2',
      title: 'Data Usage Alert',
      message: 'You\'ve used 80% of your 10GB data package for Japan eSIM.',
      type: NotificationType.warning,
      timestamp: DateTime.now().subtract(const Duration(hours: 5)),
      isRead: false,
      actionUrl: '/usage/details',
      icon: Icons.data_usage,
    ),
    NotificationModel(
      id: '3',
      title: 'Payment Successful',
      message: 'Your payment of \$29.99 for Japan eSIM has been processed successfully.',
      type: NotificationType.success,
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      isRead: true,
      actionUrl: '/payments/history',
      icon: Icons.payment,
    ),
    NotificationModel(
      id: '4',
      title: 'eSIM Expiring Soon',
      message: 'Your Japan eSIM will expire in 3 days. Renew now to avoid service interruption.',
      type: NotificationType.warning,
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      isRead: false,
      actionUrl: '/esim/renew',
      icon: Icons.timer,
    ),
    NotificationModel(
      id: '5',
      title: 'New Coverage Added',
      message: 'We\'ve added eSIM coverage for 5 new countries: Vietnam, Thailand, Malaysia, Singapore, and Indonesia.',
      type: NotificationType.info,
      timestamp: DateTime.now().subtract(const Duration(days: 3)),
      isRead: true,
      actionUrl: '/coverage/new',
      icon: Icons.public,
    ),
    NotificationModel(
      id: '6',
      title: 'Promotional Offer',
      message: 'Get 20% off on all eSIMs for Southeast Asia. Limited time offer!',
      type: NotificationType.promotion,
      timestamp: DateTime.now().subtract(const Duration(days: 4)),
      isRead: false,
      actionUrl: '/promotions',
      icon: Icons.local_offer,
    ),
    NotificationModel(
      id: '7',
      title: 'Installation Failed',
      message: 'There was an issue installing your eSIM. Please try again or contact support.',
      type: NotificationType.error,
      timestamp: DateTime.now().subtract(const Duration(days: 5)),
      isRead: true,
      actionUrl: '/support',
      icon: Icons.error,
    ),
    NotificationModel(
      id: '8',
      title: 'Top-up Successful',
      message: 'Your data top-up of 5GB for Japan eSIM has been added successfully.',
      type: NotificationType.success,
      timestamp: DateTime.now().subtract(const Duration(days: 6)),
      isRead: true,
      actionUrl: '/usage/details',
      icon: Icons.add_circle,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<NotificationModel> get _unreadNotifications =>
      _allNotifications.where((n) => !n.isRead).toList();

  List<NotificationModel> get _readNotifications =>
      _allNotifications.where((n) => n.isRead).toList();

  void _markAsRead(NotificationModel notification) {
    setState(() {
      notification.isRead = true;
    });
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in _allNotifications) {
        notification.isRead = true;
      }
    });
  }

  void _deleteNotification(NotificationModel notification) {
    setState(() {
      _allNotifications.remove(notification);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Notification deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _allNotifications.add(notification);
            });
          },
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _clearAll() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Notifications'),
        content: const Text('Are you sure you want to clear all notifications?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              setState(() {
                _allNotifications.clear();
              });
              Navigator.pop(context);
            },
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('All'),
                  if (_allNotifications.isNotEmpty) ...[
                    const SizedBox(width: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        _allNotifications.length.toString(),
                        style: textTheme.labelSmall?.copyWith(
                          color: colorScheme.onPrimary,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Unread'),
                  if (_unreadNotifications.isNotEmpty) ...[
                    const SizedBox(width: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        _unreadNotifications.length.toString(),
                        style: textTheme.labelSmall?.copyWith(
                          color: colorScheme.onPrimary,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const Tab(text: 'Read'),
          ],
        ),
        actions: [
          if (_unreadNotifications.isNotEmpty)
            IconButton(
              onPressed: _markAllAsRead,
              icon: const Icon(Icons.done_all),
              tooltip: 'Mark all as read',
            ),
          if (_allNotifications.isNotEmpty)
            IconButton(
              onPressed: _clearAll,
              icon: const Icon(Icons.delete_sweep),
              tooltip: 'Clear all',
            ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildNotificationList(
            context,
            notifications: _allNotifications,
            emptyMessage: 'No notifications yet',
            emptyIcon: Icons.notifications_off,
          ),
          _buildNotificationList(
            context,
            notifications: _unreadNotifications,
            emptyMessage: 'No unread notifications',
            emptyIcon: Icons.mark_email_read,
          ),
          _buildNotificationList(
            context,
            notifications: _readNotifications,
            emptyMessage: 'No read notifications',
            emptyIcon: Icons.mark_as_unread,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationList(
      BuildContext context, {
        required List<NotificationModel> notifications,
        required String emptyMessage,
        required IconData emptyIcon,
      }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (notifications.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceVariant.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  emptyIcon,
                  size: 48,
                  color: colorScheme.onSurfaceVariant.withOpacity(0.5),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                emptyMessage,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'When you get notifications, they\'ll appear here',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant.withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return _buildNotificationCard(context, notification);
      },
    );
  }

  Widget _buildNotificationCard(
      BuildContext context,
      NotificationModel notification,
      ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: notification.isRead
            ? BorderSide.none
            : BorderSide(
          color: _getNotificationColor(notification.type, colorScheme),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: () {
          if (!notification.isRead) {
            _markAsRead(notification);
          }
          // Handle navigation or action
          _handleNotificationTap(notification);
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: notification.isRead
                ? colorScheme.surfaceVariant.withOpacity(0.3)
                : colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon section
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _getNotificationColor(notification.type, colorScheme)
                      .withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  notification.icon,
                  color: _getNotificationColor(notification.type, colorScheme),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),

              // Content section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: notification.isRead
                                  ? FontWeight.normal
                                  : FontWeight.bold,
                            ),
                          ),
                        ),
                        if (!notification.isRead)
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: _getNotificationColor(
                                  notification.type, colorScheme),
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notification.message,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 12,
                          color: colorScheme.onSurfaceVariant.withOpacity(0.7),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _timeFormat.format(notification.timestamp),
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: colorScheme.onSurfaceVariant.withOpacity(0.7),
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Actions section
              PopupMenuButton<String>(
                icon: Icon(
                  Icons.more_vert,
                  size: 18,
                  color: colorScheme.onSurfaceVariant,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                onSelected: (value) {
                  switch (value) {
                    case 'read':
                      _markAsRead(notification);
                      break;
                    case 'delete':
                      _deleteNotification(notification);
                      break;
                  }
                },
                itemBuilder: (context) => [
                  if (!notification.isRead)
                    PopupMenuItem(
                      value: 'read',
                      child: Row(
                        children: [
                          Icon(
                            Icons.mark_email_read,
                            size: 18,
                            color: colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          const Text('Mark as read'),
                        ],
                      ),
                    ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete,
                          size: 18,
                          color: colorScheme.error,
                        ),
                        const SizedBox(width: 8),
                        const Text('Delete'),
                      ],
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

  void _handleNotificationTap(NotificationModel notification) {
    // Show a snackbar for now - replace with actual navigation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tapped: ${notification.title}'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  Color _getNotificationColor(NotificationType type, ColorScheme colorScheme) {
    switch (type) {
      case NotificationType.success:
        return colorScheme.primary; // or Colors.green
      case NotificationType.warning:
        return Colors.orange;
      case NotificationType.error:
        return colorScheme.error;
      case NotificationType.info:
        return Colors.blue;
      case NotificationType.promotion:
        return Colors.purple;
    }
  }
}

// Notification Model
class NotificationModel {
  final String id;
  final String title;
  final String message;
  final NotificationType type;
  final DateTime timestamp;
  bool isRead;
  final String? actionUrl;
  final IconData icon;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.timestamp,
    required this.isRead,
    this.actionUrl,
    required this.icon,
  });
}

enum NotificationType {
  success,
  warning,
  error,
  info,
  promotion,
}