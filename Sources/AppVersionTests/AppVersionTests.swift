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
    
    // MARK: - SemVer
    
    func test_whenGreaterThanMajorOne_isStable_isTrue() {
        XCTAssertTrue(version123.isStable)
        XCTAssertTrue(AppVersion(rawValue: "1.0.0")!.isStable)
    }
    
    func test_whenHasLeadingZero_isStable_isFalse() {
        XCTAssertFalse(AppVersion(rawValue: "0.1.2")!.isStable)
    }
    func test_init_fromValidString_isSuccessful() {
        XCTAssertNotNil(AppVersion(rawValue: "2.0.0"))
        XCTAssertNotNil(AppVersion(rawValue: "1.4.20"))
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
    
    func test_againstHigherPatchVersion_gte_isTrue() {
        XCTAssertTrue(version123 <= "1.2.4")
    }
    
    func test_againstEqualVersion_lte_isTrue() {
        XCTAssertTrue(version123 <= "1.2.3")
    }
    
}
