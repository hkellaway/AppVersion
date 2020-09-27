//
//  AppVersionTests.swift
//  AppVersionTests
//
//  Created by Harlan Kellaway on 9/8/20.
//  Copyright © 2020 Harlan Kellaway. All rights reserved.
//

import XCTest
@testable import AppVersion

class AppVersionTests: XCTestCase {
  
  let version123: AppVersion = "1.2.3"
  
  // MARK: - Normal Version
  
  func test_init_fromValidString_isSuccessful() {
    XCTAssertNotNil(AppVersion(rawValue: "2.0.0"))
    XCTAssertNotNil(AppVersion(rawValue: "1.4.20"))
    XCTAssertNotNil(AppVersion(rawValue: " 2.0.0"))
    XCTAssertNotNil(AppVersion(rawValue: "1.0.0 "))
  }
  
  func test_init_fromInvalidString_isFailure() {
    XCTAssertNil(AppVersion(rawValue: ""))
    XCTAssertNil(AppVersion(rawValue: "0"))
    XCTAssertNil(AppVersion(rawValue: "0.0"))
    XCTAssertNil(AppVersion(rawValue: "1.0"))
    XCTAssertNil(AppVersion(rawValue: "1.0.0.0"))
    XCTAssertNil(AppVersion(rawValue: "-1.2.3"))
    XCTAssertNil(AppVersion(rawValue: "1.-2.3"))
    XCTAssertNil(AppVersion(rawValue: "1.2.-3"))
    XCTAssertNil(AppVersion(rawValue: "01.2.3"))
    XCTAssertNil(AppVersion(rawValue: "1.02.3"))
    XCTAssertNil(AppVersion(rawValue: "1.2.03"))
  }
  
  func test_againstEqual_equal_isTrue() {
    XCTAssertTrue(version123 == "1.2.3")
  }
  
  func test_againstNotEqual_equal_isFalse() {
    XCTAssertFalse(version123 == "3.2.1")
  }
  
  func test_againstLowerMajorVersion_gte_isTrue() {
    XCTAssertTrue(version123 >= "0.2.3")
  }
  
  func test_againstLowerMinorVersion_gte_isTrue() {
    XCTAssertTrue(version123 >= "1.1.3")
  }
  
  func test_againstLowerPatchVersion_gte_isTrue() {
    XCTAssertTrue(version123 >= "1.2.2")
  }
  
  func test_againstHigherMajorVersion_gte_isFalse() {
    XCTAssertFalse(version123 >= "2.2.3")
  }
  
  func test_againstHigherMinorVersion_gte_isFalse() {
    XCTAssertFalse(version123 >= "1.3.3")
  }
  
  func test_againstHigherPatchVersion_gte_isFalse() {
    XCTAssertFalse(version123 >= "1.2.4")
  }
  
  func test_againstEqualVersion_gte_isTrue() {
    XCTAssertTrue(version123 >= "1.2.3")
  }
  
  func test_againstHigherPatchVersion_gte_isTrue() {
    XCTAssertTrue(version123 <= "1.2.4")
  }
  
  func test_againstLowerMajorVersion_lte_isFalse() {
    XCTAssertFalse(version123 <= "0.2.3")
  }
  
  func test_againstLowerMinorVersion_lte_isFalse() {
    XCTAssertFalse(version123 <= "1.1.3")
  }
  
  func test_againstLowerPatchVersion_lte_isFalse() {
    XCTAssertFalse(version123 <= "1.2.2")
  }
  
  func test_againstHigherMajorVersion_lte_isTrue() {
    XCTAssertTrue(version123 <= "2.2.3")
  }
  
  func test_againstHigherMinorVersion_lte_isTrue() {
    XCTAssertTrue(version123 <= "1.3.3")
  }
  
  func test_againstEqualVersion_lte_isTrue() {
    XCTAssertTrue(version123 <= "1.2.3")
  }
  
  // MARK: - Semantic Verion
  
  func test_canStartWithLetterV() {
    XCTAssertNotNil(AppVersion(rawValue: "v2.0.0"))
    XCTAssertNotNil(AppVersion(rawValue: "v1.4.20"))
  }
  
  func test_whenGreaterThanMajorOne_isPublic_isTrue() {
    XCTAssertTrue(version123.isPublic)
    XCTAssertTrue(AppVersion(rawValue: "1.0.0")!.isPublic)
  }
  
  func test_whenHasLeadingZero_isPublic_isFalse() {
    XCTAssertFalse(AppVersion(rawValue: "0.1.2")!.isPublic)
  }
  
  func test_whenIsPublic_andNotPreRelease_isStable_isTrue() {
    XCTAssertTrue(version123.isStable)
  }
  
  func test_whenNotPublic_isStable_isFalse() {
    XCTAssertFalse(AppVersion(rawValue: "0.1.2")!.isStable)
  }
  
  func test_whenIsPreRelase_isStable_isFalse() {
    XCTAssertFalse(AppVersion(rawValue: "1.2.3-beta")!.isStable)
  }
  
  func test_whenValidPreRelease_populatesPreReleaseIdentifiers() {
    XCTAssertEqual(["beta"], AppVersion(rawValue: "1.2.3-beta")!.preReleaseIdentifiers)
    XCTAssertEqual(["beta", "x", "y", "z"], AppVersion(rawValue: "1.2.3-beta-x-y-z")!.preReleaseIdentifiers)
  }
  
  func test_init_withInvalidPreRelease_fails() {
    XCTAssertNil(AppVersion(rawValue: "1.2.3-"))
    XCTAssertNil(AppVersion(rawValue: "1.2.3-$"))
    XCTAssertNil(AppVersion(rawValue: "1.2.3-beta-01"))
  }
  
  func test_againstEqualVersionAndPreRelease_equal_isTrue() {
    XCTAssertEqual(AppVersion(rawValue: "1.2.3-beta")!, AppVersion(rawValue: "1.2.3-beta")!)
  }
  
  func test_againstEqualVersionAndDiffPreRelease_equal_isFalse() {
    XCTAssertNotEqual(AppVersion(rawValue: "1.2.3-alpha")!, AppVersion(rawValue: "1.2.3-beta")!)
  }
  
  func test_againstPreRelease_withSameNormalVersion_gt_isTrue() {
    XCTAssertTrue(version123 > AppVersion(rawValue: "1.2.3-beta")!)
  }
  
  func test_againstPreRelease_withSameNormalVersion_lt_isFalse() {
    XCTAssertFalse(version123 < AppVersion(rawValue: "1.2.3-beta")!)
  }
  
  func test_nextMajor_isSuccessful() {
    XCTAssertEqual(version123.nextMajor(), AppVersion(rawValue: "2.0.0")!)
  }
  
  func test_nextMinor_isSuccessful() {
    XCTAssertEqual(version123.nextMinor(), AppVersion(rawValue: "1.3.0")!)
  }
  
  func test_nextPatch_isSuccessful() {
    XCTAssertEqual(version123.nextPatch(), AppVersion(rawValue: "1.2.4")!)
  }
  
}
