import 'package:bond_cache/src/cache/bond_cache.dart';
import 'package:mockito/mockito.dart';

class CacheObservableMixin with CacheObservable {}

class MockObserver<T> extends Mock implements CacheObserver<T> {
  MockObserver();

  @override
  void onDelete(String key) {
    super.noSuchMethod(Invocation.method(#onDelete, [key]));
  }

  @override
  void onUpdate(String key, T? newValue) {
    super.noSuchMethod(Invocation.method(#onUpdate, [key, newValue]));
  }
}
