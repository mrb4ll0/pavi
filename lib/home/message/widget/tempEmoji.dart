import 'package:flutter/material.dart';
import 'package:pavi/theme/generalTheme.dart';


class EmojiPicker extends StatelessWidget {
  final Function(String) onEmojiSelected;
  final VoidCallback onClose;


  const EmojiPicker({
    super.key,
    required this.onEmojiSelected,
    required this.onClose,
  });

  static const List<String> _emojis = [
    '😊', '😂', '🥰', '😍', '🤔', '😢', '😡', '👍', '👎',
    '👋', '🙏', '🔥', '✨', '⭐', '❤️', '💔', '💯', '✅',
    '🎉', '🎂', '🎈', '💪', '🤞', '👀', '👏', '🤝', '🙌',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(context.spacingSM),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: context.lightGray),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Emojis',
                  style: context.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, size: 18, color: context.mediumGray),
                  onPressed: onClose,
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(context.spacingSM),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                childAspectRatio: 1,
              ),
              itemCount: _emojis.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => onEmojiSelected(_emojis[index]),
                  child: Container(
                    margin: EdgeInsets.all(context.spacingXXS),
                    decoration: BoxDecoration(
                      color: context.offWhite,
                      borderRadius: BorderRadius.circular(context.radiusSM),
                    ),
                    child: Center(
                      child: Text(
                        _emojis[index],
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}