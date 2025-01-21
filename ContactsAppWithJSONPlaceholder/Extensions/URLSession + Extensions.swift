//
//  URLSession + Extensions.swift
//  ContactsAppWithJSONPlaceholder
//
//  Created by Fatih Emre on 20.01.2025.
//

import Foundation

/// An extension for `URLSession` to simplify network requests.
extension URLSession {
    /// A typealias for the standard URL session completion handler.
    typealias Handler = (Data?, URLResponse?, Error?) -> Void

    /// Sends a network request to the specified endpoint and returns the associated `URLSessionDataTask`.
    /// - Parameters:
    ///   - endPoint: The `EndPoint` containing the URL for the request.
    ///   - handler: A completion handler called with the response data, URL response, or an error.
    /// - Returns: The `URLSessionDataTask` associated with the request.
    @discardableResult
    func request(_ endPoint: EndPoint, handler: @escaping Handler) -> URLSessionDataTask {
        let task = dataTask(with: endPoint.url, completionHandler: handler)
        task.resume()
        return task
    }
}
