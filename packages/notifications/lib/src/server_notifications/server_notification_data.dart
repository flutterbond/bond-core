import 'package:bond_network/bond_network.dart';

import '../server_notifications.dart';

class ServerNotificationData {
  final SeverNotificationChangedType type;
  final ListResponse<ServerNotificationModel> data;

  ServerNotificationData({required this.type, required this.data});
}
