//
//  UpdateUser.swift
//  iOSProject
//
//  Created by Kaisa Hakola on 19.5.2023.
//

import Foundation
import Alamofire

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
    
    AF.request(url, method: .put, parameters: params).response { response in
        print(response)
        let json = response.data
        
        do {
            let jsonDecoder = JSONDecoder()
            let user : User = try jsonDecoder.decode(User.self, from: json!)
            print(user)
        } catch {
            print(error.localizedDescription)
        }
    }
}
