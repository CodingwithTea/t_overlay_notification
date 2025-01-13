# TOverlayNotification

A reusable Flutter notification overlay widget for displaying success, error, warning, and info messages. This package allows you to show customizable notifications that automatically dismiss after a specified duration and can stack multiple notifications.

## Features

- Styled notifications for different types: Success, Error, Warning, and Info.
- Automatically dismisses after a configurable duration.
- Supports stacking multiple notifications.
- Highly customizable UI and message content.
- Easy to integrate into any Flutter project.

## Usage

### Step 1: Add Dependency

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  t_overlay_notification: ^0.0.4
```

### Step 2: Import the Package

In your Dart file, import the package:

```dart
import 'package:t_overlay_notification/t_overlay_notification.dart';
```

### Step 3: Show a Notification
Use the TNotificationOverlay.show() method to show a notification:

```dart
TNotificationOverlay.show(
  context: context,  // The BuildContext to insert the overlay.
  title: 'Success',  // Title of the notification.
  message: 'This is a success notification.',  // Message content.
  type: NotificationType.success,  // The type of the notification (success, error, warning, info).
);

```

### Notification Types

    NotificationType.success: Green color notification for success messages.
    NotificationType.error: Red color notification for error messages.
    NotificationType.warning: Yellow color notification for warning messages.
    NotificationType.info: Blue color notification for informational messages.

Customization

You can customize the duration of the notification, its positioning, and other UI aspects like color, padding, and margin.
```dart
TNotificationOverlay.show(
  context: context,
  title: 'Info',
  message: 'This is an info notification.',
  type: NotificationType.info,
  duration: Duration(seconds: 5),  // Custom duration
);

```


# Example Usage

## Basic Notification

To show a simple notification with a title, subtitle, and custom type, use the `TNotificationOverlay.show()` method:

```dart
import 'package:flutter/material.dart';
import 'package:t_notification_widget/t_notification_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Notification Overlay Example')),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              TNotificationOverlay.show(
                context: context,
                title: Text('Success Notification'),
                subTitle: Text('This is a success notification.'),
                type: NotificationType.success,
                duration: Duration(seconds: 3),
                height: 80, // Adjust the height of the notification
                width: 350, // Adjust the width of the notification
                spacing: 8, // Space between stacked notifications
                position: NotificationPosition.topRight,
              );
            },
            child: Text('Show Notification'),
          ),
        ),
      ),
    );
  }
}
```

## Notification with Slide and Fade Animations

You can customize the slide-in and fade-out animations for your notifications:

```dart
import 'package:flutter/material.dart';
import 'package:t_notification_widget/t_notification_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Animated Notification Example')),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              TNotificationOverlay.show(
                context: context,
                title: Text('Warning Notification'),
                subTitle: Text('This is a warning notification.'),
                type: NotificationType.warning,
                duration: Duration(seconds: 3),
                slideInDirection: SlideDirection.left, // Slide from left
                slideOutDirection: SlideDirection.left, // Slide out to left
                height: 80,
                width: 350,
                spacing: 10,
                position: NotificationPosition.bottomLeft,
              );
            },
            child: Text('Show Animated Notification'),
          ),
        ),
      ),
    );
  }
}

```

## Custom Notification Design

Customize the appearance of the notification with various color options:

```dart
TNotificationOverlay.show(
  context: context,
  title: Text('Custom Notification'),
  subTitle: Text('This is a custom-styled notification.'),
  type: NotificationType.info,
  backgroundColor: Colors.blueAccent,
  borderColor: Colors.blue,
  titleColor: Colors.white,
  messageColor: Colors.white70,
  iconColor: Colors.white,
  borderRadius: 10.0,
  paddingVertical: 16.0,
  paddingHorizontal: 20.0,
  duration: Duration(seconds: 5),
  height: 100,
  width: 300,
  spacing: 12,
  position: NotificationPosition.topLeft,
);

```

## API Reference

- show(): Displays the notification with the provided parameters.
- context: The BuildContext of the widget.
- title: The title of the notification (required).
- subTitle: The subtitle of the notification (optional).
- type: The type of notification (success, error, warning, info) [default: NotificationType.info].
- duration: Duration for the notification to appear [default: Duration(seconds: 3)].
- spacing: Space between stacked notifications [default: 10.0].
- position: Position of the notification on the screen (topLeft, topRight, bottomLeft, bottomRight).
- slideInDirection: The direction from which the notification slides in (optional).
- slideOutDirection: The direction from which the notification slides out (optional).
- height, width: Dimensions of the notification box (optional).
- backgroundColor, borderColor, titleColor, messageColor, iconColor: Customize colors of the notification.
- paddingVertical, paddingHorizontal: Customize padding for the notification.
- borderRadius: Customize the border radius of the notification.
- onClose: Callback for handling notification close action.

## Notes

- You can customize the animation duration and slide direction according to your needs.
- The slideInDirection and slideOutDirection can be set to any of the following:
  - SlideDirection.left
  - SlideDirection.right
  - SlideDirection.top
  - SlideDirection.bottom
- The notification automatically dismisses after the specified duration unless manually closed with the onClose callback.



### Additional Information

- Contributions: If you'd like to contribute to this project, please open a pull request or submit an issue. Contributions are welcome to improve the UI or add new features.
- Issues: If you encounter any bugs or have suggestions for improvements, please file an issue in the repository.
- Support: The package is actively maintained, and issues are typically addressed within 1–2 business days.