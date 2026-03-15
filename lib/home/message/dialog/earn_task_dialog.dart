import 'package:flutter/material.dart';
import 'package:pavi/theme/generalTheme.dart';

class EarnTaskDialog extends StatefulWidget {
  final Function(int coinsEarned) onTaskComplete;
  final int? baseReward;
  final String? customQuestion;
  final List<String>? customOptions;
  final String? customCorrectAnswer;

  const EarnTaskDialog({
    Key? key,
    required this.onTaskComplete,
    this.baseReward,
    this.customQuestion,
    this.customOptions,
    this.customCorrectAnswer,
  }) : super(key: key);

  @override
  State<EarnTaskDialog> createState() => _EarnTaskDialogState();
}

class _EarnTaskDialogState extends State<EarnTaskDialog> with SingleTickerProviderStateMixin {
  late AnimationController _timerController;
  late Animation<double> _timerAnimation;
  int _secondsRemaining = 15;
  bool _taskCompleted = false;
  String? _selectedAnswer;
  bool? _isCorrect;

  // Sample questions database - you can expand this
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'What is the capital of France?',
      'options': ['Paris', 'London', 'Berlin', 'Madrid'],
      'correct': 'Paris',
    },
    {
      'question': 'Which planet is known as the Red Planet?',
      'options': ['Venus', 'Mars', 'Jupiter', 'Saturn'],
      'correct': 'Mars',
    },
    {
      'question': 'What is 2 + 2?',
      'options': ['3', '4', '5', '6'],
      'correct': '4',
    },
    {
      'question': 'Who wrote "Romeo and Juliet"?',
      'options': ['Charles Dickens', 'William Shakespeare', 'Mark Twain', 'Jane Austen'],
      'correct': 'William Shakespeare',
    },
    {
      'question': 'What is the largest ocean on Earth?',
      'options': ['Atlantic Ocean', 'Indian Ocean', 'Arctic Ocean', 'Pacific Ocean'],
      'correct': 'Pacific Ocean',
    },
    {
      'question': 'In what year did the Berlin Wall fall?',
      'options': ['1987', '1989', '1991', '1993'],
      'correct': '1989',
    },
    {
      'question': 'What is the chemical symbol for gold?',
      'options': ['Go', 'Gd', 'Au', 'Ag'],
      'correct': 'Au',
    },
  ];

  late Map<String, dynamic> _currentQuestion;

  @override
  void initState() {
    super.initState();

    // Use custom question if provided, otherwise pick random
    if (widget.customQuestion != null &&
        widget.customOptions != null &&
        widget.customCorrectAnswer != null) {
      _currentQuestion = {
        'question': widget.customQuestion,
        'options': widget.customOptions,
        'correct': widget.customCorrectAnswer,
      };
    } else {
      _currentQuestion = _questions[_getRandomQuestionIndex()];
    }

    _timerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    );

    _timerAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _timerController,
        curve: Curves.linear,
      ),
    );

    _timerController.addStatusListener((status) {
      if (status == AnimationStatus.completed && !_taskCompleted) {
        // Timer expired without answer
        _handleTimeout();
      }
    });

    _timerController.forward();
  }

  int _getRandomQuestionIndex() {
    return DateTime.now().millisecondsSinceEpoch % _questions.length;
  }

  void _handleTimeout() {
    if (!_taskCompleted && mounted) {
      setState(() {
        _taskCompleted = true;
        _isCorrect = false;
      });

      // Small delay before showing result
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          widget.onTaskComplete(2); // Participation reward
          Navigator.pop(context);
        }
      });
    }
  }

  void _checkAnswer(String answer) {
    if (_taskCompleted) return;

    setState(() {
      _selectedAnswer = answer;
      _isCorrect = answer == _currentQuestion['correct'];
      _taskCompleted = true;
    });

    _timerController.stop();

    // Calculate reward
    int coinsEarned = _isCorrect!
        ? (widget.baseReward ?? 10)
        : 2; // Participation reward

    // Show result and close
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        widget.onTaskComplete(coinsEarned);
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    _timerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header with timer
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.amber.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.timer,
                    color: Colors.amber,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Quick Earn Challenge',
                    style: context.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.textPrimary,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.amber.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.monetization_on,
                        color: Colors.amber,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${widget.baseReward ?? 10} coins',
                        style: const TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Timer progress bar
            AnimatedBuilder(
              animation: _timerAnimation,
              builder: (context, child) {
                return LinearProgressIndicator(
                  value: _timerAnimation.value,
                  backgroundColor: Colors.grey.withOpacity(0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _timerAnimation.value > 0.6
                        ? Colors.green
                        : (_timerAnimation.value > 0.3 ? Colors.orange : Colors.red),
                  ),
                  minHeight: 6,
                  borderRadius: BorderRadius.circular(3),
                );
              },
            ),

            const SizedBox(height: 8),

            // Timer text
            AnimatedBuilder(
              animation: _timerAnimation,
              builder: (context, child) {
                final seconds = (_timerAnimation.value * 15).round();
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '$seconds seconds left',
                      style: TextStyle(
                        fontSize: 12,
                        color: seconds > 10
                            ? Colors.green
                            : (seconds > 5 ? Colors.orange : Colors.red),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 20),

            // Question container
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withOpacity(0.05)
                    : Colors.grey.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withOpacity(0.1)
                      : Colors.grey.shade200,
                ),
              ),
              child: Text(
                _currentQuestion['question'],
                style: context.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 20),

            // Options grid
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.5,
              physics: const NeverScrollableScrollPhysics(),
              children: (_currentQuestion['options'] as List<String>).map((option) {
                return _buildOptionButton(option);
              }).toList(),
            ),

            const SizedBox(height: 16),

            // Skip/Close button
            if (!_taskCompleted)
              TextButton(
                onPressed: _handleTimeout,
                child: Text(
                  'Skip Challenge',
                  style: TextStyle(
                    color: context.textSecondary,
                  ),
                ),
              ),

            // Result message (shown briefly before closing)
            if (_taskCompleted)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _isCorrect == true
                      ? Colors.green.withOpacity(0.1)
                      : Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _isCorrect == true
                          ? Icons.check_circle
                          : Icons.info,
                      color: _isCorrect == true ? Colors.green : Colors.orange,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _isCorrect == true
                          ? 'Correct! +${widget.baseReward ?? 10} coins'
                          : 'Good try! +2 coins for participating',
                      style: TextStyle(
                        color: _isCorrect == true ? Colors.green : Colors.orange,
                        fontWeight: FontWeight.w600,
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

  Widget _buildOptionButton(String option) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    bool isSelected = _selectedAnswer == option;
    bool isCorrectOption = option == _currentQuestion['correct'];

    Color getBackgroundColor() {
      if (!_taskCompleted) {
        return isDark ? Colors.white.withOpacity(0.1) : Colors.grey.shade100;
      }
      if (isSelected) {
        return _isCorrect == true ? Colors.green : Colors.red;
      }
      if (isCorrectOption && _isCorrect == false) {
        return Colors.green.withOpacity(0.3); // Show correct answer if user was wrong
      }
      return isDark ? Colors.white.withOpacity(0.1) : Colors.grey.shade100;
    }

    Color getTextColor() {
      if (!_taskCompleted) {
        return context.textPrimary;
      }
      if (isSelected || (isCorrectOption && _isCorrect == false)) {
        return Colors.white;
      }
      return context.textPrimary;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _taskCompleted ? null : () => _checkAnswer(option),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            decoration: BoxDecoration(
              color: getBackgroundColor(),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? (_isCorrect == true ? Colors.green : Colors.red)
                    : (isCorrectOption && _taskCompleted && _isCorrect == false
                    ? Colors.green
                    : Colors.transparent),
                width: 2,
              ),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_taskCompleted && isSelected)
                    Icon(
                      _isCorrect == true ? Icons.check : Icons.close,
                      size: 16,
                      color: Colors.white,
                    ),
                  if (_taskCompleted && !isSelected && isCorrectOption && _isCorrect == false)
                    const Icon(
                      Icons.check,
                      size: 16,
                      color: Colors.white,
                    ),
                  if (_taskCompleted && (isSelected || (isCorrectOption && _isCorrect == false)))
                    const SizedBox(width: 4),
                  Text(
                    option,
                    style: TextStyle(
                      color: getTextColor(),
                      fontWeight: isSelected || (isCorrectOption && _isCorrect == false)
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Helper function to show the dialog
Future<void> showEarnTaskDialog({
  required BuildContext context,
  required Function(int coinsEarned) onTaskComplete,
  int? baseReward,
  String? customQuestion,
  List<String>? customOptions,
  String? customCorrectAnswer,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => EarnTaskDialog(
      onTaskComplete: onTaskComplete,
      baseReward: baseReward,
      customQuestion: customQuestion,
      customOptions: customOptions,
      customCorrectAnswer: customCorrectAnswer,
    ),
  );
}