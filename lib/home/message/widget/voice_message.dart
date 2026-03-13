import 'package:flutter/material.dart';
import 'package:pavi/theme/generalTheme.dart';

class VoiceMessageWidget extends StatefulWidget {
  final String duration;
  final bool isMe;
  final double progress; // 0.0 to 1.0

  const VoiceMessageWidget({
    super.key,
    required this.duration,
    required this.isMe,
    this.progress = 0.6,
  });

  @override
  State<VoiceMessageWidget> createState() => _VoiceMessageWidgetState();
}

class _VoiceMessageWidgetState extends State<VoiceMessageWidget> {
  bool _isPlaying = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isPlaying = !_isPlaying;
            });
          },
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: (widget.isMe
                  ? context.white
                  : (isDark ? context.accentPurple : context.primaryColor)
              ).withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _isPlaying ? Icons.pause : Icons.play_arrow,
              size: 16,
              color: widget.isMe
                  ? context.white
                  : (isDark ? context.accentPurple : context.primaryColor),
            ),
          ),
        ),
        SizedBox(width: context.spacingSM),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 120,
              height: 4,
              decoration: BoxDecoration(
                color: (widget.isMe
                    ? context.white
                    : context.textHint
                ).withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: widget.progress,
                child: Container(
                  decoration: BoxDecoration(
                    color: widget.isMe
                        ? context.white
                        : (isDark ? context.accentPurple : context.primaryColor),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
            SizedBox(height: context.spacingXXS),
            Text(
              widget.duration,
              style: context.labelSmall?.copyWith(
                color: widget.isMe
                    ? context.white.withOpacity(0.7)
                    : context.textHint,
                fontSize: 9,
              ),
            ),
          ],
        ),
      ],
    );
  }
}