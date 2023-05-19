//
//  User.swift
//  iOSProject
//
//  Created by Kaisa Hakola on 9.5.2023.
//

import Foundation

struct User : Decodable, Equatable {
    var firstName : String
    var lastName : String
    var id : Int
}
