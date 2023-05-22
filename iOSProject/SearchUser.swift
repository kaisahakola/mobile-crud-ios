//
//  SearchUser.swift
//  iOSProject
//
//  Created by Kaisa Hakola on 11.5.2023.
//

import Foundation
import Alamofire

func searchUser(searchText : String, callback : @escaping ([User]?) -> Void) {
    let fixedSearchText : String = searchText.replacingOccurrences(of: " ", with: "&")
    let url : String = "https://dummyjson.com/users/search?q=\(fixedSearchText)"
    
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
