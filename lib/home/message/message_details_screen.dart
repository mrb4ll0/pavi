import 'package:flutter/material.dart';
import 'package:pavi/home/message/widget/message_bubble.dart';
import 'package:pavi/home/message/widget/tempEmoji.dart';
import 'package:pavi/theme/generalTheme.dart';
import '../../model/messageModel.dart';
import '../dialer/call_screen.dart';

class MessageDetailScreen extends StatefulWidget {
  final ChatPreview chat;

  const MessageDetailScreen({super.key, required this.chat});

  @override
  State<MessageDetailScreen> createState() => _MessageDetailScreenState();
}

class _MessageDetailScreenState extends State<MessageDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  bool _isRecording = false;
  bool _showEmojiPicker = false;

  final List<Message> _messages = [
    Message(
      id: '1',
      text: 'Hey, how are you doing?',
      isMe: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
      status: MessageStatus.read,
      senderName: 'Mum',
    ),
    Message(
      id: '2',
      text: 'I\'m good, thanks! How about you? 😊',
      isMe: true,
      timestamp: DateTime.now().subtract(const Duration(minutes: 29)),
      status: MessageStatus.read,
    ),
    Message(
      id: '3',
      text: 'Just finished the meeting. Call you later?',
      isMe: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 28)),
      status: MessageStatus.read,
      senderName: 'Mum',
    ),
    Message(
      id: '4',
      text: 'Sure! That sounds great 👍',
      isMe: true,
      timestamp: DateTime.now().subtract(const Duration(minutes: 27)),
      status: MessageStatus.read,
    ),
    VoiceMessage(
      id: '5',
      text: 'Voice message',
      isMe: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 25)),
      audioUrl: 'audio.mp3',
      duration: 45,
      status: MessageStatus.delivered,
      senderName: 'Mum',
    ),
    FileMessage(
      id: '6',
      text: 'Document.pdf',
      isMe: true,
      timestamp: DateTime.now().subtract(const Duration(minutes: 24)),
      fileUrl: 'file.pdf',
      fileType: 'pdf',
      fileSize: '2.4 MB',
      status: MessageStatus.sent,
    ),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add(
        Message(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: _messageController.text,
          isMe: true,
          timestamp: DateTime.now(),
          status: MessageStatus.sent,
        ),
      );
      _messageController.clear();
    });

    _scrollToBottom();
  }

  void _startVoiceRecording() {
    setState(() {
      _isRecording = !_isRecording;
    });

    if (_isRecording) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Recording started...'),
          backgroundColor: context.success,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _makeCall() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CallScreen(
          contactName: widget.chat.name,
          phoneNumber: '+234 801 234 5678',
          callType: CallType.appToApp,
        ),
      ),
    );
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
          icon: Icon(Icons.arrow_back, color: context.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: _buildAppBarTitle(context),
        actions: [
          IconButton(
            icon: Icon(
              Icons.phone,
              color: isDark ? context.accentPurple : context.primaryColor,
            ),
            onPressed: _makeCall,
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: context.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(context.spacingMD),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final showAvatar = index == 0 ||
                    _messages[index - 1].isMe != message.isMe;

                return MessageBubble(
                  message: message,
                  senderAvatar: widget.chat.avatar,
                  showAvatar: showAvatar && !message.isMe,
                );
              },
            ),
          ),

          if (_showEmojiPicker)
            EmojiPicker(
              onEmojiSelected: (emoji) {
                _messageController.text += emoji;
                setState(() {
                  _showEmojiPicker = false;
                });
                _focusNode.requestFocus();
              },
              onClose: () {
                setState(() {
                  _showEmojiPicker = false;
                });
              },
            ),

          _buildInputBar(context),
        ],
      ),
    );
  }

  Widget _buildAppBarTitle(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        Stack(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: widget.chat.isGroup
                    ? LinearGradient(
                  colors: isDark
                      ? [context.accentPurple, context.accentPurpleDark]
                      : [context.warning, context.warning.withOpacity(0.8)],
                )
                    : (isDark
                    ? LinearGradient(
                  colors: [context.accentPurple, context.accentPurpleDark],
                )
                    : context.primaryGradient),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: widget.chat.isGroup
                    ? Icon(Icons.group, color: context.white, size: 20)
                    : Text(
                  widget.chat.avatar,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            if (widget.chat.isOnline)
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 10,
                  height: 10,
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
        SizedBox(width: context.spacingSM),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.chat.name,
                style: context.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.textPrimary,
                ),
              ),
              Text(
                widget.chat.isOnline ? 'Online' : 'Offline',
                style: context.labelSmall?.copyWith(
                  color: widget.chat.isOnline ? context.success : context.textHint,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInputBar(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(context.spacingSM),
      decoration: BoxDecoration(
        color: isDark ? context.darkCard : context.white,
        boxShadow: isDark ? null : [
          BoxShadow(
            color: context.textPrimary.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.emoji_emotions_outlined,
              color: context.warning,
            ),
            onPressed: () {
              setState(() {
                _showEmojiPicker = !_showEmojiPicker;
              });
              if (_showEmojiPicker) {
                _focusNode.unfocus();
              } else {
                _focusNode.requestFocus();
              }
            },
          ),

          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: context.spacingMD),
              decoration: BoxDecoration(
                color: isDark ? context.darkSurface : context.offWhite,
                borderRadius: BorderRadius.circular(context.radiusXL),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      focusNode: _focusNode,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        hintStyle: context.bodyMedium?.copyWith(
                          color: context.textHint,
                        ),
                        border: InputBorder.none,
                      ),
                      style: context.bodyMedium?.copyWith(
                        color: context.textPrimary,
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.attach_file,
                      color: context.textHint,
                      size: 22,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),

          GestureDetector(
            onLongPress: _startVoiceRecording,
            onLongPressUp: () {
              setState(() {
                _isRecording = false;
              });
            },
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                gradient: _isRecording
                    ? LinearGradient(
                  colors: [context.error, context.error.withOpacity(0.8)],
                )
                    : (isDark
                    ? LinearGradient(
                  colors: [context.accentPurple, context.accentPurpleDark],
                )
                    : context.primaryGradient),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _messageController.text.isEmpty ? Icons.mic : Icons.send,
                color: context.white,
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}