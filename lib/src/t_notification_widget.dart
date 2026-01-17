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

  // -- Customization params (Keeping all original values) --
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
  late double _progressValue;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _progressValue = 1.0;
    if (widget.sticky == null || !widget.sticky!) _startSliderCountdown();
  }

  void _startSliderCountdown() {
    final int totalDuration = widget.duration.inMilliseconds;
    const int updateInterval = 50;
    final double decrementStep = updateInterval / totalDuration;

    _timer =
        Timer.periodic(const Duration(milliseconds: updateInterval), (timer) {
      if (!mounted) return;

      setState(() {
        _progressValue -= decrementStep;
        if (_progressValue <= 0) {
          _progressValue = 0;
          _timer?.cancel();
          widget.onClose();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // -- 1. Define Type Colors (Green, Red, etc.) --
    final Map<NotificationType, Color> typeColors = {
      NotificationType.success: const Color(0xFF30A175), // Green
      NotificationType.error: const Color(0xFFD8737F), // Red
      NotificationType.warning: const Color(0xFFFFAD4B), // Amber
      NotificationType.info: const Color(0xFF45505E), // Blue/Grey
    };

    final Map<NotificationType, IconData> typeIcons = {
      NotificationType.success: Iconsax.tick_circle,
      NotificationType.error: Iconsax.close_circle,
      NotificationType.warning: Iconsax.warning_2,
      NotificationType.info: Iconsax.info_circle,
    };

    // -- 2. Resolve Effective Values --
    // Logic: If user provides a color, use it. Otherwise, use the "Modern Dark Chip" defaults.

    final Color effectiveTypeColor = typeColors[widget.type]!;

    // Default BG: Dark Grey (Modern Look) OR User provided
    final Color effectiveBackgroundColor = widget.backgroundColor ??
        (isDark ? const Color(0xFF1E1E1E) : const Color(0xFF2C2C2C));

    // Default Border: None (cleaner) OR User provided
    final Color? effectiveBorderColor = widget.borderColor;

    // Text Colors
    final Color effectiveTitleColor = widget.titleColor ?? Colors.white;
    final Color effectiveMessageColor = widget.messageColor ?? Colors.white70;

    // Icon Color: Defaults to the Type Color (Green/Red) to make it pop against dark BG
    final Color effectiveIconColor = widget.iconColor ?? effectiveTypeColor;

    final double effectiveWidth = widget.width ?? 350.0;
    final double effectiveBorderRadius =
        widget.borderRadius ?? 20.0; // Increased default radius for Chip look
    final double effectivePaddingV = widget.paddingVertical ?? 12.0;
    final double effectivePaddingH = widget.paddingHorizontal ?? 16.0;

    return Material(
      color: Colors.transparent,
      child: Container(
        width: effectiveWidth,
        // -- Decoration --
        decoration: BoxDecoration(
          color: effectiveBackgroundColor,
          borderRadius: BorderRadius.circular(effectiveBorderRadius),
          border: effectiveBorderColor != null
              ? Border.all(color: effectiveBorderColor)
              : null, // Clean look by default
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        // -- Clipping for Progress Bar --
        child: ClipRRect(
          borderRadius: BorderRadius.circular(effectiveBorderRadius),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // -- Content Row --
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: effectivePaddingH, vertical: effectivePaddingV),
                child: Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align to top for long text
                  children: [
                    // 1. Icon
                    Icon(typeIcons[widget.type],
                        color: effectiveIconColor, size: 24),
                    const SizedBox(width: 12),

                    // 2. Text & Action (Expanded)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Title
                          Text(
                            widget.title,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: effectiveTitleColor,
                            ),
                          ),

                          // SubTitle (Optional)
                          if (widget.subTitle != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              widget.subTitle!,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: effectiveMessageColor,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],

                          // Custom Action (Optional)
                          if (widget.action != null) ...[
                            const SizedBox(height: 8),
                            widget.action!,
                          ],
                        ],
                      ),
                    ),

                    // 3. Close Button
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: widget.onClose,
                      borderRadius: BorderRadius.circular(100),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.close,
                          size: 18,
                          color: effectiveMessageColor.withValues(alpha: (0.6)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // -- Progress Indicator --
              if (widget.sticky == null || !widget.sticky!)
                LinearProgressIndicator(
                  value: _progressValue,
                  minHeight: 2, // Slimmer modern look
                  backgroundColor: Colors.transparent,
                  color:
                      effectiveTypeColor, // Progress matches the success/error color
                ),
            ],
          ),
        ),
      ),
    );
  }
}
