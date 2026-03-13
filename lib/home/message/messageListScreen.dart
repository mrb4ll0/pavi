import 'package:flutter/material.dart';
import 'package:pavi/home/message/widget/chat_tile.dart';
import 'package:pavi/theme/generalTheme.dart';
import '../../model/messageModel.dart';
import 'message_details_screen.dart';

class MessageListScreen extends StatefulWidget {
  const MessageListScreen({super.key});

  @override
  State<MessageListScreen> createState() => _MessageListScreenState();
}

class _MessageListScreenState extends State<MessageListScreen> {
  final List<ChatPreview> _chats = [
    ChatPreview(
      id: '1',
      name: 'Mum',
      avatar: 'M',
      lastMessage: 'Okay dear, call me when you\'re free 🤗',
      time: '10:30 AM',
      unreadCount: 2,
      isOnline: true,
      messageType: MessageType.text,
    ),
    ChatPreview(
      id: '2',
      name: 'John Smith',
      avatar: 'J',
      lastMessage: '🎤 Voice message',
      time: 'Yesterday',
      unreadCount: 0,
      isOnline: false,
      messageType: MessageType.voice,
    ),
    ChatPreview(
      id: '3',
      name: 'Sarah Johnson',
      avatar: 'S',
      lastMessage: '😊 Thanks for the help!',
      time: 'Yesterday',
      unreadCount: 0,
      isOnline: true,
      messageType: MessageType.text,
    ),
    ChatPreview(
      id: '4',
      name: 'Business Client',
      avatar: 'B',
      lastMessage: '📎 Meeting notes.pdf',
      time: 'Monday',
      unreadCount: 1,
      isOnline: false,
      messageType: MessageType.file,
    ),
    ChatPreview(
      id: '5',
      name: 'Team Group',
      avatar: 'T',
      lastMessage: 'Alex: Great work everyone! 🎉',
      time: 'Sunday',
      unreadCount: 5,
      isOnline: true,
      messageType: MessageType.text,
      isGroup: true,
    ),
  ];

  final List<Map<String, String>> _onlineContacts = [
    {'initial': 'M', 'name': 'Mum'},
    {'initial': 'J', 'name': 'John'},
    {'initial': 'S', 'name': 'Sarah'},
    {'initial': 'B', 'name': 'Biz'},
    {'initial': 'A', 'name': 'Dr.A'},
    {'initial': 'T', 'name': 'Team'},
    {'initial': 'R', 'name': 'Ruth'},
    {'initial': 'K', 'name': 'Ken'},
  ];

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
          'Messages',
          style: context.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: context.textPrimary,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: context.textPrimary),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: context.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          _buildOnlineContacts(context),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(context.spacingMD),
              itemCount: _chats.length,
              itemBuilder: (context, index) {
                final chat = _chats[index];
                return ChatTile(
                  chat: chat,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MessageDetailScreen(chat: chat),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: isDark ? context.accentPurple : context.primaryColor,
        child: Icon(Icons.edit, color: context.white),
      ),
    );
  }

  Widget _buildOnlineContacts(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 100,
      color: isDark ? context.darkSurface : context.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(
          horizontal: context.spacingMD,
          vertical: context.spacingSM,
        ),
        itemCount: _onlineContacts.length,
        itemBuilder: (context, index) {
          final contact = _onlineContacts[index];
          return Container(
            width: 70,
            margin: EdgeInsets.only(right: context.spacingSM),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: isDark
                            ? LinearGradient(
                          colors: [context.accentPurple, context.accentPurpleDark],
                        )
                            : context.primaryGradient,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          contact['initial']!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 2,
                      right: 2,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: context.success,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isDark ? context.darkBackground : context.white,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.spacingXS),
                Text(
                  contact['name']!,
                  style: context.labelSmall?.copyWith(
                    fontSize: 11,
                    color: context.textSecondary,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}