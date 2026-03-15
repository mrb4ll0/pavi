import 'package:flutter/material.dart';
import 'package:pavi/theme/generalTheme.dart';
import '../../../model/messageModel.dart';
import '../message_details_screen.dart';
import 'earn_task_dialog.dart';

class GroupRoomsScreen extends StatefulWidget {
  final Function(int) onCoinsEarned;

  const GroupRoomsScreen({
    Key? key,
    required this.onCoinsEarned,
  }) : super(key: key);

  @override
  State<GroupRoomsScreen> createState() => _GroupRoomsScreenState();
}

class _GroupRoomsScreenState extends State<GroupRoomsScreen> with SingleTickerProviderStateMixin {
  late TabController _categoryTabController;

  final List<Map<String, dynamic>> _featuredRooms = [
    {
      'id': 'room1',
      'name': 'Lagos Students',
      'avatar': 'L',
      'members': 1234,
      'description': 'Connect with fellow students in Lagos',
      'activeNow': 89,
      'bonus': true,
      'bonusAmount': 15,
      'category': 'Education',
      'tags': ['students', 'nigeria', 'campus'],
    },
    {
      'id': 'room2',
      'name': 'Tech Gist',
      'avatar': 'T',
      'members': 2567,
      'description': 'Latest tech trends, AI, and programming',
      'activeNow': 234,
      'bonus': true,
      'bonusAmount': 20,
      'category': 'Technology',
      'tags': ['tech', 'coding', 'ai'],
    },
    {
      'id': 'room3',
      'name': 'Campus Life',
      'avatar': 'C',
      'members': 892,
      'description': 'Share your campus experiences',
      'activeNow': 45,
      'bonus': false,
      'category': 'Lifestyle',
      'tags': ['campus', 'students', 'life'],
    },
    {
      'id': 'room4',
      'name': 'Freelance Hub',
      'avatar': 'F',
      'members': 1567,
      'description': 'Tips and jobs for freelancers',
      'activeNow': 112,
      'bonus': true,
      'bonusAmount': 25,
      'category': 'Business',
      'tags': ['freelance', 'work', 'jobs'],
    },
  ];

  final List<Map<String, dynamic>> _myRooms = [
    {
      'id': 'room1',
      'name': 'Lagos Students',
      'avatar': 'L',
      'unreadCount': 12,
      'lastActive': '2 mins ago',
    },
    {
      'id': 'room2',
      'name': 'Tech Gist',
      'avatar': 'T',
      'unreadCount': 5,
      'lastActive': '1 hour ago',
    },
  ];

  final List<String> _categories = [
    'All',
    'Education',
    'Technology',
    'Business',
    'Lifestyle',
    'Entertainment',
  ];

