import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pavi/theme/generalTheme.dart';
import '../../model/messageModel.dart';
import 'call/postCalling.dart';
import 'dialerPage.dart';


import 'package:flutter/material.dart';


class CallScreen extends StatefulWidget {
  final String contactName;
  final String phoneNumber;
  final CallType callType;

  const CallScreen({
    super.key,
    required this.contactName,
    required this.phoneNumber,
    required this.callType,
  });

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  bool _isMuted = false;
  bool _isSpeakerOn = false;
  bool _isOnHold = false;
  int _callSeconds = 0;
  late Timer _callTimer;

  @override
  void initState() {
    super.initState();
    _startCallTimer();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  void _startCallTimer() {
    _callTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _callSeconds++;
      });
    });
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void _endCall() {
    _callTimer.cancel();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => PostCallRatingPage(
          contactName: widget.contactName,
          phoneNumber: widget.phoneNumber,
          callDuration: _formatTime(_callSeconds),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _callTimer.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isAppToApp = widget.callType == CallType.appToApp;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    // Use deepNavy for call screen background regardless of theme for consistency
    // but we can also make it theme-aware if preferred
    return Scaffold(
      backgroundColor: isDark ? context.darkBackground : context.textPrimary,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar with call info
            Padding(
              padding: EdgeInsets.all(context.spacingLG),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.keyboard_arrow_down, color: context.white),
                    onPressed: _endCall,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.spacingMD,
                      vertical: context.spacingXS,
                    ),
                    decoration: BoxDecoration(
                      color: isAppToApp ? context.primaryColor : context.warning,
                      borderRadius: BorderRadius.circular(context.radiusSM),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isAppToApp ? Icons.wifi : Icons.phone,
                          size: 14,
                          color: context.white,
                        ),
                        SizedBox(width: context.spacingXS),
                        Text(
                          isAppToApp ? 'App-to-App' : 'App-to-Phone',
                          style: context.labelSmall?.copyWith(
                            color: context.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.more_vert, color: context.white),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            // Caller info
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Profile avatar with pulse animation for active call
                  AnimatedBuilder(
                    animation: _pulseController,
                    builder: (context, child) {
                      return Container(
                        width: 120 + (_pulseController.value * 20),
                        height: 120 + (_pulseController.value * 20),
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            colors: [
                              isAppToApp ? context.primaryColor : context.warning,
                              isAppToApp
                                  ? context.primaryColor.withOpacity(0.5)
                                  : context.warning.withOpacity(0.5),
                            ],
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: context.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: context.white,
                                width: 3,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                widget.contactName.isNotEmpty ? widget.contactName[0].toUpperCase() : '?',
                                style: context.displaySmall?.copyWith(
                                  color: context.textPrimary,
                                  fontSize: 40,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: context.spacingLG),

                  Text(
                    widget.contactName,
                    style: context.headlineMedium?.copyWith(
                      color: context.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  if (!isAppToApp) ...[
                    SizedBox(height: context.spacingXS),
                    Text(
                      widget.phoneNumber,
                      style: context.bodyLarge?.copyWith(
                        color: context.white.withOpacity(0.7),
                      ),
                    ),
                  ],

                  SizedBox(height: context.spacingSM),

                  // Call timer
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.spacingLG,
                      vertical: context.spacingSM,
                    ),
                    decoration: BoxDecoration(
                      color: context.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(context.radiusXL),
                    ),
                    child: Text(
                      _formatTime(_callSeconds),
                      style: context.displaySmall?.copyWith(
                        color: context.white,
                        fontSize: 28,
                      ),
                    ),
                  ),

                  // HD Voice indicator for app-to-app
                  if (isAppToApp) ...[
                    SizedBox(height: context.spacingMD),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.spacingMD,
                        vertical: context.spacingXS,
                      ),
                      decoration: BoxDecoration(
                        color: context.primaryColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(context.radiusSM),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.verified,
                            size: 16,
                            color: context.primaryColor,
                          ),
                          SizedBox(width: context.spacingXS),
                          Text(
                            'HD Voice',
                            style: context.labelSmall?.copyWith(
                              color: context.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Call controls
            Container(
              padding: EdgeInsets.all(context.spacingXL),
              decoration: BoxDecoration(
                color: context.white.withOpacity(0.05),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(context.radiusXL),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildCallControl(
                        icon: _isMuted ? Icons.mic_off : Icons.mic,
                        label: 'Mute',
                        isActive: _isMuted,
                        onTap: () {
                          setState(() {
                            _isMuted = !_isMuted;
                          });
                        },
                      ),
                      _buildCallControl(
                        icon: Icons.dialpad,
                        label: 'Keypad',
                        onTap: () {
                          // Show keypad overlay
                        },
                      ),
                      _buildCallControl(
                        icon: _isSpeakerOn ? Icons.volume_up : Icons.volume_off,
                        label: 'Speaker',
                        isActive: _isSpeakerOn,
                        onTap: () {
                          setState(() {
                            _isSpeakerOn = !_isSpeakerOn;
                          });
                        },
                      ),
                      _buildCallControl(
                        icon: _isOnHold ? Icons.pause : Icons.pause,
                        label: 'Hold',
                        isActive: _isOnHold,
                        onTap: () {
                          setState(() {
                            _isOnHold = !_isOnHold;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: context.spacingXL),

                  // End call button
                  GestureDetector(
                    onTap: _endCall,
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: context.error,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: context.error.withOpacity(0.3),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.call_end,
                        color: context.white,
                        size: 30,
                      ),
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

  Widget _buildCallControl({
    required IconData icon,
    required String label,
    bool isActive = false,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isActive
                  ? (label == 'Mute' ? context.error : context.primaryColor)
                  : context.white.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isActive ? context.white : context.white.withOpacity(0.7),
              size: 24,
            ),
          ),
          SizedBox(height: context.spacingXS),
          Text(
            label,
            style: context.labelSmall?.copyWith(
              color: context.white.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}