//
//  AddUser.swift
//  iOSProject
//
//  Created by Kaisa Hakola on 9.5.2023.
//

import Foundation
import Alamofire

func addUser(firstName: String, lastName: String) {
    
    // Creating parameters for the new users first and last names
    let params = [
        "firstName": firstName,
        "lastName": lastName
    ]
    
    let url : String = "https://dummyjson.com/users/add"
    
    // Using Alamofires POST method to add new user
    AF.request(url, method: .post, parameters: params).response { response in
        print(response)
        let json = response.data
        
        // Using JSONDecoder to parse the json data
        do {
            let jsonDecoder = JSONDecoder()
            let user : User = try jsonDecoder.decode(User.self, from: json!)
            print(user)
        } catch {
            print(error.localizedDescription)
        }
    }
}
