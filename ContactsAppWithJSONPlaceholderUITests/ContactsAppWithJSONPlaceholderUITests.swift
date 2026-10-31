//
//  ContactsAppWithJSONPlaceholderUITests.swift
//  ContactsAppWithJSONPlaceholderUITests
//
//  UI coverage using deterministic contacts rather than a live API.
//

import XCTest

final class ContactsAppWithJSONPlaceholderUITests: XCTestCase {

    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-ui-test-fixtures")
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    /// The list is populated from the in-memory fixture without waiting for the network.
    func testUserListScreenElements() {
        let searchBar = app.searchFields["Search users"]
        XCTAssertTrue(searchBar.waitForExistence(timeout: 10))

        let tableView = app.tables["UserListTableView"]
        XCTAssertTrue(tableView.exists)

        let user = tableView.cells.staticTexts["Leanne Graham"]
        XCTAssertTrue(user.waitForExistence(timeout: 10))

        tableView.swipeUp()
        tableView.swipeDown()
    }

    /// Filters stable fixture users without relying on JSONPlaceholder availability.
    func testSearchUsers() {
        let initialUser = app.tables.cells.staticTexts["Leanne Graham"]
        XCTAssertTrue(initialUser.waitForExistence(timeout: 10))

        let searchBar = app.searchFields["Search users"]
        XCTAssertTrue(searchBar.exists)
        searchBar.tap()
        searchBar.typeText("Ervin")

        let result = app.tables.cells.staticTexts["Ervin Howell"]
        XCTAssertTrue(result.waitForExistence(timeout: 10))
        XCTAssertFalse(app.tables.cells.staticTexts["Leanne Graham"].exists)
    }

    /// Navigation must show the selected user's stable contact fields.
    func testUserDetailNavigation() {
        let cell = app.tables.cells.staticTexts["Leanne Graham"]
        XCTAssertTrue(cell.waitForExistence(timeout: 10))
        cell.tap()

        XCTAssertTrue(app.navigationBars["User Details"].waitForExistence(timeout: 10))
        XCTAssertTrue(app.buttons["EmailButton"].waitForExistence(timeout: 10))
        XCTAssertTrue(app.buttons["PhoneButton"].exists)
        XCTAssertTrue(app.buttons["WebsiteButton"].exists)
    }

    func testInvalidSearch() {
        let initialUser = app.tables.cells.staticTexts["Leanne Graham"]
        XCTAssertTrue(initialUser.waitForExistence(timeout: 10))

        let searchBar = app.searchFields["Search users"]
        searchBar.tap()
        searchBar.typeText("InvalidUser")

        XCTAssertTrue(app.staticTexts["NoDataLabel"].waitForExistence(timeout: 10))
        XCTAssertFalse(app.tables.cells.staticTexts["Leanne Graham"].exists)
    }
}
