# AppVersion 
![Swift version](https://img.shields.io/badge/Swift-5.0-orange.svg)
[![SPM Compatible](https://img.shields.io/badge/SPM-compatible-informational.svg)](https://github.com/apple/swift-package-manager)
[![CocoaPods compatible](https://img.shields.io/badge/CocoaPods-compatible-informational.svg)](https://github.com/CocoaPods/CocoaPods)
[![License](https://img.shields.io/badge/License-MIT-lightgrey.svg)](https://github.com/hkellaway/AppVersion/blob/trunk/LICENSE)
[![Build Status](https://travis-ci.org/hkellaway/AppVersion.svg?branch=trunk)](https://travis-ci.org/hkellaway/AppVersion)

A Swift μ-Library for determining app version

## Usage

AppVersion is a simple little library that offers a structured type around typical app versioning. It currently supports the format of `major.minor.patch`, a subspecies of [Semver](https://semver.org/).

### Retrieving from Bundle

``` swift
let currentAppVersion: AppVersion? = .fromBundle
```

### Creation from String

An `AppVersion` can conveniently be created from a `String`:

``` swift
let appVersion: AppVersion = "1.2.3"
```

### Comparison

Comparison operations (`==`, `>`, `<`, etc.) work seamlessly:

``` swift
let minimumAppVersion: AppVersion = "2.0.0"
guard let currentAppVersion: AppVersion = .fromBundle, currentAppVersion >= minimumAppVersion else {
  // send user to App Store
}
```
## Installation

### Swift Package Manager

See [Adding Package Dependencies to Your App](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app). Point to the desired version or the `trunk` branch.

### CocoaPods

```ruby
pod 'AppVersion', :git => 'https://github.com/hkellaway/AppVersion.git', :branch => 'trunk'
```

## Credits

AppVersion was created by [Harlan Kellaway](http://hkellaway.github.io).

## License

AppVersion is available under the MIT license. See the [LICENSE](https://github.com/hkellaway/AppVersion/blob/trunk/LICENSE) file for more info.
