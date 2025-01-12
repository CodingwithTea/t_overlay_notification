import 'package:flutter/material.dart';

import 'enums.dart';

/// A widget that represents a single notification card.
class TNotificationWidget extends StatelessWidget {
  final String title;
  final String message;
  final NotificationType type;
  final VoidCallback onClose;

  const TNotificationWidget({
    required this.title,
    required this.message,
    required this.type,
    required this.onClose,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Define colors and icons for each notification type.
    final Map<NotificationType, Color> typeColors = {
      NotificationType.success: Colors.green,
      NotificationType.error: Colors.red,
      NotificationType.warning: Colors.orange,
      NotificationType.info: Colors.blue,
    };

    final Map<NotificationType, IconData> typeIcons = {
      NotificationType.success: Icons.check_circle,
      NotificationType.error: Icons.error,
      NotificationType.warning: Icons.warning,
      NotificationType.info: Icons.info,
    };

    return Material(
      color: Colors.transparent, // No background for Material wrapper.
      child: Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        // Space between notifications.
        padding: const EdgeInsets.all(12.0),
        // Internal padding for content.
        decoration: BoxDecoration(
          color: typeColors[type]!
              .withValues(alpha: 0.1), // Background color based on type.
          border: Border.all(
              color: typeColors[type]!), // Border color based on type.
          borderRadius: BorderRadius.circular(8.0), // Rounded corners.
        ),
        width: 300.0,
        // Fixed width for notifications.
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(typeIcons[type],
                color: typeColors[type]), // Icon based on type.
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: typeColors[type],
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    message,
                    style: const TextStyle(fontSize: 14.0, color: Colors.black),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, size: 18.0), // Close button.
              onPressed: onClose,
            ),
          ],
        ),
      ),
    );
  }
}
