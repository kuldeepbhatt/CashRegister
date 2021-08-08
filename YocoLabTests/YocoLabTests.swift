//
//  YocoLabTests.swift
//  YocoLabTests
//
//  Created by Kuldeep Bhatt on 2021/08/07.
//

import XCTest
@testable import YocoLab

class YocoLabTests: XCTestCase {

    var viewModel: CashRegisterViewModel?
    override func setUp() {
        super.setUp()
        self.viewModel = CashRegisterViewModel.shared
    }

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testNumberOfKeysOnThePanel() throws {
        //The number of keys on the panel should be no more or less than 12
        let noOfKeys = self.viewModel?.keys.count
        XCTAssertEqual(noOfKeys, 12)
    }

    func testTheKeysContents() throws {
        ///The number of keys on the panel should be no more or less than 12
        ///Also safeguard each key value it should not be any garbage value of the key it should be only strict to digits and operations values (e.g. ADD and DEL)
        guard let keys = self.viewModel?.keys else { return }
        XCTAssertTrue(keys.contains("ADD"))
        XCTAssertTrue(keys.contains("DEL"))
        XCTAssertTrue(keys.contains("0"))
        XCTAssertTrue(keys.contains("1"))
        XCTAssertTrue(keys.contains("2"))
        XCTAssertTrue(keys.contains("3"))
        XCTAssertTrue(keys.contains("4"))
        XCTAssertTrue(keys.contains("5"))
        XCTAssertTrue(keys.contains("6"))
        XCTAssertTrue(keys.contains("7"))
        XCTAssertTrue(keys.contains("8"))
        XCTAssertTrue(keys.contains("9"))
    }

    func testVisibleSections() throws {
        ///The number of sections in the register table should be max 2 for now
        ///Also check the sequence of the sections, first should be always entries section and last one would be the total, it can not be other way around.
        guard let sections = self.viewModel?.visibleSections else { return }
        XCTAssertEqual(sections.count, 2)
        XCTAssertEqual(sections.first, .entries)
        XCTAssertEqual(sections[1], .total)
    }

}
