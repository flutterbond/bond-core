import 'dart:async';

import '../../notifications_core.dart';
import '../../push_notifications.dart';
import '../../server_notifications.dart';

class NotificationCenterProvider extends NotificationProvider
    with ServerNotificationsProvider, ActionableNotification {
  final PushNotificationProvider pushNotificationProvider;
  final NotificationCenterDataSource notificationCenterDataSource;

  NotificationCenterProvider({
    required this.pushNotificationProvider,
    required this.notificationCenterDataSource,
  });

  final serverNotificationStreamController =
      StreamController<ServerNotificationData>.broadcast();

  @override
  Stream<int> get unreadNotificationsCount =>
      serverNotificationStreamController.stream.map(
        (event) =>
            event.data.data.where((element) => element.readAt == null).length,
      );

  @override
  Stream<ServerNotificationData> get notifications =>
      serverNotificationStreamController.stream;

  ServerNotificationData? currentServerNotificationData;

  @override
  void load({bool reset = false}) async {
    if (currentServerNotificationData != null && !reset) {
      _loadNextPage(currentServerNotificationData!);
    } else {
      _load();
    }
  }

  @override
  void read(ServerNotificationModel notification) async {
    if (currentServerNotificationData == null) return;
    await notificationCenterDataSource.read(notification.uuid);
    final oldResponse = currentServerNotificationData!.data;
    final newData = oldResponse.data
        .map(
          (element) => element.uuid == notification.uuid
              ? element.copyWith(readAt: DateTime.now())
              : element,
        )
        .toList();
    final newResponse = oldResponse.copyWith(data: newData);
    final newServerNotificationData = ServerNotificationData(
      type: SeverNotificationChangedType.loaded,
      data: newResponse,
    );
    serverNotificationStreamController.add(newServerNotificationData);
    currentServerNotificationData = newServerNotificationData;
  }

  @override
  void readAll() async {
    if (currentServerNotificationData == null) return;
    await notificationCenterDataSource.readAll();
    final oldResponse = currentServerNotificationData!.data;
    final newData = oldResponse.data
        .map((element) => element.copyWith(readAt: DateTime.now()))
        .toList();
    final newResponse = oldResponse.copyWith(data: newData);
    final newServerNotificationData = ServerNotificationData(
      type: SeverNotificationChangedType.loaded,
      data: newResponse,
    );
    serverNotificationStreamController.add(newServerNotificationData);
    currentServerNotificationData = newServerNotificationData;
  }

  @override
  void onTap(ServerNotificationModel notification) {
    read(notification);
    onNotificationTapped(
      notification.data..putIfAbsent('code', () => notification.code),
    );
  }

  StreamSubscription<NotificationData>? _streamsSubscriptions;

  @override
  void listen() {
    _streamsSubscriptions = pushNotificationProvider.onNotification.listen(
      onNotification,
    );
  }

  @override
  void onNotification(Map<String, dynamic> data) async {
    final notifications = await notificationCenterDataSource
        .loadNotifications();
    serverNotificationStreamController.add(
      ServerNotificationData(
        type: SeverNotificationChangedType.loaded,
        data: notifications,
      ),
    );
    final newServerNotificationData = ServerNotificationData(
      type: SeverNotificationChangedType.loaded,
      data: notifications,
    );
    currentServerNotificationData = newServerNotificationData;
  }

  @override
  Future<void> dispose() async {
    await _streamsSubscriptions?.cancel();
  }

  void _load() async {
    final newResponse = await notificationCenterDataSource.loadNotifications();
    final newServerNotificationData = ServerNotificationData(
      type: SeverNotificationChangedType.loaded,
      data: newResponse,
    );
    serverNotificationStreamController.add(newServerNotificationData);
    currentServerNotificationData = newServerNotificationData;
  }

  void _loadNextPage(ServerNotificationData serverNotifications) async {
    serverNotificationStreamController.add(
      ServerNotificationData(
        type: SeverNotificationChangedType.loadingNextPage,
        data: serverNotifications.data,
      ),
    );
    final newResponse = await notificationCenterDataSource.loadNotifications(
      nextUrl: serverNotifications.data.links?.next,
    );
    final oldData = serverNotifications.data.data;
    final combinedData = oldData.followedBy(newResponse.data).toList();
    final newServerNotificationData = ServerNotificationData(
      type: SeverNotificationChangedType.loaded,
      data: newResponse.copyWith(data: combinedData),
    );
    serverNotificationStreamController.add(newServerNotificationData);
    currentServerNotificationData = newServerNotificationData;
  }
}
