//
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
    let versionComponents = Array(rawValue.components(separatedBy: ".")).map { Int($0) }.compactMap { $0 }

    guard versionComponents.count == 3 else {
      return nil
    }

    self.rawValue = rawValue

    major = versionComponents[0]
    minor = versionComponents[1]
    patch = versionComponents[2]
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

  // lhs and rhs are equal
  return false
}

// MARK: Equatable

public func ==(lhs: AppVersion, rhs: AppVersion) -> Bool {
  return lhs.major == rhs.major
    && lhs.minor == rhs.minor
    && lhs.patch == rhs.patch
}
