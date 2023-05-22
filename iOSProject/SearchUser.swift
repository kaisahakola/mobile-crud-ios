//
//  SearchUser.swift
//  iOSProject
//
//  Created by Kaisa Hakola on 11.5.2023.
//

import Foundation
import Alamofire

/// A function that handles the searching of users.
///
/// The function makes a connection to the server by sending a request to the specified URL, which includes
/// the text that is typed during the searching. Any spaces are replaced with ampersands to avoid the app from crashing.
///
/// - Parameters:
///    - searchText: The text that is typed to the searchbar.
///    - callback: A closure that takes an Array of 'User' objects or 'nil' if an error occures.
func searchUser(searchText: String, callback: @escaping (Array<User>?) -> Void) {
    let fixedSearchText : String = searchText.replacingOccurrences(of: " ", with: "&")
    let url : String = "https://dummyjson.com/users/search?q=\(fixedSearchText)"
    
    /// A http GET request using Alamofire to make a connection to the server using a specified URL.
    AF.request(url).responseDecodable(of: Result.self) { response in
        print(response)
        switch response.result {
        case .success(let value):
            callback(value.users)
        case .failure(let error):
            print(error)
        }
    }
}
