import 'package:flutter/material.dart';

import '../t_overlay_notification.dart';

/// A utility class for managing overlay notifications in Flutter.
/// This class allows creating styled notifications (success, error, warning, info)
/// that appear as overlays on the app screen.
class TNotificationOverlay {
  // A list to track active notifications.
  static final List<OverlayEntry> _notifications = [];

  /// Displays a notification with a specific type, title, and message.
  ///
  /// [title] is the title of the notification.
  /// [subTitle] is the detailed message of the notification.
  /// [type] determines the style (success, error, warning, info).
  /// [duration] defines how long the notification will remain visible (default is 3 seconds).
  /// [spacing] allows customization of the space between notifications (default is 10.0).
  /// [position] defines the corner where notifications will appear (default is topRight).
  static void show({
    required BuildContext context,
    required Widget title,
    Widget? subTitle,
    NotificationType type = NotificationType.info,
    Duration duration = const Duration(seconds: 3),
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
    NotificationPosition position = NotificationPosition.topRight,
  }) {
    // Obtain the current overlay from the context.
    final overlay = Navigator.of(context).overlay;

    // Declare the OverlayEntry to handle the current notification.
    late final OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) {
        // Determine the alignment based on user-specified position.
        Alignment alignment;
        switch (position) {
          case NotificationPosition.topLeft:
            alignment = Alignment.topLeft;
            break;
          case NotificationPosition.topRight:
            alignment = Alignment.topRight;
            break;
          case NotificationPosition.bottomLeft:
            alignment = Alignment.bottomLeft;
            break;
          case NotificationPosition.bottomRight:
            alignment = Alignment.bottomRight;
            break;
        }

        final offset = (_notifications.indexOf(overlayEntry) * (height + spacing));

        return Align(
          alignment: alignment,
          child: Padding(
            padding: EdgeInsets.only(
              top: (position == NotificationPosition.topLeft || position == NotificationPosition.topRight) ? offset : 0,
              bottom: (position == NotificationPosition.bottomLeft || position == NotificationPosition.bottomRight) ? offset : 0,
            ),
            child: TNotificationWidget(
              title: title,
              subTitle: subTitle,
              onClose: () => _removeNotification(overlayEntry),
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
            ),
          ),
        );
      },
    );

    // Add the notification entry to the list and insert it into the overlay.
    _notifications.add(overlayEntry);
    overlay?.insert(overlayEntry);

    // Automatically remove the notification after the specified duration.
    Future.delayed(duration, () => _removeNotification(overlayEntry));
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
