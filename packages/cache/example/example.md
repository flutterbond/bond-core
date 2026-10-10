## Basic usage:

```dart
import 'package:bond_cache/bond_cache.dart';

// Example usage
final user = Cache.get<User>('user', defaultValue: User(id: 1, name: 'Default User'));

// Update the cache
Cache.put<User>('user', User(id: 2, name: 'SALAH'));

// Retrieve the updated value
final updatedUser = Cache.get<User>('user');
print('User: ${updatedUser.name}');

// Check if the key exists
final exists = Cache.has('user');
print('User exists: $exists');

// Remove the value from the cache
Cache.forget('user');
```

## Documentation

For a comprehensive guide on how to use `bond_cache`, please refer to the full documentation available in the `bond_docs` repository under the `cache.md` file.

[Read Full Documentation Here](https://github.com/flutterbond/bond-docs/blob/main/caching.md)