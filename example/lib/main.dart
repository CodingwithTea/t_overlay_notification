import 'package:flutter/material.dart';
import 'package:t_overlay_notification/t_overlay_notification.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Notification Overlay Example')),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  TNotificationOverlay.show(
                    context: context,
                    title: Text('Success Notification'),
                    subTitle: Text(
                        'This is a success notification. \n Expanding to line two.'),
                    type: NotificationType.success,
                  );
                },
                child: Text('Success Notification'),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  TNotificationOverlay.show(
                    context: context,
                    title: Text('Warning Notification'),
                    subTitle: Text(
                        'This is a Warning notification. \n Expanding to line two.'),
                    type: NotificationType.warning,
                  );
                },
                child: Text('Warning Notification'),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  TNotificationOverlay.show(
                    context: context,
                    title: Text('Error Notification'),
                    subTitle: Text(
                        'This is a Error notification. \n Expanding to line two.'),
                    type: NotificationType.error,
                  );
                },
                child: Text('Error Notification'),
              ),
              ElevatedButton(
                onPressed: () {
                  TNotificationOverlay.show(
                    context: context,
                    title: Text('Info Notification'),
                    subTitle: Text(
                        'This is a Info notification. \n Expanding to line two.'),
                    type: NotificationType.info,
                  );
                },
                child: Text('Info Notification'),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  TNotificationOverlay.show(
                    context: context,
                    title: Text('Bottom Left Notification'),
                    subTitle: Text('This is a Bottom Left notification.'),
                    type: NotificationType.warning,
                    position: NotificationPosition.bottomLeft,
                    slideInDirection: SlideDirection.leftToRight,
                    // Slide from left
                    slideOutDirection:
                        SlideDirection.leftToRight, // Slide out to left
                  );
                },
                child: Text('Bottom Left Notification'),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  TNotificationOverlay.show(
                    context: context,
                    title: Text('Bottom Right Notification'),
                    subTitle: Text('This is a Bottom Right notification.'),
                    type: NotificationType.warning,
                    position: NotificationPosition.bottomRight,
                    slideInDirection: SlideDirection.rightToLeft,
                    // Slide from left
                    slideOutDirection:
                        SlideDirection.rightToLeft, // Slide out to left
                  );
                },
                child: Text('Bottom Right Notification'),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  TNotificationOverlay.show(
                    context: context,
                    width: 350,
                    spacing: 30,
                    title: Text('Warning Notification',
                        style: Theme.of(context).textTheme.titleLarge),
                    subTitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('This is a warning notification.'),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            TextButton(
                                onPressed: () {}, child: Text('Dismiss')),
                            const SizedBox(width: 8),
                            TextButton(onPressed: () {}, child: Text('Undo'))
                          ],
                        )
                      ],
                    ),
                    type: NotificationType.warning,
                    duration: Duration(seconds: 3),
                    position: NotificationPosition.bottomLeft,
                    slideInDirection: SlideDirection.leftToRight,
                    // Slide from left
                    slideOutDirection:
                        SlideDirection.leftToRight, // Slide out to left
                  );
                },
                child: Text('Custom Notification with Buttons'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
