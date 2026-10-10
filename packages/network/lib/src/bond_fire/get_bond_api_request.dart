part of 'base_bond_api_request.dart';

/// A specialized GET request class that supports caching and streaming.
///
/// This class extends [BaseBondApiRequest] and introduces caching strategies
/// using the [BondCache] package. You can configure it to retrieve data from
/// cache, network, or a combination of both.
class GetBondApiRequest<T extends Jsonable> extends BaseBondApiRequest<T> {
  Duration? _cacheDuration;
  String? _cacheKey;
  CachePolicy _cachePolicy = CachePolicy.networkOnly;

  /// Constructs a [GetBondApiRequest] with the given Dio client and API path.
  ///
  /// - Parameters:
  ///   - [dio]: The Dio client for executing HTTP requests.
  ///   - [path]: The endpoint URL path for the GET request.
  GetBondApiRequest(super.dio, super.path) : super(method: 'GET');

  /// Configures caching for the GET request.
  ///
  /// - Parameters:
  ///   - [duration]: The time duration to keep the cache valid.
  ///   - [cacheKey]: The custom key for storing the cache.
  ///   - [cachePolicy]: The cache policy to apply.
  ///   - [store]: Optional custom cache store name.
  ///
  /// - Returns: The current [GetBondApiRequest] instance for chaining.
  GetBondApiRequest<T> cache({
    Duration? duration,
    String? cacheKey,
    CachePolicy? cachePolicy,
  }) {
    _cacheDuration = duration ?? _cacheDuration;
    _cacheKey = cacheKey ?? _path;
    _cachePolicy = cachePolicy ?? _cachePolicy;
    return this;
  }

  /// Executes the request according to the selected [CachePolicy].
  ///
  /// - Returns: The response of type [T].
  @override
  Future<T> execute() async {
    if (_cacheKey != null) {
      final hasCache = Cache.has(_cacheKey!);
      switch (_cachePolicy) {
        case CachePolicy.cacheOnly:
          if (hasCache) {
            final cachedValue = Cache.get<T?>(
              _cacheKey!,
              fromJsonFactory: _factory,
            );
            if (cachedValue != null) {
              return cachedValue; // Skip network entirely
            }
          }
          return await _executeAndCache();
        case CachePolicy.cacheElseNetwork:
          if (hasCache) {
            final cachedValue = Cache.get<T?>(
              _cacheKey!,
              fromJsonFactory: _factory,
            );
            if (cachedValue == null) {
              return await _executeAndCache();
            }
            _executeAndCache();
            return cachedValue;
          } else {
            return await _executeAndCache();
          }
        case CachePolicy.networkElseCache:
          try {
            return await _executeAndCache();
          } catch (_) {
            if (hasCache) {
              final cachedValue = Cache.get<T?>(
                _cacheKey!,
                fromJsonFactory: _factory,
              );
              if (cachedValue != null) {
                return cachedValue;
              }
            }
            rethrow;
          }
        case CachePolicy.networkOnly:
          return await super.execute();
        case CachePolicy.cacheThenNetwork:
          return throw UnsupportedError('Use streamExecute method directly');
      }
    } else {
      return super.execute();
    }
  }

  Stream<T> streamExecute() {
    if (_cachePolicy == CachePolicy.cacheThenNetwork) {
      return _executeCacheThenNetwork();
    } else {
      throw UnsupportedError(
        'Use execute method for cache policies other than cacheThenNetwork',
      );
    }
  }

  Future<T> _executeAndCache() async {
    final result = await super.execute();
    await Cache.put<T>(_cacheKey!, result, expiredAfter: _cacheDuration);
    return result;
  }

  Stream<T> _executeCacheThenNetwork() async* {
    if (_cacheKey != null) {
      final hasCache = Cache.has(_cacheKey!);
      if (hasCache) {
        final cachedValue = Cache.get<T?>(
          _cacheKey!,
          fromJsonFactory: _factory,
        );
        if (cachedValue != null) {
          yield cachedValue;
        }
      }
    }
    yield await _executeAndCache();
  }
}
