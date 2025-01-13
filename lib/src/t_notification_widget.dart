import 'dart:async';

import 'package:flutter/material.dart';

import '../t_overlay_notification.dart';

class TNotificationWidget extends StatefulWidget {
  final Widget title;
  final Widget? subTitle;
  final NotificationType type;
  final VoidCallback onClose;

  final Color? backgroundColor;
  final Color? borderColor;
  final Color? titleColor;
  final Color? messageColor;
  final Color? iconColor;
  final double? width;
  final double? borderRadius;
  final double? paddingVertical;
  final double? paddingHorizontal;
  final Duration duration;

  const TNotificationWidget({
    required this.title,
    required this.type,
    required this.onClose,
    required this.duration,
    this.subTitle,
    this.backgroundColor,
    this.borderColor,
    this.titleColor,
    this.messageColor,
    this.iconColor,
    this.width,
    this.borderRadius,
    this.paddingVertical,
    this.paddingHorizontal,
    super.key,
  });

  @override
  State<TNotificationWidget> createState() => _TNotificationWidgetState();
}

class _TNotificationWidgetState extends State<TNotificationWidget> {
  late double _progressValue; // Initialize slider value dynamically.
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _progressValue = 1.0;
    _startSliderCountdown();
  }

  void _startSliderCountdown() {
    final int totalDuration = widget.duration.inMilliseconds;
    const int updateInterval = 50; // 50 ms update interval.
    final double decrementStep = updateInterval / totalDuration;

    _timer = Timer.periodic(Duration(milliseconds: updateInterval), (timer) {
      if (!mounted) return;

      setState(() {
        _progressValue -= decrementStep;
        if (_progressValue <= 0) {
          _progressValue = 0; // Ensure the value is exactly 0.
          _timer?.cancel(); // Stop the timer.
          widget.onClose(); // Trigger the close callback.
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<NotificationType, Color> defaultTypeColors = {
      NotificationType.success: const Color(0xFF4CAF50),
      NotificationType.error: const Color(0xFFF44336),
      NotificationType.warning: const Color(0xFFFFC107),
      NotificationType.info: const Color(0xFF2196F3),
    };

    final Map<NotificationType, IconData> typeIcons = {
      NotificationType.success: Icons.check,
      NotificationType.error: Icons.error,
      NotificationType.warning: Icons.warning,
      NotificationType.info: Icons.info,
    };

    final Color effectiveBackgroundColor = widget.backgroundColor ??
        defaultTypeColors[widget.type]!.withValues(alpha: 0.2);
    final Color effectiveBorderColor =
        widget.borderColor ?? defaultTypeColors[widget.type]!;
    final Color effectiveIconColor =
        widget.iconColor ?? defaultTypeColors[widget.type]!;
    final double effectiveWidth = widget.width ?? 350.0;
    final double effectiveBorderRadius = widget.borderRadius ?? 16.0;
    final double effectivePaddingVertical = widget.paddingVertical ?? 8.0;
    final double effectivePaddingHorizontal = widget.paddingHorizontal ?? 12.0;

    return Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(effectivePaddingVertical),
        // padding: EdgeInsets.only(top: effectivePaddingVertical),
        decoration: BoxDecoration(
          color: effectiveBackgroundColor,
          border:
              Border(left: BorderSide(color: effectiveBorderColor, width: 1)),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(effectiveBorderRadius),
            bottomRight: Radius.circular(effectiveBorderRadius),
          ),
        ),
        width: effectiveWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Value
            ListTile(
              title: widget.title,
              subtitle: widget.subTitle,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: effectivePaddingHorizontal),
              leading: Icon(typeIcons[widget.type],
                  size: 24.0, color: effectiveIconColor),
              trailing: IconButton(
                icon: const Icon(Icons.close, size: 18.0),
                onPressed: widget.onClose,
              ),
            ),

            /// Progress Indicator
            LinearProgressIndicator(
                minHeight: 1,
                value: _progressValue,
                color: effectiveBorderColor),
          ],
        ),
      ),
    );
  }
}
