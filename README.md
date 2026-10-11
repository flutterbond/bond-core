<p align="center"><a href="https://laravel.com" target="_blank"><img src="https://raw.githubusercontent.com/flutterbond/flutter-bond/5e75d3b52e12536478dc9b40455299f3f4e5c9cc/assets/images/app_logo.svg" width="400" alt="Flutter Bond Logo"></a></p>

[![melos](https://img.shields.io/badge/maintained%20with-melos-f700ff.svg?style=flat-square)](https://github.com/invertase/melos)

# Bond: The Flutter Framework That Bonds Your App Together

Bond Core is the foundational library for the Bond framework that makes Flutter development a breeze. It streamlines your Flutter workflow by providing robust solutions for state management, authentication, theming, service provider registration, and caching. Plus, it offers built-in integrations for app analytics and notifications. The Bond framework is designed to enhance your productivity and efficiency by providing a unified and simplified API for common Flutter tasks. Regardless of the size of your project, Bond's modular and scalable design makes it the perfect partner for your Flutter journey.

## Bond Packages: The Building Blocks

Bond comprises multiple packages that can be integrated as per the requirements of your project. Below are the packages included in the Bond framework:

| Package Name        | Description | Pub.dev | View Source |
|---------------------|-------------|---------|-------------|
| Bond Core           | The central hub of the Bond framework, housing fundamental utilities and infrastructure that the rest of the packages rely on. | [![bond_core](https://img.shields.io/pub/v/bond_core.svg)](https://pub.dev/packages/bond_core) | [Source](https://github.com/flutterbond/bond-core/tree/main/packages/core) |
| Bond Network        | A robust package that simplifies API interactions and network operations. | [![bond_network](https://img.shields.io/pub/v/bond_network.svg)](https://pub.dev/packages/bond_network) | [Source](https://github.com/flutterbond/bond-core/tree/main/packages/network) |
| Bond Cache          | Enables effortless caching in your Flutter apps. | [![bond_cache](https://img.shields.io/pub/v/bond_cache.svg)](https://pub.dev/packages/bond_cache) | [Source](https://github.com/flutterbond/bond-core/tree/main/packages/cache) |
| Bond Form           | An intuitive package that simplifies form operations. | [![bond_form](https://img.shields.io/pub/v/bond_form.svg)](https://pub.dev/packages/bond_form) | [Source](https://github.com/flutterbond/bond-core/tree/main/packages/form) |
| Bond App Aanalytics | An insightful package for tracking app usage and analytics. | [![bond_app_analytics](https://img.shields.io/pub/v/bond_app_analytics.svg)](https://pub.dev/packages/bond_app_analytics) | [Source](https://github.com/flutterbond/bond-core/tree/main/packages/app_analytics) |
| Bond Notifications  | A flexible package for effective notification handling. | [![bond_notifications](https://img.shields.io/pub/v/bond_notifications.svg)](https://pub.dev/packages/bond_notifications) | [Source](https://github.com/flutterbond/bond-core/tree/main/packages/notifications) |
| Bond Form Riverpod  | Riverpod 3 state management for Bond forms. | [![bond_form_riverpod](https://img.shields.io/pub/v/bond_form_riverpod.svg)](https://pub.dev/packages/bond_form_riverpod) | [Source](https://github.com/flutterbond/bond-core/tree/main/packages/form/packages/bond_form_riverpod) |
| Bond Form GetX      | GetX state management for Bond forms. | [![bond_form_getx](https://img.shields.io/pub/v/bond_form_getx.svg)](https://pub.dev/packages/bond_form_getx) | [Source](https://github.com/flutterbond/bond-core/tree/main/packages/form/packages/bond_form_getx) |
| Bond Form Bloc      | Bloc state management for Bond forms. | [![bond_form_bloc](https://img.shields.io/pub/v/bond_form_bloc.svg)](https://pub.dev/packages/bond_form_bloc) | [Source](https://github.com/flutterbond/bond-core/tree/main/packages/form/packages/bond_form_bloc) |

## Versions

| Flutter Bond template | bond_* packages | bond_cli | Flutter |
|---|---|---|---|
| `v1.0.0` (legacy) | bond_core 0.0.3, bond_cache 0.0.4+x, bond_network up to 0.0.11+11, bond_form up to 0.0.22+19, bond_form_riverpod up to 0.0.17+19, notifications/analytics 0.1.0 | 0.0.4+3 | 3.19 – 3.27 |
| `v2.0.0` | core, cache, network, form, form_riverpod, form_getx, form_bloc 0.1.x; notifications, app_analytics 0.2.x | 0.1.x | 3.47.7+ |

Upgrading from the 0.0.x packages: see [MIGRATION.md](MIGRATION.md).

## Development

The repository is a [pub workspace](https://dart.dev/tools/pub/workspaces) managed with Melos 8
(Flutter 3.47.7):

```sh
flutter pub get                          # one resolution for every package
dart run melos run analyze --no-select   # also: format, test, publish:dry
```

`bond_socialite` is not part of the workspace (its dependencies cannot be resolved together with
Melos 8) and is not published from this line.

## Claude Code and MCP

`.mcp.json` registers the official Dart & Flutter MCP server (`dart`): analyzer, pub, tests, and
reading/searching the source of every workspace package. It starts through `tool/mcp/dart.sh`, which
always uses the Flutter version pinned in `.fvmrc` (3.47.7) and never another Flutter on your PATH.
Claude Code asks once to approve the project's MCP servers; check them with `claude mcp list`.

## Contribute to the Bond

We heartily welcome contributions to the Bond framework! Whether you've found a bug, have a feature request, or want to propose an improvement, we'd love to hear from you. You can open an issue, submit a pull request, or even suggest changes to our documentation.

Let's bond together to make Flutter development more efficient and enjoyable for all!
