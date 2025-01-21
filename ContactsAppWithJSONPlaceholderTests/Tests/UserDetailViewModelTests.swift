//
//  UserDetailViewModelTests.swift
//  ContactsAppWithJSONPlaceholder
//
//  Created by Fatih Emre on 21.01.2025.
//

import XCTest
@testable import ContactsAppWithJSONPlaceholder

/// Tests the behavior of `UserDetailViewModel` to ensure proper handling of user data and state changes.
final class UserDetailViewModelTests: XCTestCase {
    var viewModel: UserDetailViewModel!

    override func setUpWithError() throws {
        let mockUser = MockUser.sample
        viewModel = UserDetailViewModel(user: mockUser)
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    /// Verifies that the `getUser` method correctly returns the user data.
    func testGetUser() {
        // Arrange
        let expectedName = MockUser.sample.name

        // Act
        let user = viewModel.getUser()

        // Assert
        XCTAssertEqual(user.name, expectedName, "The user's name should match the mock user's name.")
    }

    /// Tests that the view model correctly transitions to the `.success` state.
    func testUserDetailsStateSuccess() {
        // Arrange
        let expectation = self.expectation(description: "Success state called")
        
        viewModel.stateChangeHandler = { state in
            switch state {
            case .success:
                expectation.fulfill() // Fulfill when success state is reached.
            default:
                XCTFail("Expected success state, got \(state)")
            }
        }

        // Act
        viewModel.stateChangeHandler?(.success)

        // Assert
        waitForExpectations(timeout: 1.0)
    }

    /// Tests that the view model correctly transitions to the `.error` state with the appropriate message.
    func testUserDetailsStateError() {
        // Arrange
        let expectedErrorMessage = "User not found"
        let expectation = self.expectation(description: "Error state called")
        
        viewModel.stateChangeHandler = { state in
            switch state {
            case .error(let message):
                XCTAssertEqual(message, expectedErrorMessage, "The error message should match the expected value.")
                expectation.fulfill() // Fulfill when error state is reached.
            default:
                XCTFail("Expected error state, got \(state)")
            }
        }

        // Act
        viewModel.stateChangeHandler?(.error(expectedErrorMessage))

        // Assert
        waitForExpectations(timeout: 1.0)
    }
}
