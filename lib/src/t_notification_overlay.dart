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
  static void success({
    required BuildContext context,
    required String title,
    String? subTitle,
    Widget? action,
    bool? sticky,
    Duration duration = const Duration(seconds: 5),
    double spacing = 10,
    double height = 100,
    double? width,
    NotificationPosition position = NotificationPosition.topRight,
  }) {
    show(
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
  static void error({
    required BuildContext context,
    required String title,
    String? subTitle,
    Widget? action,
    bool? sticky,
    Duration duration = const Duration(seconds: 5),
    double spacing = 10,
    double height = 100,
    double? width,
    NotificationPosition position = NotificationPosition.topRight,
  }) {
    show(
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
  static void warning({
    required BuildContext context,
    required String title,
    String? subTitle,
    Widget? action,
    bool? sticky,
    Duration duration = const Duration(seconds: 5),
    double spacing = 10,
    double height = 100,
    double? width,
    NotificationPosition position = NotificationPosition.topRight,
  }) {
    show(
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
  static void info({
    required BuildContext context,
    required String title,
    String? subTitle,
    Widget? action,
    bool? sticky,
    Duration duration = const Duration(seconds: 5),
    double spacing = 10,
    double height = 100,
    double? width,
    NotificationPosition position = NotificationPosition.topRight,
  }) {
    show(
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
  static void show({
    required BuildContext context,
    required String title,
    String? subTitle,
    Widget? action,
    NotificationType type = NotificationType.info,
    Duration duration = const Duration(seconds: 5),
    bool? sticky,
    double spacing = 10,
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
    NotificationPosition position = NotificationPosition.topRight,
  }) {
    // Obtain the current overlay from the context.
    final overlay = Navigator.of(context).overlay;

    // Declare the OverlayEntry to handle the current notification.
    late final OverlayEntry overlayEntry;

    // Add a global key to control the position animation.
    final GlobalKey<NotificationAnimationPositionState> key =
        GlobalKey<NotificationAnimationPositionState>();

    overlayEntry = OverlayEntry(
      builder: (context) {
        // Determine the alignment based on user-specified position.
        final bool isTop = position == NotificationPosition.topLeft ||
            position == NotificationPosition.topRight;
        final bool isLeft = position == NotificationPosition.topLeft ||
            position == NotificationPosition.bottomLeft;

        return AnimatedPositioned(
          duration: Duration(milliseconds: 300),
          left: isLeft ? 16.0 : null,
          right: isLeft ? null : 16.0,
          top: isTop
              ? _calculateOffset(overlayEntry, height, spacing, isTop: true)
              : null,
          bottom: isTop
              ? null
              : _calculateOffset(overlayEntry, height, spacing, isTop: false),
          child: NotificationAnimationPosition(
            key: key,
            slideInDirection: slideInDirection,
            slideOutDirection: slideOutDirection,
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
    overlay?.insert(overlayEntry);

    // Automatically remove the notification after the specified duration.
    if (sticky == null || !sticky) {
      Future.delayed(
        duration,
        () => key.currentState
            ?.animateOut(() => _removeNotification(overlayEntry)),
      );
    }
  }

  static double _calculateOffset(
      OverlayEntry entry, double height, double spacing,
      {required bool isTop}) {
    final index = _notifications.indexOf(entry);
    final totalOffset = index * (height + spacing);
    return totalOffset + (isTop ? height : 0.0); // Add margin for padding.
  }

  /// Removes a notification from the overlay and updates the positions of the remaining notifications.
  static void _removeNotification(OverlayEntry overlayEntry) {
    if (_notifications.contains(overlayEntry)) {
      // Remove the notification from the list.
      _notifications.remove(overlayEntry);

      // Remove the overlay entry from the overlay.
      overlayEntry.remove();

      // Trigger a rebuild of the remaining notifications.
      for (var entry in _notifications) {
        entry.markNeedsBuild();
      }
    }
  }
}
