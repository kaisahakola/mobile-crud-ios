//
//  DeleteUser.swift
//  iOSProject
//
//  Created by Kaisa Hakola on 11.5.2023.
//

import Foundation
import Alamofire

/// A function that is used to delete users.
///
/// The function uses the 'User' object's id to send a DELETE request to the server.
///
/// - Parameters:
///    - id: The 'User' objects unique id.
func deleteUser(id: Int) {
    let url = "https://dummyjson.com/users/\(id)"
    
    // An http DELETE request made with Alamofire to make a connection to the
    // server using a specified URL.
    AF.request(url, method: .delete).response { response in
        print(response)
    }
}
