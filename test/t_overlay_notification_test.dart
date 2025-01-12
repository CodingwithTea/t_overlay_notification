import 'package:flutter_test/flutter_test.dart';
import 'package:t_overlay_notification/src/enums.dart';
import 'package:t_overlay_notification/t_overlay_notification.dart';
import 'package:flutter/material.dart';
import 'package:fake_async/fake_async.dart';

void main() {
  testWidgets('Notifications stack correctly', (WidgetTester tester) async {
    // Build the widget and wrap with MaterialApp
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              // Use post-frame callback to schedule notifications
              WidgetsBinding.instance.addPostFrameCallback((_) {
                TNotificationOverlay.show(
                  context: context,
                  title: 'Notification 1',
                  message: 'First notification',
                  type: NotificationType.info,
                );
                TNotificationOverlay.show(
                  context: context,
                  title: 'Notification 2',
                  message: 'Second notification',
                  type: NotificationType.warning,
                );
              });
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );

    // Ensure that the widget tree is updated
    await tester.pump();  // Wait for the widget to build the first frame

    // Let the widget settle after the first pump
    await tester.pumpAndSettle(); // Wait for the widget tree to settle and the notifications to appear

    // Use FakeAsync to simulate the time for the notifications and the timer
    FakeAsync().run((fakeAsync) async {
      // Flush any pending timers to ensure all async tasks complete
      fakeAsync.flushTimers(); // Flush all pending timers, especially those triggered by notifications
      await tester.pump(); // Make sure the UI is updated after flushing the timers

      // Verify both notifications are shown
      expect(find.text('Notification 1'), findsOneWidget);
      expect(find.text('Notification 2'), findsOneWidget);

      // Simulate the time delay for notifications to auto-dismiss (3 seconds)
      fakeAsync.elapse(const Duration(seconds: 3)); // Elapse 3 seconds to simulate the auto-dismiss
      await tester.pumpAndSettle(); // Wait for the UI to settle after dismissing the notifications
    });

    // Ensure that all async operations (like timers) are completed before ending the test
    await tester.pumpAndSettle();
  });

  testWidgets('Test Notification Dismissal', (WidgetTester tester) async {
    // Build the widget with a notification
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                TNotificationOverlay.show(
                  context: context,
                  title: 'Dismiss Me!',
                  message: 'This notification should auto-dismiss',
                  type: NotificationType.error,
                );
              });
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );

    // Let the widget build and settle
    await tester.pumpAndSettle();

    // Verify the notification is shown
    expect(find.text('Dismiss Me!'), findsOneWidget);

    // Use FakeAsync to simulate the passage of time (auto-dismiss behavior)
    FakeAsync().run((fakeAsync) {
      // Simulate the time to allow the notification to dismiss after 3 seconds
      fakeAsync.elapse(const Duration(seconds: 3)); // Elapse 3 seconds for dismissal
      tester.pumpAndSettle(); // Wait for UI to settle after the notification disappears
    });

    // Ensure the notification is no longer visible
    expect(find.text('Dismiss Me!'), findsNothing);
  });
}
