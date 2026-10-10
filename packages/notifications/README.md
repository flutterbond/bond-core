# bond_notifications

Notification building blocks for [Flutter Bond](https://github.com/flutterbond/flutter-bond) apps:
push notifications from any number of channels (e.g. Firebase Cloud Messaging) and an in-app
notification center backed by your server.

Requires Dart 3.13 / Flutter 3.47 or newer.

## Install

```yaml
dependencies:
  bond_notifications: ^0.2.0
```

## Push notifications

Implement `PushNotificationProvider` for each push channel. It exposes the device `token`
(and `apnsToken`), `onTokenRefresh`, and streams of `NotificationData` (a `Map<String, dynamic>`):
`onNotification`, `onNotificationTapped`, `onNotificationDismiss` and `initialNotification`.

Combine your channels in `PushNotificationsProviders` and start listening at app start:

```dart
import 'package:bond_core/bond_core.dart';
import 'package:bond_notifications/bond_notifications.dart';

sl.registerLazySingleton<PushNotificationsProviders>(
  () => PushNotificationsProviders(
    pushNotificationProviders: [MyFirebaseMessagingProvider()],
  ),
);

sl<PushNotificationsProviders>().listen();
```

When a notification is tapped, every registered `ServiceProvider` that mixes in
`PushNotificationServiceProviderMixin` receives it in `handlePushNotificationAction(data)`, so each
feature can route its own notifications.

## Notification center

`ServerNotificationsProvider` (and `NotificationCenterProvider` with a
`NotificationCenterDataSource`) loads the user's notifications from your API and exposes
`notifications` and `unreadNotificationsCount` streams plus `load()`, `read()`, `readAll()` and
`onTap()`.

The Flutter Bond template wires both up from its notification config; see
`lib/providers/notifications_service_provider.dart` there.
