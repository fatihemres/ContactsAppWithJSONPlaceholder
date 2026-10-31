//
//  ContactsAppWithJSONPlaceholderUITestsLaunchTests.swift
//  ContactsAppWithJSONPlaceholderUITests
//
//  Deterministic launch validation with an in-memory repository.
//

import XCTest

final class ContactsAppWithJSONPlaceholderUITestsLaunchTests: XCTestCase {
    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launchArguments.append("-ui-test-fixtures")
        app.launch()

        let searchBar = app.searchFields["Search users"]
        XCTAssertTrue(searchBar.waitForExistence(timeout: 10))

        let user = app.tables.cells.staticTexts["Leanne Graham"]
        XCTAssertTrue(user.waitForExistence(timeout: 10))

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Deterministic Contacts Launch"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
