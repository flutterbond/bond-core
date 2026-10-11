# Migrating to the bond_* 0.1 line

This release moves every Bond package to **Dart 3.13 / Flutter 3.47.7**, Riverpod 3 and
`package:material_ui`. Each package's `CHANGELOG.md` has the full list; this page is the short
version for app developers. To upgrade the Flutter Bond template itself, see
[flutter-bond/MIGRATION.md](https://github.com/flutterbond/flutter-bond/blob/main/MIGRATION.md).

## Versions

| Package | Before | Now |
|---|---|---|
| bond_core | 0.0.3 | 0.1.0 |
| bond_cache | 0.0.4+4 | 0.1.0 |
| bond_network | 0.0.11+11 | 0.1.0 |
| bond_form | 0.0.22+19 | 0.1.0 |
| bond_form_riverpod | 0.0.17+19 | 0.1.0 |
| bond_form_getx | 0.0.15+20 | 0.1.0 |
| bond_form_bloc | 0.0.1+15 | 0.1.0 |
| bond_notifications | 0.1.0 | 0.2.0 |
| bond_app_analytics | 0.1.0 | 0.2.0 |

All Flutter packages require `sdk: ^3.13.0` and `flutter: ">=3.47.0"`; `bond_app_analytics` (pure
Dart) requires `sdk: ^3.6.0`. The packages are 0.x, so each breaking change bumps the minor version.

```yaml
dependencies:
  bond_core: ^0.1.0
  bond_cache: ^0.1.0
  bond_network: ^0.1.0
  bond_form: ^0.1.0
  bond_form_riverpod: ^0.1.0   # with flutter_riverpod ^3.4.3
  bond_notifications: ^0.2.0
  bond_app_analytics: ^0.2.0
```

## Breaking changes

### bond_core
- `ThemeContext` / `ScaffoldContext` return `package:material_ui` types. Migrate your imports with
  `dart fix --apply --code=migrate_design_widgets`.
- `context.buttonTheme` is removed; use `Theme.of(context).buttonTheme` if you still need it.
- `get_it` 8 and 9 are both supported (`>=8.0.3 <10.0.0`). `ServiceProvider` and
  `ResponseDecoding` are unchanged.

### bond_network
- `BondFire()` creates a new instance on every call (no singleton since 0.0.11+11). Register it once:
  `it.registerLazySingleton<BondFire>(BondFire.new)` and resolve it with `sl<BondFire>()`.
- `equatable` 2 and 3 are supported. With equatable 3, `==` no longer compares `runtimeType`,
  `EquatableMixin` is gone (use `with Equatable`) and there is no generated `toString`.
- `faker` is no longer a dependency; `json_serializable` is a dev dependency (add it to your app if
  you run `build_runner`).
- Fixed: `Meta.from` reads the `from` key; `ServerError.fromJson` no longer throws on error bodies
  without `message`/`code` (it falls back to `'Unexpected server error'` / `'unknown'`).

### bond_form
- `Rules.dateAfter(date)` now really validates "after" (it returned a `DateBefore` rule). Re-check
  forms that relied on the inverted result.

### bond_form_riverpod (Riverpod 3)

| Before (0.0.x, Riverpod 2) | Now (0.1.0, Riverpod 3) |
|---|---|
| `extends AutoDisposeFormStateNotifier<...>` | `extends FormStateNotifier<...>` + `NotifierProvider.autoDispose(...)` |
| `extends AutoDisposeStepFormStateNotifier` / `...StepperFormStateNotifier` | `StepFormStateNotifier` / `StepperFormStateNotifier` + `.autoDispose` |
| `extends AutoDisposeFamilyFormStateNotifier<..., Arg>` with `build(Arg arg)` | `extends FamilyFormStateNotifier<..., Arg>` with `MyForm(super.arg)`, `build()` reads `arg`, provider `NotifierProvider.autoDispose.family` |

Run `dart fix --apply` after upgrading (bond_form_riverpod 0.1.1 or newer): it renames all six
`AutoDispose*` notifier names in your code. Switching the providers to `NotifierProvider.autoDispose`
and the family notifiers' `build(Arg arg)` to `MyForm(super.arg)` + `build()` is still manual.

The old `AutoDispose{Form,StepForm,StepperForm}StateNotifier` names still compile as deprecated
typedefs. Writes after the provider is disposed are ignored instead of throwing.

### bond_cache, bond_form_getx, bond_form_bloc, bond_notifications, bond_app_analytics
No API change; only the SDK floor and the new versions of the Bond packages they depend on.

## Rollback
pub.dev keeps every version: pin the previous ones (e.g. `bond_core: 0.0.3`,
`bond_form_riverpod: 0.0.17+19`) together with Flutter 3.27 or older. A broken release can be
retracted within 7 days with `dart pub retract` and replaced by a fixed patch release.
