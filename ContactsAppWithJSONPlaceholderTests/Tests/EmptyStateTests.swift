//
//  EmptyStateTests.swift
//  ContactsAppWithJSONPlaceholder
//
//  Created by Fatih Emre on 21.01.2025.
//

import XCTest
@testable import ContactsAppWithJSONPlaceholder

/// Tests the behavior of `UsersListViewModel` when the user list is empty.
/// This test ensures that the state transitions to `.empty` when the repository returns no users.
final class EmptyStateTests: XCTestCase {
    var viewModel: UsersListViewModel!
    var mockRepository: MockUserRepository!

    override func setUpWithError() throws {
        mockRepository = MockUserRepository()
        viewModel = UsersListViewModel(userRepository: mockRepository)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockRepository = nil
    }

    /// Verifies that the `UsersListViewModel` transitions to the `.empty` state
    /// when the user repository returns an empty list of users.
    func testEmptyUserList() {
        // Arrange
        mockRepository.shouldReturnError = false
        mockRepository.mockUsers = [] // Set up an empty user list for testing.

        // Act
        let expectation = self.expectation(description: "State should change to empty")
        var hasFulfilled = false // Flag to prevent multiple fulfillment.

        viewModel.stateChangeHandler = { state in
            if hasFulfilled { return } // Ignore subsequent calls after fulfillment.

            switch state {
            case .loading:
                // Ignore loading state.
                break
            case .empty:
                expectation.fulfill() // Fulfill the expectation for the empty state.
                hasFulfilled = true // Mark the flag as fulfilled.
            case .success, .error:
                XCTFail("Expected empty state, but got \(state)") // Fail the test for unexpected states.
            }
        }
        viewModel.start()

        // Assert
        waitForExpectations(timeout: 1.0) // Ensure the empty state is reached within the timeout.
    }
}
