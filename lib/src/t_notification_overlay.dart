import 'package:flutter/material.dart';

import '../t_overlay_notification.dart';
import 'animation_position_widget.dart';

/// A utility class for managing overlay notifications in Flutter.
/// This class allows creating styled notifications (success, error, warning, info)
/// that appear as overlays on the app screen.
class TNotificationOverlay {
  // A list to track active notifications.
  static final List<OverlayEntry> _notifications = [];

  /// Displays a success notification.
  static OverlayEntry? success({
    required BuildContext context,
    required String title,
    String? subTitle,
    Widget? action,
    bool? sticky,
    Duration duration = const Duration(seconds: 4),
    double spacing = 10,
    double height = 100,
    double? width,
    NotificationPosition? position,
  }) {
    return show(
      context: context,
      title: title,
      subTitle: subTitle,
      action: action,
      sticky: sticky,
      type: NotificationType.success,
      duration: duration,
      spacing: spacing,
      height: height,
      width: width,
      position: position,
    );
  }

  /// Displays an error notification.
  static OverlayEntry? error({
    required BuildContext context,
    required String title,
    String? subTitle,
    Widget? action,
    bool? sticky,
    Duration duration = const Duration(seconds: 4),
    double spacing = 10,
    double height = 100,
    double? width,
    NotificationPosition? position,
  }) {
    return show(
      context: context,
      title: title,
      subTitle: subTitle,
      action: action,
      sticky: sticky,
      type: NotificationType.error,
      duration: duration,
      spacing: spacing,
      height: height,
      width: width,
      position: position,
    );
  }

  /// Displays a warning notification.
  static OverlayEntry? warning({
    required BuildContext context,
    required String title,
    String? subTitle,
    Widget? action,
    bool? sticky,
    Duration duration = const Duration(seconds: 4),
    double spacing = 10,
    double height = 100,
    double? width,
    NotificationPosition? position,
  }) {
    return show(
      context: context,
      title: title,
      subTitle: subTitle,
      action: action,
      sticky: sticky,
      type: NotificationType.warning,
      duration: duration,
      spacing: spacing,
      height: height,
      width: width,
      position: position,
    );
  }

  /// Displays an info notification.
  static OverlayEntry? info({
    required BuildContext context,
    required String title,
    String? subTitle,
    Widget? action,
    bool? sticky,
    Duration duration = const Duration(seconds: 4),
    double spacing = 10,
    double height = 100,
    double? width,
    NotificationPosition? position,
  }) {
    return show(
      context: context,
      title: title,
      subTitle: subTitle,
      action: action,
      sticky: sticky,
      type: NotificationType.info,
      duration: duration,
      spacing: spacing,
      height: height,
      width: width,
      position: position,
    );
  }

