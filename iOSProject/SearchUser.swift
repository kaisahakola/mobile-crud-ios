//
//  SearchUser.swift
//  iOSProject
//
//  Created by Kaisa Hakola on 11.5.2023.
//

import Foundation

func searchUser(search : String, users : Array<User>) -> Array<User> {
    if search.isEmpty {
        return users
    } else {
        return (users).filter { user in
            user.firstName.contains(search) || user.lastName.contains(search)
        }
    }
}
