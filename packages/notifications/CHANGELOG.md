## 0.2.0

### Breaking
- Requires Dart 3.13 and Flutter 3.47 or newer.
- Depends on `bond_core: ^0.1.0` and `bond_network: ^0.1.0` (material_ui based `bond_core`,
  `equatable` 3 / `package_info_plus` 10 ranges in `bond_network`).

### Changed
- Library names removed (`library;`).

## 0.1.0

### Breaking Changes
- **Environment SDK Constraint:** Updated from `>=2.16.0 <3.0.0` to `>=3.0.0 <4.0.0` to support Dart 3. Users on Dart 2.x will need to upgrade.
- **json_annotation:** Added `json_annotation` as a direct dependency. Users will need to add
  `json_annotation` to their dependencies if they are using the `ServerNotificationModel` class.

## 0.0.2

### Changed
- **Dependencies Updated:**
    - **bond_core:** upgraded from `^0.0.2` to `^0.0.3`.
    - **bond_network:** upgraded from `^0.0.5` to `^0.0.6`.

## 0.0.1+5

* add `title` property to `ServerNotificationModel` class.
* update bond_network dependency.
* update bond_core dependency.

## 0.0.1+4

* update bond_network dependency.
* update bond_core dependency.

## 0.0.1+3

* update bond_network dependency.
* update bond_core dependency.

## 0.0.1+2

* update bond_network dependency.

## 0.0.1+1

* add missing flutter sdk as dependency.

## 0.0.1

* initial release.