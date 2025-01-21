//
//  Typealias.swift
//  ContactsAppWithJSONPlaceholder
//
//  Created by Fatih Emre on 20.01.2025.
//

/// `VoidCallback` represents a closure that takes no parameters and returns no value.
/// Commonly used for simple actions or event triggers where no data needs to be passed.
public typealias VoidCallback = () -> Void

/// `Callback` is a generic closure that takes a single parameter of type `T`.
/// It is used to pass a value or respond to an event with a specific piece of data.
/// - Parameter T: The type of data to be passed to the closure.
public typealias Callback<T> = (T) -> Void
