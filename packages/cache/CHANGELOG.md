# Changelog

## 0.1.0

### Breaking
- Requires Dart 3.13 and Flutter 3.47 or newer.
- Depends on `bond_core: ^0.1.0` (material_ui based). No API change in `bond_cache` itself.

### Changed
- Removed the library name (`library bond_cache;` -> `library;`) and reformatted with the Dart 3.13 formatter.
- Tests cleaned up for `flutter_lints` 6 (no behaviour change).

## 0.0.4+4
- Added export for `src/cache/bond_cache.dart` with `CacheData` hidden in `bond_cache.dart`.
- Fix `store` method to return `BondCache` from `sl` instead of `CacheDriver`.

## 0.0.4+1
- **dev_dependencies:** Updated the `async` package to `^2.13.0` to resolve package validation warnings.

## 0.0.4

### Changed
- Bumped `bond_core` from `^0.0.2` to `^0.0.3`.
- Bumped `shared_preferences` from `^2.2.3` to `^2.5.2`.
- Bumped `meta` from `^1.11.0` to `^1.15.0`.
- Updated dev dependencies:
    - `test`: ^1.24.6 → ^1.25.15
    - `mockito`: ^5.4.2 → ^5.4.5

> **Note**: These updates ensure compatibility with the latest `bond_core` changes and other improved packages.

---

## 0.0.3+1
- Added support for nullable registered types in the cache package.

## 0.0.3
### Added
- `watch`, `unwatch`, and `stream` methods to the Cache class to support reactive caching patterns.

### Fixed
- Type safety enforcement in cache updates to prevent runtime type errors.

### Changed
- Improved error handling in Cache operations to provide clearer error messages.

## 0.0.2+3
* update bond_core dependency.
* improve code quality & write tests.

## 0.0.2+2
* update bond_core dependency.
* add readme.md file.
* add example.md file.

## 0.0.2+1

* add missing getAll methods.

## 0.0.2

* no need to pass factory for custom object caching.
* improve code quality & write tests.

## 0.0.1+2

* update bond_core dependency.

## 0.0.1+1

* add missing flutter sdk as dependency.

## 0.0.1
