import 'package:flutter/material.dart';

import '../t_overlay_notification.dart';

class TNotificationWidget extends StatefulWidget {
  final Widget title;
  final Widget? subTitle;
  final NotificationType type;
  final VoidCallback onClose;

  // Optional parameters with default values
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
  double _sliderValue = 1.0; // Starts with a full slider.

  @override
  void initState() {
    super.initState();
    _startSliderCountdown();
  }

  void _startSliderCountdown() {
    final durationMilliseconds = widget.duration.inMilliseconds - 250;
    final int updateInterval = 50; // Interval in milliseconds for slider updates.
    final double decrementStep = updateInterval / durationMilliseconds;

    // Perform the first update immediately before the delay.
    setState(() {
      _sliderValue -= decrementStep;
      if (_sliderValue <= 0) {
        _sliderValue = 0; // Ensure the slider value is precisely 0.
        widget.onClose(); // Close the notification.
      }
    });

    // Start the periodic updates.
    Future.doWhile(() async {
      await Future.delayed(Duration(milliseconds: updateInterval));
      setState(() {
        _sliderValue -= decrementStep;
        if (_sliderValue <= 0) {
          _sliderValue = 0; // Ensure the slider value is precisely 0.
          widget.onClose(); // Close the notification.
        }
      });
      return _sliderValue > 0; // Continue the loop until the slider reaches 0.
    });
  }

  @override
  Widget build(BuildContext context) {
    // Default values for colors and dimensions
    final Map<NotificationType, Color> defaultTypeColors = {
      NotificationType.success: Color(0xFF4CAF50), // Custom soft green
      NotificationType.error: Color(0xFFF44336), // Custom soft red
      NotificationType.warning: Color(0xFFFFC107), // Custom amber yellow
      NotificationType.info: Color(0xFF2196F3), // Custom blue
    };

    final Map<NotificationType, IconData> typeIcons = {
      NotificationType.success: Icons.check,
      NotificationType.error: Icons.error,
      NotificationType.warning: Icons.warning,
      NotificationType.info: Icons.info,
    };

    // Use provided values or fallback to defaults
    final Color effectiveBackgroundColor = widget.backgroundColor ?? defaultTypeColors[widget.type]!.withOpacity(0.1);
    final Color effectiveBorderColor = widget.borderColor ?? defaultTypeColors[widget.type]!;
    final Color effectiveIconColor = widget.iconColor ?? defaultTypeColors[widget.type]!;
    final double effectiveWidth = widget.width ?? 350.0;
    final double effectiveBorderRadius = widget.borderRadius ?? 8.0;
    final double effectivePaddingVertical = widget.paddingVertical ?? 8.0;
    final double effectivePaddingHorizontal = widget.paddingHorizontal ?? 12.0;

    return Material(
      color: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        padding: EdgeInsets.only(top: effectivePaddingVertical),
        decoration: BoxDecoration(
          color: effectiveBackgroundColor,
          border: Border(left: BorderSide(color: effectiveBorderColor, width: 2)),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(effectiveBorderRadius),
            bottomRight: Radius.circular(effectiveBorderRadius),
          ),
        ),
        width: effectiveWidth,
        // Adjusted height dynamically.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              style: ListTileStyle.drawer,
              title: widget.title,
              subtitle: widget.subTitle,
              contentPadding: EdgeInsets.symmetric(horizontal: effectivePaddingHorizontal),
              leading: Icon(typeIcons[widget.type], size: 24.0, color: effectiveIconColor),
              trailing: IconButton(icon: const Icon(Icons.close, size: 18.0), onPressed: widget.onClose),
            ),
            LinearProgressIndicator(
              color: effectiveBorderColor,
              value: _sliderValue,
            ),
          ],
        ),
      ),
    );
  }
}
