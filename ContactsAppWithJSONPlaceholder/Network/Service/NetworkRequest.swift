//
//  NetworkRequest.swift
//  ContactsAppWithJSONPlaceholder
//
//  Created by Fatih Emre on 20.01.2025.
//

import Foundation

/// A singleton class that manages all network requests in the application.
/// Encapsulates logic for sending HTTP GET requests and handling responses.
class NetworkRequest {
    /// The shared singleton instance of `NetworkRequest`.
    static let shared = NetworkRequest()

    /// Private initializer to prevent external instantiation.
    private init() {}

    /**
     Sends a GET request to the specified endpoint and handles the response.
     - Parameters:
        - endpoint: The API endpoint to fetch data from.
        - completionHandler: A closure that receives the result of the network request, either success with `Data` or a `NetworkError`.
     */
    func getData(for endpoint: EndPoint, completionHandler: @escaping (Result<Data, NetworkError>) -> Void) {
        URLSession.shared.request(endpoint) { data, _, error in
            // Ensures the completion handler is called on the main thread.
            DispatchQueue.main.async {
                if let error = error {
                    print("Network error: \(error)")
                    completionHandler(.failure(.urlError))
                } else {
                    guard let data = data else {
                        completionHandler(.failure(.cannotParseData))
                        return
                    }
                    completionHandler(.success(data))
                }
            }
        }
    }
}
