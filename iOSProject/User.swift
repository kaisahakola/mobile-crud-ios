//
//  User.swift
//  iOSProject
//
//  Created by Kaisa Hakola on 9.5.2023.
//

import Foundation

/// A struct representing a user.
///
/// This struct conforms to the 'Decodable' protocol, allowing it to be deserialized from JSON data.
/// it also conforms to the 'Equatable' protocol, enabling equality comparison between user objects.
/// User information includes first name, last name, id and email address.
struct User : Decodable, Equatable {
    var firstName : String
    var lastName : String
    var id : Int
    var email : String
}
