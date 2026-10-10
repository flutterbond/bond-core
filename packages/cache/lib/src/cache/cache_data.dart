part of 'bond_cache.dart';

/// Represents data to be cached along with its expiration information.
@internal
class CacheData {
  final dynamic data;
  final DateTime? expiredAt;

  /// Constructs a [CacheData] instance with the provided [data] and [expiredAt] timestamp.
  CacheData({required this.data, required this.expiredAt});

  /// Checks if the cached data is still valid based on the [expiredAt] timestamp.
  bool get isValid =>
      expiredAt == null ? true : DateTime.now().isBefore(expiredAt!);

  /// Constructs a [CacheData] instance from a JSON representation.
  factory CacheData.fromJson(Map<String, dynamic> json) => CacheData(
    data: json['data'],
    expiredAt: json['expiredAt'] == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(json['expiredAt']),
  );

  /// Converts the [CacheData] instance to a JSON representation.
  Map<String, dynamic> toJson() => {
    'data': data,
    'expiredAt': expiredAt?.millisecondsSinceEpoch,
  };
}
