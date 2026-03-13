import 'package:flutter/material.dart';
import 'package:pavi/theme/generalTheme.dart';

class FileMessageWidget extends StatelessWidget {
  final String fileName;
  final String fileSize;
  final bool isMe;
  final VoidCallback? onTap;

  const FileMessageWidget({
    super.key,
    required this.fileName,
    required this.fileSize,
    required this.isMe,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            Icons.insert_drive_file,
            size: 24,
            color: isMe
                ? context.white
                : (isDark ? context.accentPurple : context.primaryColor),
          ),
          SizedBox(width: context.spacingSM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileName,
                  style: context.bodySmall?.copyWith(
                    color: isMe
                        ? context.white
                        : context.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  fileSize,
                  style: context.labelSmall?.copyWith(
                    color: isMe
                        ? context.white.withOpacity(0.7)
                        : context.textHint,
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}