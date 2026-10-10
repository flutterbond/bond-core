import 'package:bond_core/bond_core.dart';

import '../notifications_core.dart';
import 'push_notification.dart';
import 'push_notifications_service_provider_mixin.dart';

mixin ActionablePushNotification on PushNotification {
  void onNotificationTapped(NotificationData data);
}

mixin ActionableNotification on NotificationProvider {
  void onNotificationTapped(NotificationData data) {
    final featureProviders = appProviders
        .whereType<PushNotificationServiceProviderMixin>();
    for (final featureProvider in featureProviders) {
      featureProvider.handlePushNotificationAction(data);
    }
  }
}
