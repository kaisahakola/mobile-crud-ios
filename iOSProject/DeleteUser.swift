//
//  DeleteUser.swift
//  iOSProject
//
//  Created by Kaisa Hakola on 11.5.2023.
//

import Foundation
import Alamofire

func deleteUser(id: Int) {
    // Sendin Delete request by using the users id.
    let url = "https://dummyjson.com/users/\(id)"
    AF.request(url, method: .delete).response { response in
        print(response)
    }
}
