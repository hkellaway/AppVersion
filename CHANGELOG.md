# Change Log
All notable changes to this project will be documented in this file.
`AppVersion` adheres to [Semantic Versioning](http://semver.org/).

- `0.2.x` Releases - [0.2.0](#020)
- `0.1.x` Releases - [0.1.0](#010)

---
## [0.2.0](https://github.com/hkellaway/AppVersion/releases/tag/0.2.0)
Released on 2020-09-22.

### Added
* Determination of `isStable`
* Caluation of `next` major, minor, or patch version
* Affordance for version strings starting with `v`

#### Fixed
- Accepting negative numbers
- Accepting leading zeros

---
## [0.1.0](https://github.com/hkellaway/AppVersion/releases/tag/0.1.0)
Released on 2020-09-09.

#### Added
- Ability to derive `AppVersion` from `Bundle`
- Ability to create `AppVersion` from `String`
- Ability to use comparison operators on `AppVersion` instances
- Support for installation via Swift Package Manager and CocoaPods