//
//  UsersListViewModelTests.swift
//  ContactsAppWithJSONPlaceholder
//
//  Created by Fatih Emre on 21.01.2025.
//

import XCTest
@testable import ContactsAppWithJSONPlaceholder

/// Tests the behavior of `UsersListViewModel`, ensuring correct handling of state changes, data fetching, and search functionality.
final class UsersListViewModelTests: XCTestCase {
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

    /// Tests the initial state of the view model.
    func testInitialState() {
        XCTAssertNil(viewModel.stateChangeHandler, "State change handler should initially be nil.")
    }

    /// Tests successful fetching of users from the repository.
    func testFetchUsersSuccess() {
        // Arrange
        mockRepository.shouldReturnError = false

        // Act
        let expectation = self.expectation(description: "State change")
        var hasFulfilled = false

        viewModel.stateChangeHandler = { state in
            if hasFulfilled { return } // Avoid multiple fulfillments.

            switch state {
            case .loading:
                break // Loading state can be ignored for this test.
            case .success:
                XCTAssertEqual(self.viewModel.numberOfRows(), 1, "Number of rows should match the mock data.")
                expectation.fulfill()
                hasFulfilled = true
            case .error, .empty:
                XCTFail("Expected success, but got \(state).")
            }
        }

        viewModel.start()
        waitForExpectations(timeout: 1.0)
    }

    /// Tests failure when fetching users from the repository.
    func testFetchUsersFailure() {
        // Arrange
        mockRepository.shouldReturnError = true

        // Act
        let expectation = self.expectation(description: "State change to error")
        viewModel.stateChangeHandler = { state in
            switch state {
            case .loading:
                break // Ignore loading state.
            case .error(let errorMessage):
                XCTAssertNotNil(errorMessage, "Error message should not be nil.")
                XCTAssertEqual(errorMessage, "The operation couldn’t be completed. (ContactsAppWithJSONPlaceholder.NetworkError error 2.)", "Error message should match the expected value.")
                expectation.fulfill()
            default:
                XCTFail("Unexpected state: \(state).")
            }
        }

        viewModel.start()

        // Assert
        waitForExpectations(timeout: 1.0)
    }

    /// Tests the search functionality of the view model.
    func testSearchUsers() {
        // Arrange
        viewModel.start()
        XCTAssertEqual(viewModel.numberOfRows(), 1, "Initial number of rows should match the mock data.")

        // Act
        viewModel.searchUsers(with: "John")
        XCTAssertEqual(viewModel.numberOfRows(), 1, "Search for 'John' should return one result.")

        viewModel.searchUsers(with: "Invalid")
        XCTAssertEqual(viewModel.numberOfRows(), 0, "Search for 'Invalid' should return zero results.")
    }
}
