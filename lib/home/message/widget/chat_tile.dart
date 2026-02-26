import 'package:flutter/material.dart';
import 'package:pavi/theme/generalTheme.dart';

import '../../../model/messageModel.dart';


class ChatTile extends StatelessWidget {
  final ChatPreview chat;
  final VoidCallback onTap;
  

  const ChatTile({
    super.key,
    required this.chat,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(context.spacingMD),
        margin: EdgeInsets.only(bottom: context.spacingSM),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(context.radiusMD),
          boxShadow: context.shadowSM,
        ),
        child: Row(
          children: [
            _buildAvatar(context),
            SizedBox(width: context.spacingMD),
            _buildChatDetails(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            gradient: chat.isGroup
                ? LinearGradient(
              colors: [context.actionAmber, context.actionAmberDark],
            )
                : context.primaryGradient,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: chat.isGroup
                ? Icon(Icons.group, color: Colors.white, size: 28)
                : Text(
              chat.avatar,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 22,
              ),
            ),
          ),
        ),
        if (chat.isOnline)
          Positioned(
            bottom: 2,
            right: 2,
            child: Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: context.success,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildChatDetails(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  chat.name,
                  style: context.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                chat.time,
                style: context.labelSmall?.copyWith(
                  color: context.mediumGray,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          SizedBox(height: context.spacingXS),
          Row(
            children: [
              _buildMessageTypeIcon(context),
              if (chat.messageType != MessageType.text)
                SizedBox(width: context.spacingXXS),
              Expanded(
                child: Text(
                  chat.lastMessage,
                  style: context.bodySmall?.copyWith(
                    color: chat.unreadCount > 0 ? context.deepNavy : context.mediumGray,
                    fontWeight: chat.unreadCount > 0 ? FontWeight.w600 : FontWeight.normal,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (chat.unreadCount > 0) _buildUnreadBadge(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMessageTypeIcon(BuildContext context) {
    switch (chat.messageType) {
      case MessageType.voice:
        return Icon(
          Icons.mic,
          size: 14,
          color: context.primaryGreen,
        );
      case MessageType.file:
        return Icon(
          Icons.attach_file,
          size: 14,
          color: context.actionAmber,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildUnreadBadge(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.spacingXXS),
      constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
      decoration: BoxDecoration(
        color: context.primaryGreen,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          chat.unreadCount.toString(),
          style: context.labelSmall?.copyWith(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}