//
//  UsersListViewModelTests.swift
//  ContactsAppWithJSONPlaceholder
//
//  Created by Fatih Emre on 21.01.2025.
//

import XCTest
@testable import ContactsAppWithJSONPlaceholder

/// Tests for `MockUserRepository` to ensure proper handling of success and failure scenarios in fetching users.
final class UserRepositoryTests: XCTestCase {
    var repository: MockUserRepository!

    override func setUpWithError() throws {
        repository = MockUserRepository()
    }

    override func tearDownWithError() throws {
        repository = nil
    }

    /// Tests that `fetchUsers` successfully returns a list of users when no error is simulated.
    func testFetchUsersSuccess() {
        // Arrange
        repository.shouldReturnError = false

        // Act
        let expectation = self.expectation(description: "Fetch users")
        repository.fetchUsers { result in
            // Assert
            switch result {
            case .success(let users):
                XCTAssertEqual(users.count, 1, "The number of users should match the mock data.")
                XCTAssertEqual(users.first?.name, "John Doe", "The user's name should match the mock user's name.")
            case .failure:
                XCTFail("Expected success, got failure.")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0)
    }

    /// Tests that `fetchUsers` correctly handles an error scenario and returns a failure result.
    func testFetchUsersFailure() {
        // Arrange
        repository.shouldReturnError = true

        // Act
        let expectation = self.expectation(description: "Fetch users")
        repository.fetchUsers { result in
            // Assert
            switch result {
            case .success:
                XCTFail("Expected failure, got success.")
            case .failure(let error):
                XCTAssertNotNil(error, "Error should not be nil.")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0)
    }
}
