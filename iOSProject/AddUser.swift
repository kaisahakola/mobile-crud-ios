//
//  AddUser.swift
//  iOSProject
//
//  Created by Kaisa Hakola on 9.5.2023.
//

import Foundation
import Alamofire

/// A function that is used to add new users to the server.
///
/// This function sends a POST request to the server with the provided user details
/// as parameters. The response form the server is printed to console along with
/// the deserialized 'User' object.
///
/// - Parameters:
///     - firstName: The first name of the user.
///     - lastName: The last name of the user.
///     - email: The email address of the user.

func addUser(firstName: String, lastName: String, email: String) {
 
    let params = [
        "firstName": firstName,
        "lastName": lastName,
        "email": email
    ]
    
    let url : String = "https://dummyjson.com/users/add"

    /// A http POST request using Alamofire to make a connection to the server using a specified URL.
    AF.request(url, method: .post, parameters: params).response { response in
        print(response)
        let json = response.data
        
        /// Parsing the response data JSON using JSONDecoder.
        do {
            let jsonDecoder = JSONDecoder()
            let user : User = try jsonDecoder.decode(User.self, from: json!)
            print(user)
        } catch {
            print(error.localizedDescription)
        }
    }
}
