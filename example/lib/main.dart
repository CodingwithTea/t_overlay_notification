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
      home: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(title: Text('Notification Overlay Example')),
          body: Center(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    TNotificationOverlay.success(
                      context: context,
                      title: 'Success Notification',
                      subTitle:
                          'This is a success notification. \n Expanding to line two.',
                    );
                  },
                  child: Text('Success Notification'),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    TNotificationOverlay.warning(
                      context: context,
                      title: ('Warning Notification'),
                      subTitle:
                          ('This is a Warning notification. \n Expanding to line two.'),
                    );
                  },
                  child: Text('Warning Notification'),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    TNotificationOverlay.error(
                      context: context,
                      title: ('Error Notification'),
                      subTitle:
                          ('This is a Error notification. \n Expanding to line two.'),
                    );
                  },
                  child: Text('Error Notification'),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    TNotificationOverlay.info(
                      context: context,
                      title: ('Info Notification'),
                      subTitle:
                          ('This is a Info notification. \n Expanding to line two.'),
                    );
                  },
                  child: Text('Info Notification'),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    TNotificationOverlay.show(
                      context: context,
                      title: ('Default Notification'),
                      subTitle:
                          ('This is a Default notification. \n At the center.'),
                    );
                  },
                  child: Text('Default Notification'),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    TNotificationOverlay.info(
                      context: context,
                      title: ('Info Notification'),
                    );
                  },
                  child: Text('Info Single Line Notification'),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    TNotificationOverlay.show(
                        sticky: true,
                        context: context,
                        title: ('Sticky Notification'),
                        subTitle:
                            'This is a sticky notification with action Widget',
                        position: NotificationPosition.topLeft,
                        slideInDirection: SlideDirection.topToBottom,
                        slideOutDirection: SlideDirection.bottomToTop,
                        action: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Choose any options below',
                                style: TextStyle(color: Colors.white)),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      'Dismiss',
                                      style: TextStyle(color: Colors.white),
                                    )),
                                const SizedBox(width: 8),
                                TextButton(
                                    onPressed: () {},
                                    child: Text('Undo',
                                        style: TextStyle(color: Colors.white)))
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text('Close this notification manually.',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                            const SizedBox(height: 12),
                          ],
                        ));
                  },
                  child: Text('Sticky Notification'),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    TNotificationOverlay.show(
                      context: context,
                      title: ('Bottom Left Notification'),
                      subTitle: ('This is a Bottom Left notification.'),
                      type: NotificationType.info,
                      position: NotificationPosition.bottomLeft,
                      slideInDirection: SlideDirection.leftToRight,
                      slideOutDirection: SlideDirection.leftToRight,
                    );
                  },
                  child: Text('Bottom Left Notification'),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    TNotificationOverlay.show(
                      context: context,
                      title: ('Bottom Right Notification'),
                      subTitle: ('This is a Bottom Right notification.'),
                      type: NotificationType.info,
                      position: NotificationPosition.bottomRight,
                      slideInDirection: SlideDirection.rightToLeft,
                      slideOutDirection: SlideDirection.rightToLeft,
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
                      title: 'Custom Notification',
                      subTitle: 'This is a custom notification',
                      action: Row(
                        children: [
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                'Dismiss',
                                style: TextStyle(color: Colors.white),
                              )),
                          const SizedBox(width: 8),
                          TextButton(
                              onPressed: () {},
                              child: Text('Undo',
                                  style: TextStyle(color: Colors.white)))
                        ],
                      ),
                      type: NotificationType.info,
                      duration: Duration(seconds: 3),
                      position: NotificationPosition.bottomLeft,
                      slideInDirection: SlideDirection.leftToRight,
                      slideOutDirection: SlideDirection.leftToRight,
                    );
                  },
                  child: Text('Custom Notification with Buttons'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
