//
//  FetchAll.swift
//  iOSProject
//
//  Created by Kaisa Hakola on 9.5.2023.
//

import Foundation
import Alamofire

/// A function that is used to fetch all user data from the server.
///
/// The function makes a connection to the server using Alamofire. It receives a list
/// of users which is then passed to the callback closure.
///
/// - Parameters:
///    - callback: A closure that receives an Array of 'User' object or 'nil if an error occurs.
func fetchData(callback : @escaping (_ users: Array<User>?) -> Void) {
    let url : String = "https://dummyjson.com/users"
    
    /// A http GET request using Alamofire to make a connection to the server using a specified URL.
    AF.request(url).responseDecodable(of: Result.self) { response in
        switch response.result {
        case .success(let value):
            callback(value.users)
        case .failure(let error):
            print(error)
            callback(nil)
        }
    }
}
