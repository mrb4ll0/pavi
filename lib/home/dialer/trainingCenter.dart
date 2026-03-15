import 'package:flutter/material.dart';
import 'package:pavi/theme/generalTheme.dart';

class TrainingCenter extends StatefulWidget {
  const TrainingCenter({super.key});

  @override
  State<TrainingCenter> createState() => _TrainingCenterState();
}

class _TrainingCenterState extends State<TrainingCenter> with TickerProviderStateMixin {
  int _userCoins = 1250;
  int _streakDays = 7;
  double _progressToGoal = 0.65; // 65% to 1GB data

  final List<Map<String, dynamic>> _taskCategories = [
    {
      'id': 'image_tagging',
      'title': 'Image Tagging',
      'icon': Icons.image,
      'description': 'Identify objects in street photos',
      'timePerTask': '30 sec',
      'coinsPerTask': 10,
      'difficulty': 'Easy',
      'difficultyColor': Colors.green,
      'isHot': false,
      'isMaster': false,
      'backgroundImage': '📸',
    },
    {
      'id': 'voice_recording',
      'title': 'Voice Recording',
      'icon': Icons.mic,
      'description': 'Record Hausa phrases',
      'timePerTask': '1 min',
      'coinsPerTask': 25,
      'difficulty': 'Master',
      'difficultyColor': Colors.purple,
      'isHot': true,
      'isMaster': true,
      'backgroundImage': '🎙️',
    },
    {
      'id': 'text_review',
      'title': 'Text Review',
      'icon': Icons.text_fields,
      'description': 'Verify Pidgin translations',
      'timePerTask': '15 sec',
      'coinsPerTask': 5,
      'difficulty': 'Easy',
      'difficultyColor': Colors.green,
      'isHot': false,
      'isMaster': false,
      'backgroundImage': '📝',
    },
    {
      'id': 'sentiment_analysis',
      'title': 'Sentiment Analysis',
      'icon': Icons.sentiment_satisfied,
      'description': 'Rate customer feedback',
      'timePerTask': '20 sec',
      'coinsPerTask': 8,
      'difficulty': 'Medium',
      'difficultyColor': Colors.orange,
      'isHot': true,
      'isMaster': false,
      'backgroundImage': '😊',
    },
    {
      'id': 'object_detection',
      'title': 'Object Detection',
      'icon': Icons.camera_alt,
      'description': 'Draw boxes around objects',
      'timePerTask': '45 sec',
      'coinsPerTask': 15,
      'difficulty': 'Medium',
      'difficultyColor': Colors.orange,
      'isHot': false,
      'isMaster': false,
      'backgroundImage': '🔍',
    },
  ];

  final List<Map<String, dynamic>> _recentTasks = [
    {
      'id': 'task1',
      'type': 'Image Tagging',
      'coins': 10,
      'time': '2 min ago',
    },
    {
      'id': 'task2',
      'type': 'Voice Recording',
      'coins': 25,
      'time': '15 min ago',
    },
    {
      'id': 'task3',
      'type': 'Text Review',
      'coins': 5,
      'time': '1 hour ago',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    return Scaffold(
      backgroundColor: context.backgroundColor,
      body: CustomScrollView(
        slivers: [
          // App Bar with Greeting
          SliverAppBar(
            floating: true,
            backgroundColor: context.surfaceColor,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi, John! 👋',
                  style: context.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Ready to earn today?',
                  style: context.bodyMedium?.copyWith(
                    color: context.textSecondary,
                  ),
                ),
              ],
            ),
            actions: [
              // Streak Counter
              Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.orange.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.local_fire_department,
                      color: Colors.orange,
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '$_streakDays',
                      style: const TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              // Coin Balance
              Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.amber.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.monetization_on,
                      color: Colors.amber,
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '$_userCoins',
                      style: const TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.notifications_outlined, color: context.textPrimary),
                onPressed: () {},
              ),
            ],
          ),

