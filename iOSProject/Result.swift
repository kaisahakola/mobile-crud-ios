//
//  Result.swift
//  iOSProject
//
//  Created by Kaisa Hakola on 9.5.2023.
//

import Foundation

/// A struct representing the result of a data fetch.
///
/// This struct conforms to the 'Decodable' protocol, allowing it to be deserialized from JSON data.

struct Result : Decodable {
    
    /// The array of 'User' objects, obtained from the data fetch opertion.
    var users : [User]
}
