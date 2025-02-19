# Changelog

All notable changes to this project will be documented in this file.

## [1.0.13] - 2023-12-14

### Fixed

- Fixed zoom issue in webview
- View fix in iOS.

## [1.0.12] - 2023-12-04

### Changed

- [Enhancement]
- SDK invocation changes.

### Added

- Updated UAT URL switch between old uat and uat1.

## [1.0.11] - 2023-11-30

### Added

- Added package.sh

## [1.0.10] - 2023-09-11

### Added

- Added loader gif in webview

## [1.0.9] - 2023-09-14

### Changed

- Updated indexUAT.html and env URLs pointing to uat1.
- Added 2 UAT URLs and dynamic library load based on flowtype in SDK. New URL for payment and
  pay_plus_mandate, old one for e_mandate.

## [1.0.8] - 2023-09-11

### Added

- isUatEnv property is added in BuildInfo
- Added missing field in build info dialogue and updated build version
- Added Build info dialogue box and version
- Added build_script.sh

### Changed

- Text style changes in dialogue
- Removed git hash from info dialogue box

Fix: issues related to configuration and order request in pay+mandate flow.

## [1.0.7] - 2023-07-26

### Added

- Config-related changes, transaction popup message-related changes.

### Fixed

- iOS launching issue fixes.

## [1.0.6] - 2023-07-6

### Changed

- Replaced `flutter_jailbreak_detection` package with `safe_device` for enhanced jail break/rooted
  security checks.

## [1.0.5] - 2023-06-27

### Added

- Added code for calling listing all mandates API.
- Made enhancements in sdkResponseHandler for showing the mandate details in transaction card.

## [1.0.4] - 2023-06-22

### Changed

- [Enhancement]
- Removed webview_flutter plugin dependency.
- Added flutter_inappwebview plugin as a replacement for webview functionality.
- Migrate code that interacts with the WebView, such as event listeners, method calls, and
  configurations, according to the `flutter_inappwebview` API.

## [1.0.3] - 2023-06-13

### Security

- [Feature] Code for implementing jail breaking.

## [1.0.2] - 2023-06-07

### Added

- [Feature] Code for clearing cookies, cache and local storage.

## [1.0.1] - 2023-05-31

### Changed

- Changed emandate create order endpoint.

## [1.0.0] - 2023-05-30

Initial release of the project.

### Added

- [Feature] Created merchant screen and api implementation for create order for different payment
  flow.
- [Feature] Implemented sdk functionality for invoking web view.

### Changed

- [UI]

### Fixed

- [Bug] .

