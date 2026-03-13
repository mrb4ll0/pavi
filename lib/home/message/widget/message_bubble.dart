import 'package:flutter/material.dart';
import 'package:pavi/theme/generalTheme.dart';
import '../../../model/messageModel.dart';
import 'voice_message.dart';
import 'file_message.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  final String senderAvatar;
  final bool showAvatar;

  const MessageBubble({
    super.key,
    required this.message,
    required this.senderAvatar,
    this.showAvatar = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMe = message.isMe;

    return Container(
      margin: EdgeInsets.only(
        top: context.spacingSM,
        bottom: context.spacingXS,
        left: isMe ? context.spacingXL : 0,
        right: isMe ? 0 : context.spacingXL,
      ),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe && showAvatar) _buildAvatar(context),
          if (!isMe && !showAvatar) SizedBox(width: 30 + context.spacingXS),
          Flexible(
            child: Container(
              padding: EdgeInsets.all(context.spacingSM),
              decoration: BoxDecoration(
                color: isMe
                    ? (isDark ? context.accentPurple : context.primaryColor)
                    : (isDark ? context.darkCard : context.white),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(context.radiusMD),
                  topRight: Radius.circular(context.radiusMD),
                  bottomLeft: Radius.circular(
                    isMe ? context.radiusMD : context.radiusXS,
                  ),
                  bottomRight: Radius.circular(
                    isMe ? context.radiusXS : context.radiusMD,
                  ),
                ),
                boxShadow: isDark ? null : context.shadowSM,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isMe && message.senderName != null)
                    Padding(
                      padding: EdgeInsets.only(bottom: context.spacingXXS),
                      child: Text(
                        message.senderName!,
                        style: context.labelSmall?.copyWith(
                          color: isDark ? context.accentPurple : context.primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  _buildMessageContent(context),
                  SizedBox(height: context.spacingXXS),
                  _buildTimeAndStatus(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 30,
      height: 30,
      margin: EdgeInsets.only(right: context.spacingXS),
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
          senderAvatar,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildMessageContent(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (message.isVoice) {
      return VoiceMessageWidget(
        duration: message.voiceDuration ?? '0:00',
        isMe: message.isMe,
      );
    } else if (message.isFile) {
      return FileMessageWidget(
        fileName: message.fileName ?? message.text,
        fileSize: message.fileSize ?? '0 MB',
        isMe: message.isMe,
      );
    } else {
      return Text(
        message.text,
        style: context.bodyMedium?.copyWith(
          color: message.isMe
              ? context.white
              : context.textPrimary,
        ),
      );
    }
  }

  Widget _buildTimeAndStatus(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          message.formattedTime,
          style: context.labelSmall?.copyWith(
            color: message.isMe
                ? context.white.withOpacity(0.7)
                : context.textHint,
            fontSize: 9,
          ),
        ),
        if (message.isMe) ...[
          SizedBox(width: context.spacingXXS),
          _buildStatusIcon(context),
        ],
      ],
    );
  }

  Widget _buildStatusIcon(BuildContext context) {
    IconData icon;
    Color color;

    switch (message.status) {
      case MessageStatus.sent:
        icon = Icons.check;
        color = context.white.withOpacity(0.7);
        break;
      case MessageStatus.delivered:
        icon = Icons.done_all;
        color = context.white.withOpacity(0.7);
        break;
      case MessageStatus.read:
        icon = Icons.done_all;
        color = context.success;
        break;
    }

    return Icon(icon, size: 12, color: color);
  }
}