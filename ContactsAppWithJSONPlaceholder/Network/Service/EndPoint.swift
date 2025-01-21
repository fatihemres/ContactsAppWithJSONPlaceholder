//
//  EndPoint.swift
//  ContactsAppWithJSONPlaceholder
//
//  Created by Fatih Emre on 20.01.2025.
//

import Foundation

/// Represents an API endpoint for network requests.
/// Provides a structured way to construct URLs for API calls.
struct EndPoint {
    /// The specific path for the endpoint (e.g., "users").
    let path: String

    /// The fully constructed URL for the endpoint.
    /// Combines the base URL with the path.
    var url: URL {
        var components = URLComponents()
        components.scheme = "https" // Protocol used (HTTPS for secure communication).
        components.host = "jsonplaceholder.typicode.com" // Base host for the API.
        components.path = "/" + path // Appends the path to the base URL.

        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        return url
    }

    /// A predefined endpoint for fetching users.
    static var users: EndPoint {
        EndPoint(path: "users")
    }
}
