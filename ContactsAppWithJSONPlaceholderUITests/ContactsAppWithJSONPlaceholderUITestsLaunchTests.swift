//
//  ContactsAppWithJSONPlaceholderUITestsLaunchTests.swift
//  ContactsAppWithJSONPlaceholderUITests
//
//  Created by Fatih Emre on 20.01.2025.
//

import XCTest

/// UI tests to verify the launch behavior of the Contacts App, ensuring key elements are present and the app launches correctly.
final class ContactsAppWithJSONPlaceholderUITestsLaunchTests: XCTestCase {

    /// Ensures the test runs for each target application configuration.
    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        // Prevent tests from continuing after a failure.
        continueAfterFailure = false
    }

    /// Tests that the app launches correctly and verifies essential UI elements are present.
    func testLaunch() throws {
        // Launch the app.
        let app = XCUIApplication()
        app.launch()

        // Verify that the search bar is present on launch.
        let searchBar = app.searchFields["Search users"]
        XCTAssertTrue(searchBar.exists, "Search bar should exist on launch.")

        // Verify that at least one cell exists in the table view at launch.
        let firstCell = app.tables.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.exists, "At least one cell should exist in the table view at launch.")

        // Capture a screenshot of the launch screen.
        let screenshot = app.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
