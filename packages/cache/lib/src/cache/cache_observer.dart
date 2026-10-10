part of 'bond_cache.dart';

extension CacheObserverMap on Map<String, List<CacheObserver>> {
  /// Removes all observers associated with the specified key and closes any associated streams.
  /// Returns the list of observers that were removed.
  List<CacheObserver> removeObservers(String key) {
    // Early return if the key is not found to avoid deep nesting.
    if (!containsKey(key)) {
      return [];
    }

    // Retrieve and close all associated stream controllers if necessary.
    final observers = this[key] ?? [];
    for (final observer in observers) {
      if (observer is ObserverWrapper &&
          observer.observer is StreamCacheObserver) {
        (observer.observer as StreamCacheObserver).controller.close();
      }
    }

    // Remove the key from the map and return the list of removed observers.
    return remove(key) ?? [];
  }
}

extension CacheObserverList on List<CacheObserver> {
  /// Checks if the list contains a specific observer wrapped in `ObserverWrapper`.
  bool containsObserver(CacheObserver observer) {
    return any((o) => o is ObserverWrapper && o.observer == observer);
  }

  /// Retrieves all `StreamCacheObserver` instances from the list.
  List<StreamCacheObserver> streamObservers() {
    return where(
          (o) => o is ObserverWrapper && o.observer is StreamCacheObserver,
        )
        .map((o) => (o as ObserverWrapper).observer as StreamCacheObserver)
        .toList();
  }

  /// Removes an observer from the list and closes its stream if it is a `StreamController`.
  bool removeObserver(CacheObserver observer) {
    var found = false;
    var index = 0;
    while (index < length) {
      var current = this[index];
      if (current == observer) {
        if (current is ObserverWrapper &&
            current.observer is StreamCacheObserver) {
          (current.observer as StreamCacheObserver).controller.close();
        }
        removeAt(index);
        found = true;
      } else {
        index++;
      }
    }
    return found;
  }
}

abstract class CacheObserver<T> {
  void onUpdate(String key, T newValue);

  void onDelete(String key);
}

class ObserverWrapper<T> implements CacheObserver<T> {
  final CacheObserver<T> observer;
  final String key;
  final String identifier;

  ObserverWrapper(this.observer, this.key)
    : identifier = _generateUniqueId(key);

  static String _generateUniqueId(String key) {
    return '${DateTime.now().microsecondsSinceEpoch}_$key';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ObserverWrapper && other.identifier == identifier;
  }

  @override
  int get hashCode => identifier.hashCode;

  @override
  void onDelete(String key) {
    observer.onDelete(key);
  }

  @override
  void onUpdate(String key, T newValue) {
    observer.onUpdate(key, newValue);
  }
}

class StreamCacheObserver<T> implements CacheObserver<T> {
  final StreamController<T> controller;

  StreamCacheObserver(this.controller);

  @override
  void onDelete(String key) {
    // how to handle this?
  }

  @override
  void onUpdate(String key, T newValue) {
    controller.add(newValue);
  }
}
