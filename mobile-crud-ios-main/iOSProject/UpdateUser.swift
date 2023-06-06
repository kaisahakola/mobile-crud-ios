//
//  UpdateUser.swift
//  iOSProject
//
//  Created by Kaisa Hakola on 19.5.2023.
//

import Foundation
import Alamofire

/// A function used to edit and update users.
///
/// The function uses the 'User' objects id to select and display correct info,
/// which can then be edited and updated. The new info is then sent to
/// the server with a PUT request.
///
/// - Parameters:
///    - user: A 'User' object that is selected from the
///    list of users for editing.
func updateUser(user: User) {
    
    let firstName : String = user.firstName
    let lastName : String = user.lastName
    let id : Int = user.id
    let email : String = user.email
    
    let url : String = "https://dummyjson.com/users/\(id)"
    
    let params = [
        "firstName": firstName,
        "lastName": lastName,
        "email": email
    ]
    
    // A http PUT request made with Alamofire to make a connection to the
    // server using a specified URL.
    AF.request(url, method: .put, parameters: params).response { response in
        print(response)
        let json = response.data
        
        // Parsing the response data JSON using JSONDecoder.
        do {
            let jsonDecoder = JSONDecoder()
            let user : User = try jsonDecoder.decode(User.self, from: json!)
            print(user)
        } catch {
            print(error.localizedDescription)
        }
    }
}
