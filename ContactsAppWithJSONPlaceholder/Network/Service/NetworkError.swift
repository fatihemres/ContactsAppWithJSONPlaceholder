//
//  NetworkError.swift
//  ContactsAppWithJSONPlaceholder
//
//  Created by Fatih Emre on 20.01.2025.
//

import Foundation

/// Enum that represents different types of errors that can occur during network operations.
enum NetworkError: Error {
    case urlError // Error occurred while creating or accessing the URL.
    case cannotParseData // Unable to parse or decode the response data.
    case genericError // A general error that does not fall into other categories.
    case invalidResponse // The server returned an invalid response.
    case decodingError // Error during JSON decoding of the response data.
}
