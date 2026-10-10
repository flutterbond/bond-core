# bond_app_analytics

A small, backend-agnostic analytics layer for [Flutter Bond](https://github.com/flutterbond/flutter-bond)
apps. Your code fires `AnalyticsEvent`s; one or more `AnalyticsProvider`s (Firebase Analytics,
Mixpanel, your own backend, ...) decide how to record them.

Pure Dart, no dependencies (`sdk: ^3.6.0`).

## Install

```yaml
dependencies:
  bond_app_analytics: ^0.2.0
```

## Events

An event has a `key`, `params` and, optionally, a standard `systemEventType`
(`SystemEvents.signedIn`, `viewItem`, `addToCart`, `madePurchase`, `search`, ...):

```dart
import 'package:bond_app_analytics/bond_app_analytics.dart';

class PostOpened extends AnalyticsEvent {
  PostOpened(this.postId);

  final int postId;

  @override
  String get key => 'post_opened';

  @override
  Map<String, dynamic> get params => {'post_id': postId};
}
```

For a standard event, also mix in its data mixin (e.g. `UserSignedIn`, `UserViewItem`) and return
the matching `systemEventType`.

## Providers

Implement `AnalyticsProvider` once per analytics backend. `log(event)` routes standard events to the
matching `log*` method (`logSignedIn`, `logViewItem`, ...) and everything else to `logEvent`; any
`log*` method you don't override falls back to `logEvent`.

```dart
class ConsoleAnalyticsProvider extends AnalyticsProvider {
  @override
  void logEvent(AnalyticsEvent event) => print('${event.key} ${event.params}');

  @override
  void setUserId(int userId) => print('user $userId');

  @override
  void setUserAttributes(Map<String, dynamic> attributes) => print(attributes);
}

ConsoleAnalyticsProvider().log(PostOpened(42));
```

The Flutter Bond template registers its providers (e.g. a Firebase Analytics provider) in get_it and
fans every event out to all of them; see `lib/core/app_analytics.dart` there.
