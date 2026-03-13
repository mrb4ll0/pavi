import 'package:flutter/material.dart';
import 'package:pavi/theme/generalTheme.dart';


import 'package:flutter/material.dart';

class PostCallRatingPage extends StatefulWidget {
  final String contactName;
  final String phoneNumber;
  final String callDuration;

  const PostCallRatingPage({
    super.key,
    required this.contactName,
    required this.phoneNumber,
    required this.callDuration,
  });

  @override
  State<PostCallRatingPage> createState() => _PostCallRatingPageState();
}

class _PostCallRatingPageState extends State<PostCallRatingPage> {
  int _rating = 0;
  final TextEditingController _commentController = TextEditingController();
  bool _isSubmitting = false;
  String? _selectedTag;

  final List<String> _feedbackTags = [
    'Clear audio',
    'Call dropped',
    'Good connection',
    'Bad quality',
    'Friendly caller',
    'Professional',
  ];

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _submitRating() {
    if (_rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please rate the call quality'),
          backgroundColor: context.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.radiusSM),
          ),
        ),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    // Simulate API call
    Future.delayed(const Duration(seconds: 1), () {
      setState(() => _isSubmitting = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Thank you for your feedback!'),
          backgroundColor: context.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.radiusSM),
          ),
        ),
      );

      // Navigate back to dialer
      Navigator.popUntil(context, ModalRoute.withName('/'));
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        backgroundColor: context.surfaceColor,
        elevation: 0,
        title: Text(
          'Rate Call',
          style: context.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: context.textPrimary,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.close, color: context.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // Call summary card
            Container(
              margin: EdgeInsets.all(context.spacingLG),
              padding: EdgeInsets.all(context.spacingLG),
              decoration: BoxDecoration(
                color: isDark ? context.darkCard : context.white,
                borderRadius: BorderRadius.circular(context.radiusLG),
                boxShadow: isDark ? null : context.shadowSM,
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: context.primaryGradient,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        widget.contactName.isNotEmpty ? widget.contactName[0].toUpperCase() : '?',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: context.spacingMD),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.contactName,
                          style: context.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: context.textPrimary,
                          ),
                        ),
                        Text(
                          widget.phoneNumber,
                          style: context.bodySmall?.copyWith(
                            color: context.textSecondary,
                          ),
                        ),
                        SizedBox(height: context.spacingXS),
                        Row(
                          children: [
                            Icon(
                              Icons.timer_outlined,
                              size: 14,
                              color: context.textSecondary,
                            ),
                            SizedBox(width: context.spacingXXS),
                            Text(
                              'Call duration: ${widget.callDuration}',
                              style: context.labelSmall?.copyWith(
                                color: context.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Rating stars
            Container(
              margin: EdgeInsets.symmetric(horizontal: context.spacingLG),
              padding: EdgeInsets.all(context.spacingLG),
              decoration: BoxDecoration(
                color: isDark ? context.darkCard : context.white,
                borderRadius: BorderRadius.circular(context.radiusLG),
                boxShadow: isDark ? null : context.shadowSM,
              ),
              child: Column(
                children: [
                  Text(
                    'How was the call quality?',
                    style: context.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: context.textPrimary,
                    ),
                  ),
                  SizedBox(height: context.spacingMD),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _rating = index + 1;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(context.spacingXS),
                          child: Icon(
                            index < _rating ? Icons.star : Icons.star_border,
                            color: index < _rating
                                ? context.warning  // Using warning color (amber) for stars
                                : context.textHint,
                            size: 40,
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: context.spacingSM),
                  Text(
                    _rating == 0
                        ? 'Tap to rate'
                        : _rating <= 2
                        ? 'Poor'
                        : _rating == 3
                        ? 'Average'
                        : _rating == 4
                        ? 'Good'
                        : 'Excellent',
                    style: context.bodyMedium?.copyWith(
                      color: _rating <= 2
                          ? context.error
                          : _rating >= 4
                          ? context.success
                          : context.warning,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: context.spacingLG),

            // Quick feedback tags
            Container(
              margin: EdgeInsets.symmetric(horizontal: context.spacingLG),
              padding: EdgeInsets.all(context.spacingLG),
              decoration: BoxDecoration(
                color: isDark ? context.darkCard : context.white,
                borderRadius: BorderRadius.circular(context.radiusLG),
                boxShadow: isDark ? null : context.shadowSM,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quick feedback (optional)',
                    style: context.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: context.textPrimary,
                    ),
                  ),
                  SizedBox(height: context.spacingMD),
                  Wrap(
                    spacing: context.spacingSM,
                    runSpacing: context.spacingSM,
                    children: _feedbackTags.map((tag) {
                      final isSelected = _selectedTag == tag;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedTag = isSelected ? null : tag;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.spacingMD,
                            vertical: context.spacingSM,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? (isDark ? context.accentPurple : context.primaryColor)
                                : (isDark
                                ? context.darkSurface
                                : context.primaryColor.withOpacity(0.1)),
                            borderRadius: BorderRadius.circular(context.radiusXL),
                            border: isSelected
                                ? null
                                : Border.all(
                              color: isDark
                                  ? context.darkTextHint.withOpacity(0.3)
                                  : context.lightGray,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            tag,
                            style: context.labelSmall?.copyWith(
                              color: isSelected
                                  ? (isDark ? context.darkTextPrimary : context.white)
                                  : context.textPrimary,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            SizedBox(height: context.spacingLG),

            // Comment box
            Container(
              margin: EdgeInsets.symmetric(horizontal: context.spacingLG),
              padding: EdgeInsets.all(context.spacingLG),
              decoration: BoxDecoration(
                color: isDark ? context.darkCard : context.white,
                borderRadius: BorderRadius.circular(context.radiusLG),
                boxShadow: isDark ? null : context.shadowSM,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Additional comments',
                    style: context.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: context.textPrimary,
                    ),
                  ),
                  SizedBox(height: context.spacingMD),
                  TextField(
                    controller: _commentController,
                    maxLines: 4,
                    maxLength: 500,
                    style: context.bodyLarge?.copyWith(
                      color: context.textPrimary,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Tell us more about your call experience...',
                      hintStyle: context.bodyMedium?.copyWith(
                        color: context.textHint,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(context.radiusMD),
                        borderSide: BorderSide(
                          color: isDark ? context.darkTextHint.withOpacity(0.3) : context.lightGray,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(context.radiusMD),
                        borderSide: BorderSide(
                          color: isDark ? context.darkTextHint.withOpacity(0.3) : context.lightGray,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(context.radiusMD),
                        borderSide: BorderSide(
                          color: isDark ? context.accentPurple : context.primaryColor,
                          width: 2,
                        ),
                      ),
                      filled: true,
                      fillColor: isDark ? context.darkSurface : context.offWhite,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: context.spacingXL),

            // Submit button
            Padding(
              padding: EdgeInsets.all(context.spacingLG),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: _isSubmitting
                    ? Center(
                  child: CircularProgressIndicator(
                    color: isDark ? context.accentPurple : context.primaryColor,
                  ),
                )
                    : ElevatedButton(
                  onPressed: _submitRating,
                  style: context.primaryButton,
                  child: Text(
                    'Submit Feedback',
                    style: context.labelLarge?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}