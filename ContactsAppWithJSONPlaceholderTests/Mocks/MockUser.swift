//
//  MockUser.swift
//  ContactsAppWithJSONPlaceholder
//
//  Created by Fatih Emre on 21.01.2025.
//

@testable import ContactsAppWithJSONPlaceholder

/// A mock model to provide sample `User` data for testing purposes.
struct MockUser {
    /// A static sample instance of a `User` object.
    /// This can be used in unit tests or previews to simulate real data.
    static let sample = User(
        id: 1,
        name: "John Doe",
        username: "johndoe",
        email: "johndoe@example.com",
        address: Address(
            street: "123 Main St",
            suite: "Apt 456",
            city: "Springfield",
            zipcode: "12345",
            geo: Geo(lat: "37.7749", lng: "-122.4194")
        ),
        phone: "123-456-7890",
        website: "www.johndoe.com",
        company: Company(
            name: "Acme Corp",
            catchPhrase: "We make things better",
            bs: "synergize scalable solutions"
        )
    )
}
