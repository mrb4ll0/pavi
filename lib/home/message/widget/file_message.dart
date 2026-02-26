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
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            Icons.insert_drive_file,
            size: 24,
            color: isMe ? Colors.white : context.actionAmber,
          ),
          SizedBox(width: context.spacingSM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileName,
                  style: context.bodySmall?.copyWith(
                    color: isMe ? Colors.white : context.deepNavy,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  fileSize,
                  style: context.labelSmall?.copyWith(
                    color: isMe ? Colors.white70 : context.mediumGray,
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