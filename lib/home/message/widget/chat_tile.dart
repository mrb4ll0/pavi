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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(context.spacingMD),
        margin: EdgeInsets.only(bottom: context.spacingSM),
        decoration: BoxDecoration(
          color: isDark ? context.darkCard : context.white,
          borderRadius: BorderRadius.circular(context.radiusMD),
          boxShadow: isDark ? null : context.shadowSM,
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            gradient: chat.isGroup
                ? LinearGradient(
              colors: isDark
                  ? [context.accentPurple.withOpacity(0.8), context.accentPurpleDark]
                  : [context.warning, context.warning.withOpacity(0.8)],
            )
                : context.primaryGradient,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: chat.isGroup
                ? Icon(Icons.group, color: context.white, size: 28)
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
                border: Border.all(
                  color: isDark ? context.darkBackground : context.white,
                  width: 2,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildChatDetails(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
                    color: context.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                chat.time,
                style: context.labelSmall?.copyWith(
                  color: context.textHint,
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
                    color: chat.unreadCount > 0
                        ? context.textPrimary
                        : context.textHint,
                    fontWeight: chat.unreadCount > 0
                        ? FontWeight.w600
                        : FontWeight.normal,
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    switch (chat.messageType) {
      case MessageType.voice:
        return Icon(
          Icons.mic,
          size: 14,
          color: isDark ? context.accentPurple : context.primaryColor,
        );
      case MessageType.file:
        return Icon(
          Icons.attach_file,
          size: 14,
          color: context.warning,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildUnreadBadge(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(context.spacingXXS),
      constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
      decoration: BoxDecoration(
        color: isDark ? context.accentPurple : context.primaryColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          chat.unreadCount.toString(),
          style: context.labelSmall?.copyWith(
            color: context.white,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}