### Changelog
## 0.0.11+11
- Remove the bond fire singleton factory.

## 0.0.11+9
### Fixed
- Fixed cache writes not completing before `execute()` returns in tests.
  - Added microtask flush after cache writes to ensure `FlutterSecureStorage` mock operations complete synchronously.
  - This resolves flaky tests where assertions ran before cache was updated.

## 0.0.11+4
### Added
- Added `this.total` property to the `Meta` model.
- Updated `bond_cache` dependency to `^0.0.4+3`.
- Refactored custom cache key handling in BaseBondApiRequest to support caching with explicit data types.
- Support factory on `cacheCustomKey` method.
- Fix `cache` method to return `T` instead of `dynamic`.
- Fix `_factory` method should take response after `_dataTransformer` done.
- Improve cache handling in `GetBondApiRequest`.
- Add new CachePolicy `cacheFirst` to read from cache first, if not found then read from network and save to cache.

## 0.0.10
### Added
- Added `patch` method to `BondFire` to support PATCH HTTP requests.
- Included DartDocs for the `patch` method.


## 0.0.9
### Added
- `map()` / `transform()` method in `BondFire` to mutate or transform raw API response before decoding.
    - Useful for cases where the API returns a list instead of a map, e.g.:
      ```dart
      _api
        .get<HomeCms>(url)
        .map((data) => { "date": data })
        .execute();
      ```
      
## 0.0.8
### Added
- Introduced `_cacheStore` property to `GetBondApiRequest<T>` for selecting a custom cache store.
- Added full Dart documentation for all public methods and properties in `GetBondApiRequest`.
- Add Readme to the package.
- Add example to the package.

## 0.0.7
### Added
- **Cancel Token Support:** Added support for cancel tokens in API requests to allow for request cancellation.


## 0.0.6

### Changed
- **Dependencies Updated:**
    - **dio:** upgraded from `^5.2.1+1` to `^5.8.0+1`.
    - **equatable:** upgraded from `^2.0.5` to `^2.0.7`.
    - **json_annotation:** upgraded from `^4.8.1` to `^4.9.0`.
    - **json_serializable:** upgraded from `^6.7.1` to `^6.9.3`.
    - **package_info_plus:** upgraded from `^4.1.0` to `^8.2.1`.
    - **meta:** upgraded from `^1.8.0` to `^1.15.0`.
    - **faker:** upgraded from `^2.0.0` to `^2.2.0`.
- **Bond Dependencies Updated:**
    - **bond_core:** upgraded from `^0.0.1` to `^0.0.3`.
    - **bond_cache:** upgraded from `^0.0.1` to `^0.0.4+1`.

## 0.0.5

* support form data multipart request.


## 0.0.4

* add currentPage property to Meta class.

## 0.0.3+1

* Update `bond_core` dependency.

## 0.0.3

- Introduced `XListResponse` extension for `ListResponse` objects.
    - New `merge` method to combine two `ListResponse` instances into a single instance.
        - Merges the `data` arrays.
        - Takes `meta` and `links` from the second `ListResponse`.
    - Use Cases:
        1. Combine paginated responses.
        2. Aggregate data from different sources.
        3. Update existing `ListResponse` with new data while preserving `meta` and `links`.

## 0.0.2+1

* Export `DoubleConverter` to `BondNetwork`'s `converters` list.

## 0.0.2

* Introduced `DoubleConverter` class to handle flexible JSON field types.
    - Converts incoming JSON values to `double`.
    - Supports `String`, `int`, and `double` as input types.
    - Provides a default value fallback in case of conversion failure.
    - Enhanced logging within `DoubleConverter` for better debugging.

## 0.0.1+5

* fix caching when select cacheThenNetwork policy

## 0.0.1+4

* update bond_cache dependency.
* update bond_core dependency.

## 0.0.1+3

* fix read api return status code 403.

## 0.0.1+2

* handle the case where error.response!.data is string

## 0.0.1+1

* update bond_network package.

## 0.0.1

* initial release.