          // Progress to Goal Card
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.all(context.spacingLG),
              padding: EdgeInsets.all(context.spacingMD),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    context.primaryColor,
                    context.accentPurple,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: context.primaryColor.withOpacity(0.3),
                    blurRadius: 15,
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
                        'Progress to 1GB Data',
                        style: context.bodyLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${(_progressToGoal * 100).toInt()}%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Stack(
                    children: [
                      Container(
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Container(
                        height: 12,
                        width: mediaQuery.size.width * 0.7 * _progressToGoal,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Colors.amber, Colors.orange],
                          ),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.amber.withOpacity(0.5),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_userCoins} coins earned',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        '${(3500 - _userCoins)} coins to go',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Quick Stats Row
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: context.spacingLG),
              child: Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      context,
                      label: 'Today',
                      value: '235',
                      icon: Icons.today,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      context,
                      label: 'This Week',
                      value: '1,450',
                      icon: Icons.weekend,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      context,
                      label: 'Lifetime',
                      value: '12.5k',
                      icon: Icons.auto_awesome,
                      color: Colors.purple,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Section Header: Available Tasks
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(context.spacingLG),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Available Tasks',
                    style: context.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
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

          // Task Categories Grid
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: context.spacingLG),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: screenWidth > 600 ? 3 : 2,
                childAspectRatio: 1.1,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final task = _taskCategories[index];
                  return _buildTaskCard(context, task);
                },
                childCount: _taskCategories.length,
              ),
            ),
          ),

          // Section Header: Hot Tasks
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(context.spacingLG),
              child: Row(
                children: [
                  Icon(
                    Icons.local_fire_department,
                    color: Colors.orange,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Hot Tasks',
                    style: context.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Hot Tasks Horizontal List
          SliverToBoxAdapter(
            child: SizedBox(
              height: 140,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: context.spacingLG),
                itemCount: _taskCategories.where((t) => t['isHot'] == true).length,
                itemBuilder: (context, index) {
                  final hotTasks = _taskCategories.where((t) => t['isHot'] == true).toList();
                  final task = hotTasks[index];
                  return _buildHotTaskCard(context, task);
                },
              ),
            ),
          ),

          // Section Header: Recent Activity
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(context.spacingLG),
              child: Text(
                'Recent Activity',
                style: context.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Recent Activity List
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                final activity = _recentTasks[index];
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
                        child: Icon(
                          Icons.task_alt,
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
                              activity['type'],
                              style: context.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              activity['time'],
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
                              size: 14,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              '+${activity['coins']}',
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
              childCount: _recentTasks.length,
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

  Widget _buildStatCard(
      BuildContext context, {
        required String label,
        required String value,
        required IconData icon,
        required Color color,
      }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? context.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: context.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.textPrimary,
            ),
          ),
          Text(
            label,
            style: context.labelSmall?.copyWith(
              color: context.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildTaskCard(BuildContext context, Map<String, dynamic> task) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        _showTaskExecutionDialog(context, task);
      },
      child: Container(
        height: 160, // Fixed height
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [context.darkCard, context.darkSurface]
                : [Colors.white, task['isHot'] == true ? Colors.orange.shade50 : Colors.grey.shade50],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: task['isHot'] == true
                ? Colors.orange.withOpacity(0.3)
                : (isDark ? Colors.grey.shade800 : Colors.grey.shade200),
            width: task['isHot'] == true ? 2 : 1,
          ),
        ),
        child: Stack(
          children: [
            // Badges
            if (task['isHot'] == true)
              Positioned(top: 8, right: 8, child: _buildHotBadge()),
            if (task['isMaster'] == true)
              Positioned(top: 8, left: 8, child: _buildMasterBadge()),

            // Content
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon - fixed height
                  SizedBox(
                    height: 36,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: (task['difficultyColor'] as Color).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(task['backgroundImage'], style: const TextStyle(fontSize: 20)),
                    ),
                  ),

                  const SizedBox(height: 6),

                  // Title - fixed height
                  SizedBox(
                    height: 18,
                    child: Text(
                      task['title'],
                      style: context.titleSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  // Description - fixed height
                  SizedBox(
                    height: 16,
                    child: Text(
                      task['description'],
                      style: context.bodySmall?.copyWith(color: context.textSecondary, fontSize: 10),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  const Spacer(),

                  // Bottom row - fixed height
                  SizedBox(
                    height: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildTimeChip(context, task['timePerTask']),
                        _buildRewardChip(task['coinsPerTask']),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

// Helper widgets for better organization
  Widget _buildHotBadge() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
      child: const Icon(Icons.local_fire_department, color: Colors.white, size: 10),
    );
  }

  Widget _buildMasterBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      decoration: BoxDecoration(color: Colors.purple, borderRadius: BorderRadius.circular(4)),
      child: const Text('MASTER', style: TextStyle(color: Colors.white, fontSize: 7, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildTimeChip(BuildContext context, String time) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.timer, size: 8, color: context.textSecondary),
          const SizedBox(width: 1),
          Text(time, style: context.labelSmall?.copyWith(fontSize: 7, color: context.textSecondary)),
        ],
      ),
    );
  }

  Widget _buildRewardChip(int coins) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      decoration: BoxDecoration(color: Colors.amber.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.monetization_on, size: 8, color: Colors.amber),
          const SizedBox(width: 1),
          Text('$coins', style: const TextStyle(color: Colors.amber, fontSize: 7, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildHotTaskCard(BuildContext context, Map<String, dynamic> task) {
    return GestureDetector(
      onTap: () {
        _showTaskExecutionDialog(context, task);
      },
      child: Container(
        width: 200,
        height: 140, // Fixed height
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.orange.shade700,
              Colors.orange.shade400,
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.orange.withOpacity(0.4),
              blurRadius: 12,
              spreadRadius: 2,
            ),
          ],
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top row - fixed height
                  SizedBox(
                    height: 28,
                    child: Row(
                      children: [
                        Text(
                          task['backgroundImage'],
                          style: const TextStyle(fontSize: 22),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.local_fire_department,
                            color: Colors.white,
                            size: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 4),

                  // Title - fixed height
                  SizedBox(
                    height: 18,
                    child: Text(
                      task['title'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  // Description - fixed height
                  SizedBox(
                    height: 16,
                    child: Text(
                      task['description'],
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 11,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  const Spacer(),

                  // Bottom row - fixed height
                  SizedBox(
                    height: 24,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Time
                        Row(
                          children: [
                            const Icon(
                              Icons.timer,
                              color: Colors.white70,
                              size: 12,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              task['timePerTask'],
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),

                        // Reward
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.monetization_on,
                                color: Colors.white,
                                size: 10,
                              ),
                              const SizedBox(width: 1),
                              Text(
                                '${task['coinsPerTask'] * 2}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                            ],
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
    );
  }

  void _showTaskExecutionDialog(BuildContext context, Map<String, dynamic> task) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFF1E1E1E)
              : Colors.white,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Header
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.local_fire_department,
                          color: Colors.orange,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${_streakDays} Streak',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '5/20 done',
                    style: TextStyle(
                      color: context.textSecondary,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            // Progress bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Stack(
                children: [
                  Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  Container(
                    height: 8,
                    width: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.amber, Colors.orange],
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Task card
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF2A2A2A)
                      : Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.2),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      task['backgroundImage'],
                      style: const TextStyle(fontSize: 80),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      task['title'],
                      style: context.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Is this a motorcycle?',
                      style: context.bodyLarge?.copyWith(
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),

                    // Action buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              _showTaskResultDialog(context, true, task['coinsPerTask']);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text(
                              'YES',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              _showTaskResultDialog(context, false, task['coinsPerTask']);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text(
                              'NO',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'Skip',
                            style: TextStyle(
                              color: context.textSecondary,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'Exit',
                            style: TextStyle(
                              color: context.textSecondary,
                            ),
                          ),
                        ),
                      ],
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

  void _showTaskResultDialog(BuildContext context, bool correct, int baseCoins) {
    final coinsEarned = correct ? baseCoins : 2;

    if (correct) {
      setState(() {
        _userCoins += coinsEarned;
        _streakDays++;
        _progressToGoal = (_userCoins / 3500).clamp(0.0, 1.0);
      });
    }

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: correct
                  ? [Colors.green.shade400, Colors.green.shade600]
                  : [Colors.orange.shade400, Colors.orange.shade600],
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Animated icon
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  correct ? Icons.emoji_events : Icons.thumb_up,
                  color: Colors.white,
                  size: 48,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                correct ? 'Correct! 🎉' : 'Good try! 👍',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                correct
                    ? 'You earned $coinsEarned coins!'
                    : 'You earned $coinsEarned coins for trying!',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _showTaskExecutionDialog(context, _taskCategories[0]);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: correct ? Colors.green : Colors.orange,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text('Next Task'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Back to Tasks',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}