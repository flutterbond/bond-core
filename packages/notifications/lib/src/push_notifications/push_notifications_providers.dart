import 'dart:async';
import 'dart:developer';

import 'package:bond_core/bond_core.dart';

import '../notifications_core.dart';
import '../push_notifications.dart';

class PushNotificationsProviders extends NotificationProvider
    with ActionableNotification {
  final List<PushNotificationProvider> pushNotificationProviders;

  PushNotificationsProviders({required this.pushNotificationProviders});

  final List<StreamSubscription<NotificationData>>
  _onNotificationsStreamsSubscriptions = [];
  final List<StreamSubscription<NotificationData>>
  _onNotificationsTappedStreamsSubscriptions = [];

  @override
  void listen() {
    for (final pushNotificationProvider in pushNotificationProviders) {
      final onPushNotificationStreamSubscription = pushNotificationProvider
          .onNotification
          .listen(onNotification);
      _onNotificationsStreamsSubscriptions.add(
        onPushNotificationStreamSubscription,
      );
    }

    for (final pushNotificationProvider in pushNotificationProviders) {
      final onPushNotificationTappedStreamSubscription =
          pushNotificationProvider.onNotificationTapped.listen(
            onNotificationTapped,
          );
      _onNotificationsTappedStreamsSubscriptions.add(
        onPushNotificationTappedStreamSubscription,
      );
    }
  }

  @override
  void onNotification(Map<String, dynamic> data) {
    log('onNotification: $data');
    final featureProviders = appProviders
        .whereType<PushNotificationServiceProviderMixin>();
    for (final featureProvider in featureProviders) {
      featureProvider.handlePushNotification(data);
    }
  }

  @override
  Future<void> dispose() async {
    for (final streamSubscription in _onNotificationsStreamsSubscriptions) {
      await streamSubscription.cancel();
    }

    for (final streamSubscription
        in _onNotificationsTappedStreamsSubscriptions) {
      await streamSubscription.cancel();
    }
  }
}
