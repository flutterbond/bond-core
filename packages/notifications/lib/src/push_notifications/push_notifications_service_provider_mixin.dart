import 'dart:developer';

import 'package:bond_core/bond_core.dart';

import '../core/notification_data.dart';
import 'actionable_push_notification.dart';
import 'push_notification.dart';

mixin PushNotificationServiceProviderMixin on ServiceProvider {
  List<PushNotification> get pushNotifications;

  void handlePushNotification(NotificationData data) {
    log('try to handlePushNotification: $data');
    final String? code = data['code'];
    for (final pushNotification in pushNotifications) {
      if (pushNotification.code.contains(code)) {
        pushNotification.onNotification(data);
      }
    }
  }

  void handlePushNotificationAction(NotificationData data) {
    log('try to handlePushNotificationAction: $data');
    final String? code = data['code'] ?? data['item_type'];
    final actionablePushNotifications = pushNotifications
        .whereType<ActionablePushNotification>();
    for (final pushNotification in actionablePushNotifications) {
      if (pushNotification.code.contains(code)) {
        pushNotification.onNotificationTapped(data);
      }
    }
  }
}
