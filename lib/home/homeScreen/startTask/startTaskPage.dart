import 'package:flutter/material.dart';
import 'package:pavi/core/general/generalMethods.dart';
import 'package:pavi/theme/generalTheme.dart';

class StartTaskPage extends StatefulWidget {
  const StartTaskPage({super.key});

  @override
  State<StartTaskPage> createState() => _StartTaskPageState();
}

class _StartTaskPageState extends State<StartTaskPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? _selectedCategory;

  final List<Map<String, dynamic>> _categories = [
    {'name': 'All', 'icon': Icons.grid_view, 'color': 0xFF6C63FF},
    {'name': 'Surveys', 'icon': Icons.quiz, 'color': 0xFF4CAF50},
    {'name': 'Watch', 'icon': Icons.play_circle, 'color': 0xFF2196F3},
    {'name': 'Games', 'icon': Icons.games, 'color': 0xFFFF9800},
    {'name': 'Referrals', 'icon': Icons.share, 'color': 0xFF9C27B0},
    {'name': 'Daily', 'icon': Icons.calendar_today, 'color': 0xFFF44336},
  ];

  final List<Map<String, dynamic>> _tasks = [
    {
      'title': 'Quick Survey - Consumer Feedback',
      'category': 'Surveys',
      'reward': '₦500',
      'time': '5 mins',
      'participants': '1.2k',
      'icon': Icons.quiz,
      'color': 0xFF4CAF50,
      'difficulty': 'Easy',
      'description': 'Share your opinion on consumer products',
    },
    {
      'title': 'Watch Video - Product Review',
      'category': 'Watch',
      'reward': '₦300',
      'time': '3 mins',
      'participants': '3.4k',
      'icon': Icons.play_circle,
      'color': 0xFF2196F3,
      'difficulty': 'Easy',
      'description': 'Watch and rate product review video',
    },
    {
      'title': 'Play Game - Reach Level 5',
      'category': 'Games',
      'reward': '₦2,000',
      'time': '30 mins',
      'participants': '856',
      'icon': Icons.games,
      'color': 0xFFFF9800,
      'difficulty': 'Medium',
      'description': 'Play and reach level 5 in the game',
    },
    {
      'title': 'App Testing - Beta Version',
      'category': 'Surveys',
      'reward': '₦5,000',
      'time': '45 mins',
      'participants': '234',
      'icon': Icons.apps,
      'color': 0xFF9C27B0,
      'difficulty': 'Hard',
      'description': 'Test new app features and provide feedback',
    },
    {
      'title': 'Daily Check-in Bonus',
      'category': 'Daily',
      'reward': '₦50',
      'time': '30 secs',
      'participants': '5.2k',
      'icon': Icons.calendar_today,
      'color': 0xFFF44336,
      'difficulty': 'Easy',
      'description': 'Claim your daily reward',
    },
    {
      'title': 'Refer a Friend',
      'category': 'Referrals',
      'reward': '₦1,000',
      'time': '2 mins',
      'participants': '2.1k',
      'icon': Icons.share,
      'color': 0xFF00BCD4,
      'difficulty': 'Easy',
      'description': 'Invite friends and earn rewards',
    },
    {
      'title': 'Complete Profile',
      'category': 'Daily',
      'reward': '₦200',
      'time': '5 mins',
      'participants': '4.5k',
      'icon': Icons.person,
      'color': 0xFF795548,
      'difficulty': 'Easy',
      'description': 'Complete your profile information',
    },
    {
      'title': 'Install App - Partner Offer',
      'category': 'Referrals',
      'reward': '₦1,500',
      'time': '10 mins',
      'participants': '567',
      'icon': Icons.download,
      'color': 0xFF607D8B,
      'difficulty': 'Medium',
      'description': 'Install partner app and sign up',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _selectedCategory = 'All';
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredTasks {
    if (_selectedCategory == 'All') {
      return _tasks;
    }
    return _tasks.where((task) => task['category'] == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        backgroundColor: context.surfaceColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: context.textPrimary,
          ),
        ),
        title: Text(
          'Start Task',
          style: context.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: context.textPrimary,
          ),
        ),
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: context.spacingLG),
            decoration: BoxDecoration(
              color: isDark ? context.darkCard : context.lightGray.withOpacity(0.3),
              borderRadius: BorderRadius.circular(context.radiusLG),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: context.accentPurple,
                borderRadius: BorderRadius.circular(context.radiusLG),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: context.textHint,
              tabs: const [
                Tab(text: 'Available Tasks'),
                Tab(text: 'My Tasks'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAvailableTasksTab(context),
          _buildMyTasksTab(context),
        ],
      ),
    );
  }

  Widget _buildAvailableTasksTab(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        // Category Filter
        Container(
          height: 60,
          margin: EdgeInsets.only(top: context.spacingLG),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: context.spacingLG),
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final category = _categories[index];
              final isSelected = _selectedCategory == category['name'];
              final color = Color(category['color'] as int);

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedCategory = category['name'] as String;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.spacingMD,
                    vertical: context.spacingSM,
                  ),
                  margin: EdgeInsets.only(right: context.spacingSM),
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [color, color.withOpacity(0.7)],
                    )
                        : null,
                    color: isSelected ? null : (isDark ? context.darkCard : context.white),
                    borderRadius: BorderRadius.circular(context.radiusXL),
                    border: Border.all(
                      color: isSelected ? color : (isDark ? context.darkTextHint.withOpacity(0.2) : context.lightGray),
                      width: isSelected ? 0 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        category['icon'] as IconData,
                        size: 16,
                        color: isSelected ? Colors.white : color,
                      ),
                      SizedBox(width: context.spacingXS),
                      Text(
                        category['name'] as String,
                        style: context.bodySmall?.copyWith(
                          color: isSelected ? Colors.white : context.textPrimary,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        // Tasks Count
        Padding(
          padding: EdgeInsets.fromLTRB(
            context.spacingLG,
            context.spacingLG,
            context.spacingLG,
            context.spacingSM,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_filteredTasks.length} Tasks Available',
                style: context.bodySmall?.copyWith(
                  color: context.textHint,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: context.spacingSM,
                  vertical: context.spacingXXS,
                ),
                decoration: BoxDecoration(
                  color: context.accentPurple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(context.radiusSM),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.bolt,
                      size: 12,
                      color: context.accentPurple,
                    ),
                    SizedBox(width: 2),
                    Text(
                      'Earn up to ₦15,000',
                      style: context.labelSmall?.copyWith(
                        color: context.accentPurple,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Tasks List
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: context.spacingLG),
            itemCount: _filteredTasks.length,
            itemBuilder: (context, index) {
              final task = _filteredTasks[index];
              return _buildTaskCard(context, task);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMyTasksTab(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Sample active tasks
    final List<Map<String, dynamic>> activeTasks = [
      {
        'title': 'Quick Survey - Consumer Feedback',
        'progress': 0.6,
        'reward': '₦500',
        'timeLeft': '2 days',
        'status': 'In Progress',
      },
      {
        'title': 'Watch Video - Product Review',
        'progress': 0.3,
        'reward': '₦300',
        'timeLeft': '1 day',
        'status': 'In Progress',
      },
    ];

    return ListView.builder(
      padding: EdgeInsets.all(context.spacingLG),
      itemCount: activeTasks.length,
      itemBuilder: (context, index) {
        final task = activeTasks[index];
        return Container(
          margin: EdgeInsets.only(bottom: context.spacingMD),
          padding: EdgeInsets.all(context.spacingMD),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                context.accentPurple.withOpacity(0.1),
                context.accentPurpleDark.withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(context.radiusLG),
            border: Border.all(
              color: context.accentPurple.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      task['title'] as String,
                      style: context.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: context.textPrimary,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.spacingSM,
                      vertical: context.spacingXXS,
                    ),
                    decoration: BoxDecoration(
                      color: context.warning.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(context.radiusSM),
                    ),
                    child: Text(
                      task['status'] as String,
                      style: context.labelSmall?.copyWith(
                        color: context.warning,
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: context.spacingSM),
              LinearProgressIndicator(
                value: task['progress'] as double,
                backgroundColor: isDark ? context.darkCard : context.lightGray,
                color: context.accentPurple,
                borderRadius: BorderRadius.circular(context.radiusSM),
                minHeight: 6,
              ),
              SizedBox(height: context.spacingSM),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.timer,
                        size: 14,
                        color: context.textHint,
                      ),
                      SizedBox(width: 4),
                      Text(
                        '${task['timeLeft']} left',
                        style: context.labelSmall?.copyWith(
                          color: context.textHint,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    task['reward'] as String,
                    style: context.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.accentPurple,
                    ),
                  ),
                ],
              ),
              SizedBox(height: context.spacingSM),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _showContinueTaskDialog(context, task);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.accentPurple,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: context.spacingSM),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(context.radiusMD),
                    ),
                  ),
                  child: Text(
                    'Continue Task',
                    style: context.labelSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTaskCard(BuildContext context, Map<String, dynamic> task) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = Color(task['color'] as int);

    return Container(
      margin: EdgeInsets.only(bottom: context.spacingMD),
      padding: EdgeInsets.all(context.spacingMD),
      decoration: BoxDecoration(
        color: isDark ? context.darkCard : context.white,
        borderRadius: BorderRadius.circular(context.radiusLG),
        border: Border.all(
          color: isDark ? context.darkTextHint.withOpacity(0.2) : context.lightGray,
        ),
        boxShadow: isDark ? null : context.shadowSM,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color.withOpacity(0.2), color.withOpacity(0.1)],
                  ),
                  borderRadius: BorderRadius.circular(context.radiusMD),
                ),
                child: Icon(
                  task['icon'] as IconData,
                  color: color,
                  size: 28,
                ),
              ),
              SizedBox(width: context.spacingMD),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task['title'] as String,
                      style: context.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: context.textPrimary,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      task['description'] as String,
                      style: context.labelSmall?.copyWith(
                        color: context.textHint,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: context.spacingSM,
                  vertical: context.spacingXXS,
                ),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(context.radiusSM),
                ),
                child: Text(
                  task['difficulty'] as String,
                  style: context.labelSmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: context.spacingMD),
          Row(
            children: [
              _buildTaskStat(
                context,
                icon: Icons.timer,
                value: task['time'] as String,
              ),
              SizedBox(width: context.spacingMD),
              _buildTaskStat(
                context,
                icon: Icons.people,
                value: '${task['participants']} done',
              ),
              const Spacer(),
              Text(
                task['reward'] as String,
                style: context.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: context.spacingMD),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                _showStartTaskDialog(context, task);
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: color),
                padding: EdgeInsets.symmetric(vertical: context.spacingSM),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(context.radiusMD),
                ),
              ),
              child: Text(
                'Start Task',
                style: context.labelSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskStat(BuildContext context, {required IconData icon, required String value}) {
    return Row(
      children: [
        Icon(
          icon,
          size: 12,
          color: context.textHint,
        ),
        SizedBox(width: 4),
        Text(
          value,
          style: context.labelSmall?.copyWith(
            color: context.textHint,
          ),
        ),
      ],
    );
  }

  void _showStartTaskDialog(BuildContext context, Map<String, dynamic> task) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = Color(task['color'] as int);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: context.surfaceColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.radiusLG),
        ),
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.all(context.spacingSM),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                task['icon'] as IconData,
                color: color,
                size: 24,
              ),
            ),
            SizedBox(width: context.spacingSM),
            Expanded(
              child: Text(
                task['title'] as String,
                style: context.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task['description'] as String,
              style: context.bodyMedium,
            ),
            SizedBox(height: context.spacingMD),
            Container(
              padding: EdgeInsets.all(context.spacingMD),
              decoration: BoxDecoration(
                color: isDark ? context.darkCard : context.lightGray.withOpacity(0.3),
                borderRadius: BorderRadius.circular(context.radiusMD),
              ),
              child: Column(
                children: [
                  _buildTaskDetailRow(
                    context,
                    icon: Icons.timer,
                    label: 'Estimated Time',
                    value: task['time'] as String,
                  ),
                  _buildTaskDetailRow(
                    context,
                    icon: Icons.emoji_events,
                    label: 'Reward',
                    value: task['reward'] as String,
                    valueColor: color,
                  ),
                  _buildTaskDetailRow(
                    context,
                    icon: Icons.people,
                    label: 'Participants',
                    value: '${task['participants']} users',
                  ),
                  _buildTaskDetailRow(
                    context,
                    icon: Icons.star,
                    label: 'Difficulty',
                    value: task['difficulty'] as String,
                    valueColor: color,
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: context.textHint,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showTaskStartedDialog(context, task);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              foregroundColor: Colors.white,
            ),
            child: const Text('Start Now'),
          ),
        ],
      ),
    );
  }

  void _showContinueTaskDialog(BuildContext context, Map<String, dynamic> task) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: context.surfaceColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.radiusLG),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(context.spacingLG),
              decoration: BoxDecoration(
                color: context.warning.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.play_circle,
                color: context.warning,
                size: 48,
              ),
            ),
            SizedBox(height: context.spacingLG),
            Text(
              'Continue Task?',
              style: context.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: context.spacingSM),
            Text(
              'You have already started this task. Continue where you left off?',
              textAlign: TextAlign.center,
              style: context.bodyMedium,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: context.textHint,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showTaskContinuedDialog(context, task);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: context.accentPurple,
              foregroundColor: Colors.white,
            ),
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }

  void _showTaskStartedDialog(BuildContext context, Map<String, dynamic> task) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: context.surfaceColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.radiusLG),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(context.spacingLG),
              decoration: BoxDecoration(
                color: context.success.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle,
                color: context.success,
                size: 64,
              ),
            ),
            SizedBox(height: context.spacingLG),
            Text(
              'Task Started!',
              style: context.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.textPrimary,
              ),
            ),
            SizedBox(height: context.spacingSM),
            Text(
              'Good luck! Complete the task to earn ${task['reward']}',
              textAlign: TextAlign.center,
              style: context.bodyMedium?.copyWith(
                color: context.textSecondary,
              ),
            ),
          ],
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: context.accentPurple,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: context.spacingMD),
              ),
              child: const Text('Continue'),
            ),
          ),
        ],
      ),
    );
  }

  void _showTaskContinuedDialog(BuildContext context, Map<String, dynamic> task) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: context.surfaceColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.radiusLG),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(context.spacingLG),
              decoration: BoxDecoration(
                color: context.info.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.play_arrow,
                color: context.info,
                size: 48,
              ),
            ),
            SizedBox(height: context.spacingLG),
            Text(
              'Resuming Task',
              style: context.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: context.spacingSM),
            Text(
              'Continue where you left off',
              textAlign: TextAlign.center,
              style: context.bodyMedium,
            ),
          ],
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: context.accentPurple,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: context.spacingMD),
              ),
              child: const Text('Continue'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskDetailRow(
      BuildContext context, {
        required IconData icon,
        required String label,
        required String value,
        Color? valueColor,
      }) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.spacingSM),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: context.textHint,
          ),
          SizedBox(width: context.spacingSM),
          Expanded(
            child: Text(
              label,
              style: context.bodySmall?.copyWith(
                color: context.textHint,
              ),
            ),
          ),
          Text(
            value,
            style: context.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: valueColor ?? context.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}