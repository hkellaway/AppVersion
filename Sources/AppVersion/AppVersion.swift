//
//  AppVersion.swift
//  AppVersion
//
// Copyright (c) 2020 Harlan Kellaway
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//
//

import Foundation

public struct AppVersion: Comparable, Equatable, ExpressibleByStringLiteral, CustomStringConvertible {

  public let major: Int
  public let minor: Int
  public let patch: Int
  public let preReleaseIdentifiers: ArraySlice<String>
  public let rawValue: String
    
  public var description: String {
    return rawValue
  }

  public static var fromBundle: AppVersion? {
    return (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String).flatMap(AppVersion.init(rawValue:))
  }

  public init(stringLiteral value: StringLiteralType) {
    guard let instance = AppVersion(rawValue: value) else {
        preconditionFailure("failed to initialize `AppVersion` using string literal '\(value)'.")
    }
    self = instance
  }

  public init?(rawValue: String) {
    let normalVersionAndPreRelease = Array(rawValue
        .trimmingCharacters(in: .whitespacesAndNewlines)
        .components(separatedBy: "-"))
    let preReleaseIdentifiers = normalVersionAndPreRelease.dropFirst()
    
    guard !(normalVersionAndPreRelease.contains("")),
        !(preReleaseIdentifiers.contains { $0.hasLeadingZero }),
        !(preReleaseIdentifiers.contains { !($0.isAlphanumeric) }),
        let rawNormalVersion = normalVersionAndPreRelease.first else {
        return nil
    }
    
    let normalVersionComponents = Array(rawNormalVersion
        .removeFirstCharacter(ifMatches: "v")
        .components(separatedBy: "."))
        .filter { !$0.hasLeadingZero }
        .compactMap { Int($0) }
        .filter { $0.isNonNegative }

    guard normalVersionComponents.count == 3 else {
      return nil
    }

    self.rawValue = rawValue
    self.major = normalVersionComponents[0]
    self.minor = normalVersionComponents[1]
    self.patch = normalVersionComponents[2]
    self.preReleaseIdentifiers = preReleaseIdentifiers
  }
    
  // MARK: - SemVer
    
  public var isStable: Bool {
    return isPublic && !isPreRelease
  }
    
  public var isPublic: Bool {
    return self >= AppVersion(rawValue: "1.0.0")!
  }
    
  public var isPreRelease: Bool {
    return !(preReleaseIdentifiers.isEmpty)
  }
  
  public func nextMajor() -> AppVersion {
      return AppVersion(rawValue: "\(major+1).0.0")!
  }
  
  public func nextMinor() -> AppVersion {
      return AppVersion(rawValue: "\(major).\(minor+1).0")!
  }
  
  public func nextPatch() -> AppVersion {
      return AppVersion(rawValue: "\(major).\(minor).\(patch+1)")!
  }

}

// MARK: - Protocol conformance

// MARK: Comparable

public func <(lhs: AppVersion, rhs: AppVersion) -> Bool {
  if lhs.major != rhs.major {
    return lhs.major < rhs.major
  }

  if lhs.minor != rhs.minor {
    return lhs.minor < rhs.minor
  }

  if lhs.patch != rhs.patch {
    return lhs.patch < rhs.patch
  }
  
  // lhs and rhs have same normal version;
  // lhs is only less-than if it is a preRelease
  return lhs.isPreRelease && !rhs.isPreRelease
}

// MARK: Equatable

public func ==(lhs: AppVersion, rhs: AppVersion) -> Bool {
  return lhs.major == rhs.major
    && lhs.minor == rhs.minor
    && lhs.patch == rhs.patch
    && lhs.preReleaseIdentifiers == rhs.preReleaseIdentifiers
}
