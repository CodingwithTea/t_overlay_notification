import 'package:flutter/material.dart';

import '../t_overlay_notification.dart';
import 'enums.dart';

/// A utility class for managing overlay notifications in Flutter.
/// This class allows creating styled notifications (success, error, warning, info)
/// that appear as overlays on the app screen.
class TNotificationOverlay {
  // A list to track active notifications.
  static final List<OverlayEntry> _notifications = [];

  // Notification item height and spacing between items.
  static const double _notificationHeight = 70.0;
  static const double _notificationSpacing = 8.0;

  /// Displays a notification with a specific type, title, and message.
  ///
  /// [title] is the title of the notification.
  /// [message] is the detailed message of the notification.
  /// [type] determines the style (success, error, warning, info).
  /// [duration] defines how long the notification will remain visible (default is 3 seconds).
  static void show({
    required String title,
    required String message,
    required NotificationType type,
    Duration duration = const Duration(seconds: 3),
    required BuildContext context,
  }) {
    // Obtain the current overlay from the context.
    final overlay = Navigator.of(context).overlay;

    // Declare the OverlayEntry to handle the current notification.
    late final OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) {
        return AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          // Smooth animation for appearance.
          curve: Curves.easeInOut,
          // Animation curve for better UX.
          top: 20.0 +
              (_notifications.indexOf(overlayEntry) *
                  (_notificationHeight + _notificationSpacing)),
          // Calculate position based on existing notifications.
          right: 20.0,
          child: TNotificationWidget(
            title: title,
            message: message,
            type: type,
            onClose: () {
              _removeNotification(overlayEntry);
            },
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

      // Rebuild the positions of remaining notifications.
      for (var entry in _notifications) {
        entry.markNeedsBuild();
      }
    }
  }
}