  String _selectedCategory = 'All';
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _categoryTabController = TabController(length: _categories.length, vsync: this);
  }

  @override
  void dispose() {
    _categoryTabController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredRooms {
    return _featuredRooms.where((room) {
      // Category filter
      if (_selectedCategory != 'All' && room['category'] != _selectedCategory) {
        return false;
      }

      // Search filter
      if (_searchQuery.isNotEmpty) {
        final name = room['name'].toString().toLowerCase();
        final desc = room['description'].toString().toLowerCase();
        final query = _searchQuery.toLowerCase();
        return name.contains(query) || desc.contains(query);
      }

      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: context.backgroundColor,
      body: CustomScrollView(
        slivers: [
          // Search Bar
          SliverPadding(
            padding: EdgeInsets.all(context.spacingMD),
            sliver: SliverToBoxAdapter(
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withOpacity(0.1)
                      : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search rooms...',
                    hintStyle: TextStyle(
                      color: context.textSecondary,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: context.textSecondary,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                  style: TextStyle(
                    color: context.textPrimary,
                  ),
                ),
              ),
            ),
          ),

          // Categories Tab Bar
          SliverToBoxAdapter(
            child: Container(
              height: 40,
              margin: EdgeInsets.only(bottom: context.spacingMD),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: context.spacingMD),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  final isSelected = _selectedCategory == category;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: context.spacingSM),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        gradient: isSelected
                            ? LinearGradient(
                          colors: [
                            context.primaryColor,
                            context.accentPurple,
                          ],
                        )
                            : null,
                        color: isSelected
                            ? null
                            : (isDark
                            ? Colors.white.withOpacity(0.1)
                            : Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : context.textSecondary,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // My Rooms Section (if any)
          if (_myRooms.isNotEmpty) ...[
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.spacingMD,
                  vertical: context.spacingSM,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'My Rooms',
                      style: context.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.textPrimary,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('See All'),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: context.spacingMD),
              sliver: SliverToBoxAdapter(
                child: SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _myRooms.length,
                    itemBuilder: (context, index) {
                      final room = _myRooms[index];
                      return _buildMyRoomCard(context, room);
                    },
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: context.spacingMD),
            ),
          ],

          // Featured/Bonus Rooms Section
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.spacingMD),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.stars,
                        color: Colors.amber,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Featured Rooms',
                        style: context.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.textPrimary,
                        ),
                      ),
                    ],
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
                      children: const [
                        Icon(
                          Icons.monetization_on,
                          color: Colors.amber,
                          size: 14,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Earn bonus coins',
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Rooms Grid
          SliverPadding(
            padding: EdgeInsets.all(context.spacingMD),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.85,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final room = _filteredRooms[index];
                  return _buildRoomCard(context, room);
                },
                childCount: _filteredRooms.length,
              ),
            ),
          ),

          // Create Room Button (at bottom)
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.all(context.spacingMD),
              child: OutlinedButton.icon(
                onPressed: () {
                  _showCreateRoomDialog(context);
                },
                icon: const Icon(Icons.add),
                label: const Text('Create New Room'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: context.primaryColor,
                  side: BorderSide(color: context.primaryColor),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMyRoomCard(BuildContext context, Map<String, dynamic> room) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        _navigateToRoom(context, room);
      },
      child: Container(
        width: 160,
        margin: EdgeInsets.only(right: context.spacingSM),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
              const Color(0xFF2A2A2A),
              const Color(0xFF1E1E1E),
            ]
                : [
              Colors.white,
              Colors.grey.shade50,
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark
                ? Colors.white.withOpacity(0.1)
                : Colors.grey.shade200,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          context.primaryColor,
                          context.accentPurple,
                        ],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        room['avatar'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  if (room['unreadCount'] > 0)
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        room['unreadCount'].toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                room['name'],
                style: context.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.textPrimary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                room['lastActive'],
                style: context.labelSmall?.copyWith(
                  color: context.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoomCard(BuildContext context, Map<String, dynamic> room) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        _navigateToRoom(context, room);
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: room['bonus'] as bool
                ? isDark
                ? [
              const Color(0xFF2A2A2A),
              Colors.amber.withOpacity(0.1),
            ]
                : [
              Colors.white,
              Colors.amber.shade50,
            ]
                : isDark
                ? [
              const Color(0xFF2A2A2A),
              const Color(0xFF1E1E1E),
            ]
                : [
              Colors.white,
              Colors.grey.shade50,
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            if (room['bonus'] as bool)
              BoxShadow(
                color: Colors.amber.withOpacity(0.2),
                blurRadius: 12,
                spreadRadius: 2,
              ),
          ],
          border: Border.all(
            color: room['bonus'] as bool
                ? Colors.amber.withOpacity(0.3)
                : (isDark
                ? Colors.white.withOpacity(0.1)
                : Colors.grey.shade200),
          ),
        ),
        child: Stack(
          children: [
            // Bonus Badge
            if (room['bonus'] as bool)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.amber.withOpacity(0.5),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.monetization_on,
                    color: Colors.white,
                    size: 14,
                  ),
                ),
              ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar
                  Center(
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: room['bonus'] as bool
                              ? [Colors.amber, Colors.orange]
                              : [context.primaryColor, context.accentPurple],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          room['avatar'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Room Name and Bonus Amount
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          room['name'],
                          style: context.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (room['bonus'] as bool)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.amber.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '+${room['bonusAmount']}',
                            style: const TextStyle(
                              color: Colors.amber,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  // Description
                  Text(
                    room['description'],
                    style: context.bodySmall?.copyWith(
                      color: context.textSecondary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 8),

                  // Members and Active Now
                  Row(
                    children: [
                      Icon(
                        Icons.people,
                        size: 14,
                        color: context.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _formatNumber(room['members']),
                        style: context.labelSmall?.copyWith(
                          color: context.textSecondary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${room['activeNow']} active',
                        style: context.labelSmall?.copyWith(
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Tags
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: (room['tags'] as List<String>).take(2).map((tag) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colors.white.withOpacity(0.1)
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '#$tag',
                          style: context.labelSmall?.copyWith(
                            color: context.textSecondary,
                            fontSize: 9,
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const Spacer(),

                  // Join Button
                  Container(
                    width: double.infinity,
                    height: 32,
                    decoration: BoxDecoration(
                      gradient: room['bonus'] as bool
                          ? LinearGradient(
                        colors: [
                          Colors.amber,
                          Colors.orange,
                        ],
                      )
                          : LinearGradient(
                        colors: [
                          context.primaryColor,
                          context.accentPurple,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          _navigateToRoom(context, room);
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: Center(
                          child: Text(
                            room['bonus'] as bool ? 'Join & Earn' : 'Join',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
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

  void _navigateToRoom(BuildContext context, Map<String, dynamic> room) {
    // Convert room to ChatPreview for MessageDetailScreen
    final chatPreview = ChatPreview(
      id: room['id'] as String,
      name: room['name'] as String,
      avatar: room['avatar'] as String,
      lastMessage: room['description'] as String,
      time: '',
      unreadCount: 0,
      isOnline: true,
      messageType: MessageType.text,
      isGroup: true,
      isRoom: true,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MessageDetailScreen(
          chat: chatPreview,
          onEarnButtonPressed: room['bonus'] as bool
              ? () {
            showEarnTaskDialog(
              context: context,
              baseReward: room['bonusAmount'],
              onTaskComplete: (coins) {
                widget.onCoinsEarned(coins);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('You earned $coins coins! 🎉'),
                    backgroundColor: Colors.green,
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
            );
          }
              : null,
        ),
      ),
    );
  }

  void _showCreateRoomDialog(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final nameController = TextEditingController();
    final descController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text('Create New Room'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Room Name',
                hintText: 'e.g., Tech Enthusiasts',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Description',
                hintText: 'What\'s this room about?',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: 'Public',
              decoration: InputDecoration(
                labelText: 'Privacy',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              items: ['Public', 'Private'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
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
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Room created successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: context.primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}k';
    }
    return number.toString();
  }
}