  /// Displays a notification with a specific type, title, and message.
  ///
  /// [title] is the main title of the notification (required).
  /// [subTitle] is the optional detailed message of the notification.
  /// [action] is a customizable widget for user actions (e.g., buttons).
  /// [type] determines the style of the notification (success, error, warning, info).
  /// [duration] defines how long the notification remains visible. Ignored if [sticky] is true.
  /// [sticky] makes the notification stay on screen indefinitely (default is false).
  /// [spacing] specifies the space between stacked notifications (default is 10.0).
  /// [height] sets the height of the notification widget.
  /// [width] specifies the width of the notification widget.
  /// [titleColor], [messageColor], [backgroundColor], and [borderColor] customize colors.
  /// [borderRadius] sets the corner radius of the notification box.
  /// [iconColor] customizes the notification icon color.
  /// [paddingVertical] and [paddingHorizontal] adjust internal padding.
  /// [slideInDirection] and [slideOutDirection] control the slide animations.
  /// [position] defines the notification's position on the screen (e.g., topRight, bottomLeft).
  static OverlayEntry? show({
    required BuildContext context,
    required String title,
    String? subTitle,
    Widget? action,
    NotificationType type = NotificationType.info,
    Duration duration = const Duration(seconds: 4),
    bool? sticky,
    double spacing = 20,
    double height = 100,
    double? width,
    Color? titleColor,
    Color? messageColor,
    Color? backgroundColor,
    Color? borderColor,
    double? borderRadius,
    Color? iconColor,
    double? paddingVertical,
    double? paddingHorizontal,
    SlideDirection? slideInDirection,
    SlideDirection? slideOutDirection,
    NotificationPosition? position,
  }) {
    // Obtain the current overlay from the context.
    final overlay = Navigator.of(context).overlay;
    if (overlay == null) return null;

    // Declare the OverlayEntry to handle the current notification.
    late final OverlayEntry overlayEntry;

    // Add a global key to control the position animation.
    final GlobalKey<NotificationAnimationPositionState> key =
        GlobalKey<NotificationAnimationPositionState>();

    // -- RESPONSIVE CALCULATIONS --
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    // Mobile: 90% width, Web: Fixed 400px or user defined
    final effectiveWidth = width ?? (isMobile ? screenWidth * 0.9 : 400.0);

    // Spacing Calculations
    const double itemSpacing = 10.0;
    const double itemHeight = 80.0; // Approximate height for stacking logic

    // Show center in mobile and top right in web
    if (position == null) {
      if (isMobile) {
        position = NotificationPosition.bottomCenter;
      } else {
        position = NotificationPosition.topRight;
      }
    }

    // Create the notification entry.
    overlayEntry = OverlayEntry(
      builder: (context) {
        final safePadding = MediaQuery.of(context).padding;

        // Determine the alignment based on user-specified position.
        // final bool isTop = position == NotificationPosition.topLeft || position == NotificationPosition.topRight;
        // final bool isLeft = position == NotificationPosition.topLeft || position == NotificationPosition.bottomLeft;

        return AnimatedPositioned(
          duration: Duration(milliseconds: 300),
          // Logic for Horizontal Alignment
          left: isMobile
              ? spacing
              : _getLeftPosition(position!, screenWidth, effectiveWidth),
          right: isMobile
              ? spacing
              : _getRightPosition(position!, screenWidth, effectiveWidth),

          // Logic for Vertical Stacking
          top: _getTopPosition(position!, safePadding.top,
              _notifications.indexOf(overlayEntry), itemHeight, itemSpacing),
          bottom: _getBottomPosition(position, safePadding.bottom,
              _notifications.indexOf(overlayEntry), itemHeight, itemSpacing),

          // left: isLeft ? 16.0 : null,
          // right: isLeft ? null : 16.0,
          // top: isTop ? _calculateOffset(overlayEntry, height, spacing, isTop: true) : null,
          // bottom: isTop ? null : _calculateOffset(overlayEntry, height, spacing, isTop: false),
          child: NotificationAnimationPosition(
            key: key,
            slideInDirection: slideInDirection ??
                (isMobile
                    ? SlideDirection.bottomToTop
                    : SlideDirection.rightToLeft),
            slideOutDirection: slideOutDirection ??
                (isMobile
                    ? SlideDirection.bottomToTop
                    : SlideDirection.rightToLeft),
            child: TNotificationWidget(
              title: title,
              subTitle: subTitle,
              action: action,
              sticky: sticky,
              type: type,
              width: width,
              paddingHorizontal: paddingHorizontal,
              paddingVertical: paddingVertical,
              titleColor: titleColor,
              messageColor: messageColor,
              backgroundColor: backgroundColor,
              borderColor: borderColor,
              borderRadius: borderRadius,
              iconColor: iconColor,
              duration: duration,
              onClose: () {
                key.currentState?.animateOut(() {
                  _removeNotification(overlayEntry);
                });
              },
            ),
          ),
        );
      },
    );

    // Add the notification entry to the list and insert it into the overlay.
    _notifications.add(overlayEntry);
    overlay.insert(overlayEntry);

    // Automatically remove the notification after the specified duration.
    if (sticky != true) {
      Future.delayed(duration, () {
        if (_notifications.contains(overlayEntry)) {
          key.currentState?.animateOut(() => _removeNotification(overlayEntry));
        }
      });
    }

    return overlayEntry;
  }

  /// Removes a notification from the overlay and updates the positions of the remaining notifications.
  static void _removeNotification(OverlayEntry overlayEntry) {
    if (_notifications.contains(overlayEntry)) {
      // Remove the notification from the list.
      _notifications.remove(overlayEntry);

      // Remove the overlay entry from the overlay.
      overlayEntry.remove();

      // Rebuild remaining to adjust stack positions
      for (var e in _notifications) {
        e.markNeedsBuild();
      }
    }
  }

  // -- HELPER: Position Logic --

  static double? _getLeftPosition(
      NotificationPosition pos, double screenW, double widgetW) {
    if (pos == NotificationPosition.topLeft ||
        pos == NotificationPosition.bottomLeft) return 16.0;
    if (pos == NotificationPosition.topCenter ||
        pos == NotificationPosition.bottomCenter) {
      return (screenW - widgetW) / 2;
    }
    return null; // Right aligned
  }

  static double? _getRightPosition(
      NotificationPosition pos, double screenW, double widgetW) {
    if (pos == NotificationPosition.topRight ||
        pos == NotificationPosition.bottomRight) return 16.0;
    return null; // Left or Center aligned
  }

  static double? _getTopPosition(NotificationPosition pos, double safeTop,
      int index, double height, double spacing) {
    if (pos.name.startsWith('top')) {
      return safeTop + 16 + (index * (height + spacing));
    }
    return null;
  }

  static double? _getBottomPosition(NotificationPosition pos, double safeBottom,
      int index, double height, double spacing) {
    if (pos.name.startsWith('bottom')) {
      return safeBottom + 16 + (index * (height + spacing));
    }
    return null;
  }

  /// REMOVE ALL: Clear all active notifications programmatically.
  /// Useful when cleaning up screen transitions or resetting state (e.g. Internet restored).
  static void closeAll() {
    for (final entry in _notifications) {
      // Remove the layer from the screen
      entry.remove();
    }
    // Clear the tracking list
    _notifications.clear();
  }

  /// Removes a specific notification entry.
  static void close(OverlayEntry? entry) {
    if (entry != null && _notifications.contains(entry)) {
      _notifications.remove(entry);
      entry.remove();
      // Rebuild remaining to fix spacing
      for (var e in _notifications) {
        e.markNeedsBuild();
      }
    }
  }
}
