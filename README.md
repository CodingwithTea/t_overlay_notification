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
  t_overlay_notification: ^1.0.0
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

### Additional Information

    Contributions: If you'd like to contribute to this project, please open a pull request or submit an issue. Contributions are welcome to improve the UI or add new features.
    Issues: If you encounter any bugs or have suggestions for improvements, please file an issue in the repository.
    Support: The package is actively maintained, and issues are typically addressed within 1–2 business days.