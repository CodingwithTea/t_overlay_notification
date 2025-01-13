# Changelog

## 0.0.6
- Added new helper function for ease **TNotificationOverlay.success**, **error**, **warning**, and **info**

## 0.0.5
- Example Added.

## 0.0.4
- Introduced New **Animations**: Added support for **slide-in** **slide-out** and **fade-out** animations for more engaging notifications.
- Fixed Dynamic **Height Calculation**: Improved notification stacking by dynamically calculating the height of each notification, ensuring consistent spacing between them.
- Bug Fixes: Addressed various layout issues, including proper positioning and removing notifications after the specified duration.
- Performance Improvements: Optimized the overlay handling for better performance, especially with a large number of notifications.
- Enhanced Customization: Added more control over animations, allowing users to specify both slide-in and slide-out directions.

## 0.0.3
- Added **LinerProgressIndicator** feature for interactive countdown notifications.
- Improved **Design** with a more modern, sleek look for notifications.
- Enhanced positioning options for notifications to support `topLeft`, `topRight`, `bottomLeft`, and `bottomRight`.
- Introduced **GlobalKey** for better control over notification rendering.
- Fixed stacking issue and dynamic spacing between notifications.
- Now you can use **height** variable to adjust height of the notifications.

## 0.0.2
- Easily use enums to choose **Notification Type**.
- `NotificationType.info` is now **Default Notification Type**.

## 0.0.1
- Initial release with support for success, error, warning, and info notifications.
- **Stacking notifications** are supported.
- Customizable **duration** for notification auto-dismiss.
