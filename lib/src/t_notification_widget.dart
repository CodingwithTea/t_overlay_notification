import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../t_overlay_notification.dart';

class TNotificationWidget extends StatefulWidget {
  final String title;
  final String? subTitle;
  final Widget? action;
  final NotificationType type;
  final VoidCallback onClose;
  final bool? sticky;

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
    this.action,
    this.backgroundColor,
    this.borderColor,
    this.titleColor,
    this.messageColor,
    this.iconColor,
    this.width,
    this.borderRadius,
    this.paddingVertical,
    this.paddingHorizontal,
    this.sticky,
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
    if (widget.sticky == null || !widget.sticky!) _startSliderCountdown();
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
      NotificationType.success: const Color(0xFF8FB9A8),
      NotificationType.error: const Color(0xFFD8737F),
      NotificationType.warning: const Color(0xFFFCBB6D),
      NotificationType.info: const Color(0xFF475C7A),
    };

    final Map<NotificationType, IconData> typeIcons = {
      NotificationType.success: Iconsax.tick_circle,
      NotificationType.error: Iconsax.close_circle,
      NotificationType.warning: Iconsax.warning_2,
      NotificationType.info: Iconsax.info_circle,
    };

    final Color effectiveBackgroundColor = widget.backgroundColor ?? defaultTypeColors[widget.type]!;
    final Color effectiveBorderColor = widget.borderColor ?? defaultTypeColors[widget.type]!;
    final Color effectiveIconColor = widget.iconColor ?? Colors.white;
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
          border: Border(left: BorderSide(color: effectiveBorderColor, width: 1)),
          borderRadius: BorderRadius.circular(effectiveBorderRadius),
        ),
        width: effectiveWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Value
            ListTile(
              title: Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
              subtitle: widget.action != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.subTitle != null)
                          Text(widget.subTitle!, style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14, color: Colors.white)),
                        widget.action!,
                      ],
                    )
                  : widget.subTitle != null
                      ? Text(widget.subTitle!, style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14, color: Colors.white))
                      : null,
              contentPadding: EdgeInsets.symmetric(horizontal: effectivePaddingHorizontal),
              leading: Icon(typeIcons[widget.type], size: 24.0, color: effectiveIconColor),
              trailing: IconButton(
                icon: const Icon(Icons.close, size: 18.0, color: Colors.white),
                onPressed: widget.onClose,
              ),
            ),

            /// Progress Indicator
            LinearProgressIndicator(minHeight: 1, value: _progressValue, color: effectiveBorderColor),
          ],
        ),
      ),
    );
  }
}
