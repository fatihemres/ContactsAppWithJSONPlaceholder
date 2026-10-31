//
//  UITestFixtureUserRepository.swift
//  ContactsAppWithJSONPlaceholder
//
//  Isolated, in-memory data for automated UI tests; never enabled by normal launch.
//

#if DEBUG
import Foundation

/// A stable substitute for the remote /users endpoint when the app is launched
/// by XCTest with the explicit -ui-test-fixtures launch argument.
final class UITestFixtureUserRepository: UserRepositoryProtocol {
    func fetchUsers(completion: @escaping (Result<[User], NetworkError>) -> Void) {
        // Match the production repository's completion-on-main-queue contract.
        DispatchQueue.main.async {
            completion(.success(Self.users))
        }
    }

    private static let users: [User] = [
        User(
            id: 1,
            name: "Leanne Graham",
            username: "Bret",
            email: "Sincere@april.biz",
            address: Address(
                street: "Kulas Light",
                suite: "Apt. 556",
                city: "Gwenborough",
                zipcode: "92998-3874",
                geo: Geo(lat: "-37.3159", lng: "81.1496")
            ),
            phone: "1-770-736-8031 x56442",
            website: "hildegard.org",
            company: Company(
                name: "Romaguera-Crona",
                catchPhrase: "Multi-layered client-server neural-net",
                bs: "harness real-time e-markets"
            )
        ),
        User(
            id: 2,
            name: "Ervin Howell",
            username: "Antonette",
            email: "Shanna@melissa.tv",
            address: Address(
                street: "Victor Plains",
                suite: "Suite 879",
                city: "Wisokyburgh",
                zipcode: "90566-7771",
                geo: Geo(lat: "-43.9509", lng: "-34.4618")
            ),
            phone: "010-692-6593 x09125",
            website: "anastasia.net",
            company: Company(
                name: "Deckow-Crist",
                catchPhrase: "Proactive didactic contingency",
                bs: "synergize scalable supply-chains"
            )
        )
    ]
}
#endif
