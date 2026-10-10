import 'dart:convert';
import 'dart:math';

import '../errors/exceptions.dart';

class ServerExceptionFactory {
  static ServerException create({
    String? code,
    String? message,
    int? statusCode,
  }) {
    return ServerException.fromResponse(
      json.encode({
        'code': code ?? _randomString(12),
        'message': message ?? _randomString(24),
      }),
      statusCode ?? 403,
    );
  }

  static const _chars =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  static final _random = Random();

  /// Returns a random alphanumeric string of [length] characters.
  static String _randomString(int length) => String.fromCharCodes(
    Iterable.generate(
      length,
      (_) => _chars.codeUnitAt(_random.nextInt(_chars.length)),
    ),
  );
}
