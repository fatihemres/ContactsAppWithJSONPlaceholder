//
//  UserSearchTests.swift
//  ContactsAppWithJSONPlaceholder
//
//  Created by Fatih Emre on 21.01.2025.
//

import XCTest
@testable import ContactsAppWithJSONPlaceholder

/// Tests the search functionality of `UsersListViewModel` to ensure correct filtering behavior.
final class UserSearchTests: XCTestCase {
    var viewModel: UsersListViewModel!
    var mockRepository: MockUserRepository!

    override func setUpWithError() throws {
        mockRepository = MockUserRepository()
        mockRepository.shouldReturnError = false // Ensure no error state.
        viewModel = UsersListViewModel(userRepository: mockRepository)
        viewModel.start() // Preload mock user data.
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockRepository = nil
    }

    /// Tests that searching with a valid query returns the correct results.
    func testSearchWithResults() {
        // Act
        viewModel.searchUsers(with: "John")

        // Assert
        XCTAssertEqual(viewModel.numberOfRows(), 1, "Search should return 1 user for the query 'John'.")
        XCTAssertEqual(viewModel.user(at: 0)?.name, MockUser.sample.name, "The returned user's name should match the mock user's name.")
    }

    /// Tests that searching with an invalid query returns no results.
    func testSearchWithoutResults() {
        // Act
        viewModel.searchUsers(with: "Invalid")

        // Assert
        XCTAssertEqual(viewModel.numberOfRows(), 0, "Search should return no users for an invalid query.")
    }

    /// Tests that an empty search query returns all users.
    func testEmptySearchReturnsAllUsers() {
        // Act
        viewModel.searchUsers(with: "")

        // Assert
        XCTAssertEqual(viewModel.numberOfRows(), 1, "An empty query should return all users.")
    }
}
