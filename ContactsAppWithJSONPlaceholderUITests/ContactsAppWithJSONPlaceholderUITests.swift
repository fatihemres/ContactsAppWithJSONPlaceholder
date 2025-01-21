//
//  ContactsAppWithJSONPlaceholderUITests.swift
//  ContactsAppWithJSONPlaceholderUITests
//
//  Created by Fatih Emre on 20.01.2025.
//

import XCTest

/// UI tests for the Contacts App, ensuring the correct behavior and layout of the user list and user detail screens.
final class ContactsAppWithJSONPlaceholderUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        // Initialize the app and set up the environment for each test case.
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        // Clean up the app instance after each test case.
        app = nil
    }

    /// Tests that the user list screen elements are present and functional.
    func testUserListScreenElements() {
        // Verify the search bar exists.
        let searchBar = app.searchFields["Search users"]
        XCTAssertTrue(searchBar.exists, "Search bar should exist on the user list screen.")

        // Verify the table view exists.
        let tableView = app.tables["UserListTableView"]
        XCTAssertTrue(tableView.exists, "Table view should exist on the user list screen.")

        // Perform swipe actions on the table view.
        tableView.swipeUp()
        tableView.swipeDown()
    }

    /// Tests the search functionality to ensure the correct user is found.
    func testSearchUsers() {
        // Verify the search bar exists.
        let searchBar = app.searchFields["Search users"]
        XCTAssertTrue(searchBar.exists, "Search bar should exist.")

        // Perform a search.
        searchBar.tap()
        searchBar.typeText("Leanne")

        // Verify the correct search result is displayed.
        let cell = app.tables.cells.staticTexts["Leanne Graham"]
        XCTAssertTrue(cell.exists, "Search should return the correct user.")
    }

    /// Tests navigation from the user list to the user detail screen.
    func testUserDetailNavigation() {
        // Verify the user cell exists in the list.
        let cell = app.tables.cells.staticTexts["Leanne Graham"]
        XCTAssertTrue(cell.exists, "Leanne Graham cell should exist.")

        // Tap the cell to navigate to the detail screen.
        cell.tap()

        // Verify the user detail screen is displayed.
        let detailScreenTitle = app.staticTexts["User Details"]
        XCTAssertTrue(detailScreenTitle.exists, "User Details screen should be displayed.")

        // Verify elements on the detail screen.
        let emailButton = app.buttons["Sincere@april.biz"]
        XCTAssertTrue(emailButton.exists, "Email button should exist.")

        let phoneButton = app.buttons["1-770-736-8031 x56442"]
        XCTAssertTrue(phoneButton.exists, "Phone button should exist.")

        let websiteButton = app.buttons["hildegard.org"]
        XCTAssertTrue(websiteButton.exists, "Website button should exist.")
    }

    /// Tests the behavior when an invalid search query is entered.
    func testInvalidSearch() {
        // Perform a search with an invalid query.
        let searchBar = app.searchFields["Search users"]
        searchBar.tap()
        searchBar.typeText("InvalidUser")

        // Verify the "No users found" label is displayed.
        let noDataLabel = app.staticTexts["No users found"]
        XCTAssertTrue(noDataLabel.exists, "No data label should be displayed when no users are found.")
    }
}
