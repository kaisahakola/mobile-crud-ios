//
//  User.swift
//  iOSProject
//
//  Created by Kaisa Hakola on 9.5.2023.
//

import Foundation

/// A struct representing a user.
///
/// This struct conforms to the 'Decodable' protocol, allowing it to be
/// deserialized from JSON data. It also conforms to the 'Equatable'
/// protocol, enabling equality comparison between user objects.
struct User : Decodable, Equatable {
    /// First name of the user.
    var firstName : String
    /// Last name of the user.
    var lastName : String
    /// Unique identifier of the user.
    var id : Int
    /// Email address of the user.
    var email : String
}
