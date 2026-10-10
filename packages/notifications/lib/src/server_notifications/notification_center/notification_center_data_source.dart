import 'package:bond_network/bond_network.dart';

import '../../server_notifications.dart';

abstract class NotificationCenterDataSource extends DataSource {
  Future<ListResponse<ServerNotificationModel>> loadNotifications({
    String? nextUrl,
  });

  Future<void> read(String uuid);

  Future<void> readAll();
}
